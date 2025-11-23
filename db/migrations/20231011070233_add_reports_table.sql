-- migrate:up
CREATE TABLE reports (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    semester INT NOT NULL,
    start_date DATE,
    end_date DATE NULL,
    comment TEXT,
    created_at timestamptz DEFAULT NOW(),
    updated_at timestamptz DEFAULT NOW(),
    is_close boolean DEFAULT false
);
-- migrate:down