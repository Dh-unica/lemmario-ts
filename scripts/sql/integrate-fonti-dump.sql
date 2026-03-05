-- Script di integrazione fonti - Produzione
-- Generato il 2026-03-05
-- Operazioni:
--   1. Aggiunge colonne anno_inizio, anno_fine, data_circa a fonti
--   2. Popola i nuovi campi per tutte le fonti
--   3. Disambigua titoli fonti 173/174
--   4. Riassegna ricorrenze_rels da duplicati e li elimina
--   5. Elimina fonti orfane (0 referenze)

BEGIN;

-- ============================================================
-- 1. SCHEMA: Aggiungere nuove colonne a fonti
-- ============================================================
ALTER TABLE fonti ADD COLUMN IF NOT EXISTS anno_inizio numeric;
ALTER TABLE fonti ADD COLUMN IF NOT EXISTS anno_fine numeric;
ALTER TABLE fonti ADD COLUMN IF NOT EXISTS data_circa boolean DEFAULT false;

-- ============================================================
-- 2. DATI: Popolare nuove colonne per tutte le fonti
--    ID 154 corretto: anno_inizio 1450 -> 1350
-- ============================================================
UPDATE fonti SET anno_inizio = 1339, anno_fine = NULL, data_circa = false WHERE id = 87;
UPDATE fonti SET anno_inizio = 1338, anno_fine = 1345, data_circa = false WHERE id = 89;
UPDATE fonti SET anno_inizio = 1338, anno_fine = 1345, data_circa = false WHERE id = 90;
UPDATE fonti SET anno_inizio = 1324, anno_fine = NULL, data_circa = false WHERE id = 92;
UPDATE fonti SET anno_inizio = 1300, anno_fine = 1349, data_circa = false WHERE id = 93;
UPDATE fonti SET anno_inizio = 1383, anno_fine = 1386, data_circa = false WHERE id = 94;
UPDATE fonti SET anno_inizio = 1300, anno_fine = 1349, data_circa = false WHERE id = 95;
UPDATE fonti SET anno_inizio = 1157, anno_fine = NULL, data_circa = false WHERE id = 96;
UPDATE fonti SET anno_inizio = 1300, anno_fine = 1349, data_circa = false WHERE id = 97;
UPDATE fonti SET anno_inizio = 1375, anno_fine = NULL, data_circa = false WHERE id = 98;
UPDATE fonti SET anno_inizio = 1383, anno_fine = 1386, data_circa = false WHERE id = 99;
UPDATE fonti SET anno_inizio = 1403, anno_fine = 1407, data_circa = false WHERE id = 100;
UPDATE fonti SET anno_inizio = 1342, anno_fine = 1343, data_circa = false WHERE id = 101;
UPDATE fonti SET anno_inizio = 1363, anno_fine = NULL, data_circa = false WHERE id = 102;
UPDATE fonti SET anno_inizio = 1350, anno_fine = 1400, data_circa = false WHERE id = 103;
UPDATE fonti SET anno_inizio = 1464, anno_fine = NULL, data_circa = false WHERE id = 104;
UPDATE fonti SET anno_inizio = 1450, anno_fine = 1500, data_circa = false WHERE id = 106;
UPDATE fonti SET anno_inizio = 1400, anno_fine = 1430, data_circa = false WHERE id = 107;
UPDATE fonti SET anno_inizio = 1442, anno_fine = NULL, data_circa = false WHERE id = 108;
UPDATE fonti SET anno_inizio = 1485, anno_fine = NULL, data_circa = true WHERE id = 109;
UPDATE fonti SET anno_inizio = 1494, anno_fine = NULL, data_circa = false WHERE id = 110;
UPDATE fonti SET anno_inizio = 1482, anno_fine = NULL, data_circa = false WHERE id = 111;
UPDATE fonti SET anno_inizio = 1450, anno_fine = NULL, data_circa = true WHERE id = 112;
UPDATE fonti SET anno_inizio = 1450, anno_fine = NULL, data_circa = true WHERE id = 113;
UPDATE fonti SET anno_inizio = 1420, anno_fine = NULL, data_circa = true WHERE id = 114;
UPDATE fonti SET anno_inizio = 1450, anno_fine = NULL, data_circa = true WHERE id = 115;
UPDATE fonti SET anno_inizio = 1500, anno_fine = NULL, data_circa = true WHERE id = 116;
UPDATE fonti SET anno_inizio = 1479, anno_fine = NULL, data_circa = false WHERE id = 117;
UPDATE fonti SET anno_inizio = 1450, anno_fine = NULL, data_circa = true WHERE id = 118;
UPDATE fonti SET anno_inizio = 1330, anno_fine = 1350, data_circa = false WHERE id = 120;
UPDATE fonti SET anno_inizio = 1507, anno_fine = NULL, data_circa = false WHERE id = 121;
UPDATE fonti SET anno_inizio = 1480, anno_fine = NULL, data_circa = true WHERE id = 122;
UPDATE fonti SET anno_inizio = 1465, anno_fine = NULL, data_circa = true WHERE id = 123;
UPDATE fonti SET anno_inizio = 1450, anno_fine = NULL, data_circa = true WHERE id = 124;
UPDATE fonti SET anno_inizio = 1307, anno_fine = NULL, data_circa = false WHERE id = 125;
UPDATE fonti SET anno_inizio = 1400, anno_fine = 1420, data_circa = false WHERE id = 126;
UPDATE fonti SET anno_inizio = 1461, anno_fine = NULL, data_circa = false WHERE id = 127;
UPDATE fonti SET anno_inizio = 1465, anno_fine = NULL, data_circa = true WHERE id = 128;
UPDATE fonti SET anno_inizio = 1398, anno_fine = NULL, data_circa = false WHERE id = 129;
UPDATE fonti SET anno_inizio = 1485, anno_fine = NULL, data_circa = true WHERE id = 130;
UPDATE fonti SET anno_inizio = 1403, anno_fine = 1407, data_circa = false WHERE id = 152;
UPDATE fonti SET anno_inizio = 1323, anno_fine = NULL, data_circa = false WHERE id = 153;
UPDATE fonti SET anno_inizio = 1350, anno_fine = 1360, data_circa = true WHERE id = 154;
UPDATE fonti SET anno_inizio = NULL, anno_fine = NULL, data_circa = false WHERE id = 155;
UPDATE fonti SET anno_inizio = NULL, anno_fine = NULL, data_circa = false WHERE id = 156;
UPDATE fonti SET anno_inizio = 1354, anno_fine = 1368, data_circa = false WHERE id = 157;
UPDATE fonti SET anno_inizio = 1300, anno_fine = 1399, data_circa = false WHERE id = 159;
UPDATE fonti SET anno_inizio = 1385, anno_fine = NULL, data_circa = false WHERE id = 161;
UPDATE fonti SET anno_inizio = 1434, anno_fine = NULL, data_circa = false WHERE id = 162;
UPDATE fonti SET anno_inizio = 1375, anno_fine = 1399, data_circa = false WHERE id = 164;
UPDATE fonti SET anno_inizio = 1375, anno_fine = 1424, data_circa = false WHERE id = 165;
UPDATE fonti SET anno_inizio = 1375, anno_fine = 1399, data_circa = false WHERE id = 166;
UPDATE fonti SET anno_inizio = 1460, anno_fine = NULL, data_circa = true WHERE id = 167;
UPDATE fonti SET anno_inizio = 1418, anno_fine = 1421, data_circa = true WHERE id = 168;
UPDATE fonti SET anno_inizio = 1250, anno_fine = NULL, data_circa = false WHERE id = 169;
UPDATE fonti SET anno_inizio = 1348, anno_fine = 1350, data_circa = false WHERE id = 170;
UPDATE fonti SET anno_inizio = 1352, anno_fine = 1358, data_circa = false WHERE id = 171;
UPDATE fonti SET anno_inizio = 1355, anno_fine = NULL, data_circa = false WHERE id = 173;
UPDATE fonti SET anno_inizio = 1355, anno_fine = NULL, data_circa = false WHERE id = 174;
-- ID 88 (Stat.fornai.1337) non presente nel dump, aggiunto manualmente
UPDATE fonti SET anno_inizio = 1337, anno_fine = NULL, data_circa = false WHERE id = 88;

