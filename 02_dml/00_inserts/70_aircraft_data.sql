-- ============================================
-- Datos de prueba: Aircraft
-- ============================================

-- Fabricantes
INSERT INTO aircraft_manufacturer (aircraft_manufacturer_id, manufacturer_name) VALUES
    (gen_random_uuid(), 'Airbus'),
    (gen_random_uuid(), 'Boeing'),
    (gen_random_uuid(), 'Embraer')
ON CONFLICT (manufacturer_name) DO NOTHING;

-- Modelos
INSERT INTO aircraft_model (aircraft_model_id, aircraft_manufacturer_id, model_code, model_name, max_range_km)
SELECT gen_random_uuid(), am.aircraft_manufacturer_id, 'A320', 'A320-200', 6150
FROM aircraft_manufacturer am WHERE am.manufacturer_name = 'Airbus'
ON CONFLICT (model_code) DO NOTHING;

INSERT INTO aircraft_model (aircraft_model_id, aircraft_manufacturer_id, model_code, model_name, max_range_km)
SELECT gen_random_uuid(), am.aircraft_manufacturer_id, 'B787', 'Boeing 787 Dreamliner', 13500
FROM aircraft_manufacturer am WHERE am.manufacturer_name = 'Boeing'
ON CONFLICT (model_code) DO NOTHING;

-- Clases de cabina
INSERT INTO cabin_class (cabin_class_id, class_code, class_name) VALUES
    (gen_random_uuid(), 'ECON', 'Económica'),
    (gen_random_uuid(), 'BUS', 'Business'),
    (gen_random_uuid(), 'FIRST', 'Primera clase')
ON CONFLICT (class_code) DO NOTHING;

-- Aeronaves (con matrícula única)
INSERT INTO aircraft (aircraft_id, airline_id, aircraft_model_id, registration_number, in_service_on)
SELECT gen_random_uuid(), a.airline_id, am.aircraft_model_id, 'HK-1234', '2020-01-01'
FROM airline a, aircraft_model am
WHERE a.airline_code = 'AV' AND am.model_code = 'A320'
ON CONFLICT (registration_number) DO NOTHING;

INSERT INTO aircraft (aircraft_id, airline_id, aircraft_model_id, registration_number, in_service_on)
SELECT gen_random_uuid(), a.airline_id, am.aircraft_model_id, 'HK-5678', '2019-06-15'
FROM airline a, aircraft_model am
WHERE a.airline_code = 'AV' AND am.model_code = 'B787'
ON CONFLICT (registration_number) DO NOTHING;

-- Configuración de cabina para un avión (ejemplo)
DO $$
DECLARE
    v_aircraft_id uuid;
    v_cabin_class_id uuid;
BEGIN
    SELECT aircraft_id INTO v_aircraft_id FROM aircraft WHERE registration_number = 'HK-1234';
    SELECT cabin_class_id INTO v_cabin_class_id FROM cabin_class WHERE class_code = 'ECON';
    INSERT INTO aircraft_cabin (aircraft_cabin_id, aircraft_id, cabin_class_id, cabin_code)
    VALUES (gen_random_uuid(), v_aircraft_id, v_cabin_class_id, 'Y')
    ON CONFLICT DO NOTHING;
END $$;