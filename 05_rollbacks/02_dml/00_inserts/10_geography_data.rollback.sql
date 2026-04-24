-- ============================================
-- Rollback: Datos de prueba Geography
-- ============================================

DELETE FROM currency WHERE iso_currency_code IN ('COP', 'USD', 'EUR');
DELETE FROM country WHERE iso_alpha2 IN ('CO', 'US', 'ES');
DELETE FROM continent WHERE continent_code IN ('AM', 'EU', 'AS', 'AF', 'OC');
DELETE FROM time_zone WHERE time_zone_name IN ('America/Bogota', 'America/New_York', 'Europe/Madrid');