-- ============================================================
-- 3. TITOLI: Disambiguare fonti 173 e 174
-- ============================================================
UPDATE fonti SET titolo = 'Statuti della Repubblica fiorentina, Capitano' WHERE id = 173;
UPDATE fonti SET titolo = E'Statuti della Repubblica fiorentina, Podest\u00e0' WHERE id = 174;

-- ============================================================
-- 4. UNIFICAZIONE DUPLICATI: Riassegnare ricorrenze_rels
-- ============================================================
-- 4a. Fonte 90 (Stat.Correggiai) -> 89 (Stat.correggiai.1338): 1 ref
UPDATE ricorrenze_rels SET fonti_id = 89 WHERE fonti_id = 90 AND path = 'fonte';
-- 4b. Fonte 91 (Stat.rigattieri.1324) -> 92 (Stat.Rigattieri): 93 refs
UPDATE ricorrenze_rels SET fonti_id = 92 WHERE fonti_id = 91 AND path = 'fonte';
-- 4c. Fonte 119 (Prova_lucca) -> 120 (Libro_molte_ragioni_abaco): 1 ref
UPDATE ricorrenze_rels SET fonti_id = 120 WHERE fonti_id = 119 AND path = 'fonte';

-- ============================================================
-- 5. SAFETY CHECK: Nessuna ref residua verso fonti da eliminare
-- ============================================================
DO $$
DECLARE remaining_refs integer;
BEGIN
  SELECT count(*) INTO remaining_refs FROM ricorrenze_rels
  WHERE fonti_id IN (90, 91, 119, 105, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151);
  IF remaining_refs > 0 THEN
    RAISE EXCEPTION 'ABORT: % refs ancora presenti verso fonti da eliminare', remaining_refs;
  END IF;
END $$;

-- ============================================================
-- 6. ELIMINARE FONTI duplicate (dopo riassegnamento) e orfane
-- ============================================================
DELETE FROM fonti WHERE id IN (90, 91, 119);
DELETE FROM fonti WHERE id IN (105, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151);

-- ============================================================
-- 7. REGISTRARE MIGRAZIONE in Payload
-- ============================================================
INSERT INTO payload_migrations (name, batch, created_at, updated_at)
VALUES ('20260305_150000',
        (SELECT COALESCE(MAX(batch), 0) + 1 FROM payload_migrations),
        NOW(), NOW());

-- ============================================================
-- 8. VERIFICA FINALE
-- ============================================================
DO $$
DECLARE fc integer; rc integer; rfc integer;
BEGIN
  SELECT count(*) INTO fc FROM fonti;
  SELECT count(*) INTO rc FROM ricorrenze_rels;
  SELECT count(*) INTO rfc FROM ricorrenze_rels WHERE path = 'fonte';
  RAISE NOTICE 'Fonti totali: % (atteso: 62)', fc;
  RAISE NOTICE 'Ricorrenze_rels totali: % (atteso: 1712)', rc;
  RAISE NOTICE 'Ricorrenze_rels fonte: % (atteso: 856)', rfc;
END $$;

COMMIT;
