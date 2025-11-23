-- migrate:up
CREATE TABLE office_production (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255),
    industrial_universe_id UUID REFERENCES industrial_universe(id) ON DELETE CASCADE,
    labor_custom_percent INT NULL,
    transport_custom_percent INT NULL,
    turnover INT,
    driver_transport INT,
    driver_labor INT,
    currency_name VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
-- migrate:down