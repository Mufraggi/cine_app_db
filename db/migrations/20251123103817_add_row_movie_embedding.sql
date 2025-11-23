-- migrate:up
CREATE TABLE raw_movie_embedding (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    movie_external_id VARCHAR(256),
    input_text TEXT NOT NULL,
    embedding VECTOR(1536) NOT NULL,
    embedded_at TIMESTAMPTZ DEFAULT NOW()
);


-- migrate:down

DROP TABLE IF EXISTS raw_movie_embedding;