-- migrate:up
ALTER TABLE industrial_universe
ADD comment VARCHAR(255) NULL;

ALTER TABLE reports
ADD year INT NOT NULL;
-- migrate:down
