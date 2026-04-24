-- ============================================
-- Datos de prueba: Customer & Loyalty
-- ============================================

-- Categorías de cliente
INSERT INTO customer_category (customer_category_id, category_code, category_name) VALUES
    (gen_random_uuid(), 'REGULAR', 'Regular'),
    (gen_random_uuid(), 'SILVER', 'Silver'),
    (gen_random_uuid(), 'GOLD', 'Gold'),
    (gen_random_uuid(), 'PLATINUM', 'Platinum')
ON CONFLICT (category_code) DO NOTHING;

-- Tipos de beneficio
INSERT INTO benefit_type (benefit_type_id, benefit_code, benefit_name) VALUES
    (gen_random_uuid(), 'UPGRADE', 'Upgrade de clase'),
    (gen_random_uuid(), 'EXTRA_BAGGAGE', 'Equipaje extra'),
    (gen_random_uuid(), 'LOUNGE', 'Acceso a sala VIP')
ON CONFLICT (benefit_code) DO NOTHING;

-- Programa de lealtad (para Avianca)
INSERT INTO loyalty_program (loyalty_program_id, airline_id, default_currency_id, program_code, program_name, expiration_months)
SELECT gen_random_uuid(), a.airline_id, c.currency_id, 'LIFEMILES', 'LifeMiles', 12
FROM airline a, currency c
WHERE a.airline_code = 'AV' AND c.iso_currency_code = 'COP'
ON CONFLICT (program_code) DO NOTHING;

-- Niveles del programa
DO $$
DECLARE
    v_program_id uuid;
BEGIN
    SELECT loyalty_program_id INTO v_program_id FROM loyalty_program WHERE program_code = 'LIFEMILES';
    INSERT INTO loyalty_tier (loyalty_tier_id, loyalty_program_id, tier_code, tier_name, priority_level, required_miles) VALUES
        (gen_random_uuid(), v_program_id, 'BLUE', 'Blue', 1, 0),
        (gen_random_uuid(), v_program_id, 'SILVER', 'Silver', 2, 20000),
        (gen_random_uuid(), v_program_id, 'GOLD', 'Gold', 3, 50000),
        (gen_random_uuid(), v_program_id, 'PLATINUM', 'Platinum', 4, 100000)
    ON CONFLICT (tier_code) DO NOTHING;
END $$;

-- Clientes (asociar personas tipo CUST con aerolínea)
INSERT INTO customer (customer_id, airline_id, person_id, customer_category_id)
SELECT gen_random_uuid(), a.airline_id, p.person_id, cc.customer_category_id
FROM airline a, person p, customer_category cc
WHERE a.airline_code = 'AV'
  AND p.first_name IN ('Juan', 'María')
  AND cc.category_code = 'REGULAR'
ON CONFLICT DO NOTHING;

-- Cuentas de lealtad
DO $$
DECLARE
    v_customer_id uuid;
    v_program_id uuid;
BEGIN
    SELECT customer_id INTO v_customer_id FROM customer c JOIN person p ON c.person_id = p.person_id WHERE p.first_name = 'Juan';
    SELECT loyalty_program_id INTO v_program_id FROM loyalty_program WHERE program_code = 'LIFEMILES';
    INSERT INTO loyalty_account (loyalty_account_id, customer_id, loyalty_program_id, account_number)
    VALUES (gen_random_uuid(), v_customer_id, v_program_id, 'LM123456')
    ON CONFLICT (account_number) DO NOTHING;
END $$;