-- migrate:up
CREATE TABLE raw_movie_embedding (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    raw_movie_api_id UUID NOT NULL,
    embedding VECTOR(1536) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(), 
    updated_at TIMESTAMPTZ DEFAULT NOW()
);


-- migrate:down

DROP TABLE IF EXISTS raw_movie_embedding;