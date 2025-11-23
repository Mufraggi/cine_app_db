-- migrate:up
CREATE TABLE refresh_password (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    token_code varchar(4) NOT NULL,
    expires_at timestamptz NOT NULL,
    created_at timestamptz DEFAULT NOW(),
    updated_at timestamptz DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- migrate:down
