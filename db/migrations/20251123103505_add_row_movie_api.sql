-- migrate:up
CREATE TABLE raw_movie_api (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    movie_external_id VARCHAR(255),
    payload JSONB NOT NULL,              
    created_at TIMESTAMPTZ DEFAULT NOW(), 
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- migrate:down

DROP TABLE IF EXISTS raw_movie_api;