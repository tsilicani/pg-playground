-- Migration: country-subregions
-- Created at: 2024-11-10 18:52:11
-- ====  UP  ====
BEGIN;
CREATE TABLE subregions(
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name varchar(100) NOT NULL UNIQUE
);
COMMIT;

-- ==== DOWN ====
BEGIN;
DROP TABLE subregions;
COMMIT;

