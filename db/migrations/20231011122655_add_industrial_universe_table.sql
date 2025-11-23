-- migrate:up
CREATE TABLE industrial_universe (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255),
    report_id UUID REFERENCES reports(id) ON DELETE CASCADE,
    turnover INT,
    material_custom_percent INT NULL,
    weight_labor INT,
    weight_material INT,
    weight_transport INT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    driver_material INT
);
-- migrate:down