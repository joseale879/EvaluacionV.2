-- ============================================
-- Rollback: Datos de prueba Aircraft
-- ============================================

DELETE FROM aircraft_cabin WHERE cabin_code = 'Y';
DELETE FROM aircraft WHERE registration_number IN ('HK-1234', 'HK-5678');
DELETE FROM cabin_class WHERE class_code IN ('ECON', 'BUS', 'FIRST');
DELETE FROM aircraft_model WHERE model_code IN ('A320', 'B787');
DELETE FROM aircraft_manufacturer WHERE manufacturer_name IN ('Airbus', 'Boeing', 'Embraer');