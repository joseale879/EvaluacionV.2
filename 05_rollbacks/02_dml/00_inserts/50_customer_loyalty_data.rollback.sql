-- ============================================
-- Rollback: Datos de prueba Customer & Loyalty
-- ============================================

DELETE FROM loyalty_account WHERE account_number = 'LM123456';
DELETE FROM customer WHERE customer_id IN (SELECT customer_id FROM customer c JOIN person p ON c.person_id = p.person_id WHERE p.first_name IN ('Juan', 'María'));
DELETE FROM loyalty_tier WHERE tier_code IN ('BLUE', 'SILVER', 'GOLD', 'PLATINUM');
DELETE FROM loyalty_program WHERE program_code = 'LIFEMILES';
DELETE FROM benefit_type WHERE benefit_code IN ('UPGRADE', 'EXTRA_BAGGAGE', 'LOUNGE');
DELETE FROM customer_category WHERE category_code IN ('REGULAR', 'SILVER', 'GOLD', 'PLATINUM');