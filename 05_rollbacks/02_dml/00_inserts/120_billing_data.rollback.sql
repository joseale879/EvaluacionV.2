-- ============================================
-- Rollback: Datos de prueba Billing
-- ============================================

DELETE FROM exchange_rate WHERE rate_value = 0.00025;
DELETE FROM invoice_status WHERE status_code IN ('DRAFT', 'ISSUED', 'PAID', 'CANCELLED');
DELETE FROM tax WHERE tax_code IN ('IVA', 'AIRPORT_TAX');