-- Migration: create_euro_countries_table
-- Created at: 2024-11-10 18:02:09
-- ====  UP  ====
BEGIN;
CREATE TABLE european_economies(
    country varchar(100) PRIMARY KEY,
    gdp numeric,
    gdp_year_over_year numeric,
    gdp_quarter_over_quarter numeric,
    interest_rate numeric,
    inflation_rate numeric,
    jobless_rate numeric,
    gov_budget numeric,
    debt_to_gdp numeric,
    current_account numeric,
    population numeric
);
COMMIT;

-- ==== DOWN ====
BEGIN;
DROP TABLE european_economies;
COMMIT;

