-- ============================================
-- Rollback: Datos de prueba Boarding
-- ============================================

DELETE FROM check_in_status WHERE status_code IN ('PENDING', 'COMPLETED', 'SKIPPED');
DELETE FROM boarding_group WHERE group_code IN ('A', 'B', 'C', 'D');