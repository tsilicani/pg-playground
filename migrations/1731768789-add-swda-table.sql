-- Migration: add-swda-table
-- Created at: 2024-11-16 15:53:09
-- ====  UP  ====
BEGIN;
-- Create ETF data table
CREATE TABLE IF NOT EXISTS swda_data(
    time timestamptz NOT NULL,
    value double precision,
    PRIMARY KEY (time)
);
-- Convert to hypertable
SELECT
    create_hypertable('swda_data', 'time', if_not_exists => TRUE);

-- Create a function that returns bollinger passing a window
CREATE OR REPLACE FUNCTION bband(n int)
    RETURNS TABLE(
        ma_time timestamptz,
        value double precision,
        ma_value double precision,
        upper_band double precision,
        lower_band double precision
    )
    AS $$
    SELECT
        time AS ma_time,
        value,
        avg(value) OVER w AS ma_value,
        avg(value) OVER w + (2 * stddev(value) OVER w) AS upper_band,
        avg(value) OVER w -(2 * stddev(value) OVER w) AS lower_band
        FROM
            swda_data
WINDOW w AS(ORDER BY time ROWS BETWEEN n PRECEDING AND CURRENT ROW);
$$
LANGUAGE SQL;

-- Grant permissions to anon role for PostgREST
GRANT SELECT ON swda_data TO anon;
COMMIT;

-- ==== DOWN ====
BEGIN;
COMMIT;

