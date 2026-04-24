-- ============================================
-- Datos de prueba: Airline
-- ============================================

INSERT INTO airline (airline_id, home_country_id, airline_code, airline_name, iata_code, icao_code, is_active)
SELECT gen_random_uuid(), c.country_id, 'AV', 'Avianca', 'AV', 'AVA', true
FROM country c WHERE c.iso_alpha2 = 'CO'
ON CONFLICT (airline_code) DO NOTHING;

INSERT INTO airline (airline_id, home_country_id, airline_code, airline_name, iata_code, icao_code, is_active)
SELECT gen_random_uuid(), c.country_id, 'AA', 'American Airlines', 'AA', 'AAL', true
FROM country c WHERE c.iso_alpha2 = 'US'
ON CONFLICT (airline_code) DO NOTHING;

INSERT INTO airline (airline_id, home_country_id, airline_code, airline_name, iata_code, icao_code, is_active)
SELECT gen_random_uuid(), c.country_id, 'IB', 'Iberia', 'IB', 'IBE', true
FROM country c WHERE c.iso_alpha2 = 'ES'
ON CONFLICT (airline_code) DO NOTHING;