-- Migration: add-swda-table
-- Created at: 2024-11-16 15:53:09
-- ====  UP  ====

BEGIN;

-- Create ETF data table
CREATE TABLE IF NOT EXISTS swda_data (
    time TIMESTAMPTZ NOT NULL,
    close DOUBLE PRECISION,
    PRIMARY KEY (time)
);

-- Convert to hypertable
SELECT create_hypertable('swda_data', 'time', if_not_exists => TRUE);

-- Grant permissions to anon role for PostgREST
GRANT SELECT ON swda_data TO anon;

COMMIT;

-- ==== DOWN ====

BEGIN;

COMMIT;
