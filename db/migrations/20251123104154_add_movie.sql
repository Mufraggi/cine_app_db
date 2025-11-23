-- migrate:up
CREATE TABLE movie (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    imdb_id VARCHAR(256) NOT NULL,        -- IMDB ID
    type TEXT NOT NULL,
    primary_title TEXT NOT NULL,
    original_title TEXT,
    primary_image JSONB,        -- peut contenir height, width, url
    start_year INT,
    runtime_seconds INT,
    genres TEXT[] NOT NULL,
    rating JSONB,               -- { score, count }
    plot TEXT NOT NULL,

    embedding VECTOR(1536),     -- vector PGVECTOR
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX movie_embedding_idx
ON movie
USING hnsw (embedding vector_l2_ops);

-- migrate:down

DROP TABLE IF EXISTS movie;