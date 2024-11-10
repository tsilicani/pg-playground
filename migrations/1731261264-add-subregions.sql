-- Migration: add-subregions
-- Created at: 2024-11-10 18:54:24
-- ====  UP  ====
BEGIN;
INSERT INTO subregions(name)
    VALUES ('Western Europe'),
('Eastern Europe'),
('Northern Europe'),
('Southern Europe'),
('Central Europe'),
('Balkans'),
('Baltic States');
COMMIT;

-- ==== DOWN ====
BEGIN;
DELETE FROM subregions;
COMMIT;

