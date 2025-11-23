-- migrate:up
CREATE TABLE report_years (
    year INT NOT NULL,
    report_id UUID NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (year, report_id)
);

-- migrate:down

