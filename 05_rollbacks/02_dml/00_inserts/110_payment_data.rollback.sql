-- ============================================
-- Rollback: Datos de prueba Payment
-- ============================================

DELETE FROM payment_method WHERE method_code IN ('CC', 'DC', 'CASH', 'TRANSFER');
DELETE FROM payment_status WHERE status_code IN ('PENDING', 'AUTHORIZED', 'PAID', 'FAILED', 'REFUNDED');