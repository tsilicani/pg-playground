-- Migration: add-uuid
-- Created at: 2024-11-10 18:50:53
-- ====  UP  ====
BEGIN;
-- Install UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
COMMIT;

-- ==== DOWN ====
BEGIN;
DROP EXTENSION IF EXISTS "uuid-ossp";
COMMIT;

