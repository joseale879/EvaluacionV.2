
-- Zonas horarias
INSERT INTO time_zone (time_zone_id, time_zone_name, utc_offset_minutes) VALUES
    (gen_random_uuid(), 'America/Bogota', -300),
    (gen_random_uuid(), 'America/New_York', -300),
    (gen_random_uuid(), 'Europe/Madrid', 120)
ON CONFLICT (time_zone_name) DO NOTHING;

-- Continentes
INSERT INTO continent (continent_id, continent_code, continent_name) VALUES
    (gen_random_uuid(), 'AM', 'América'),
    (gen_random_uuid(), 'EU', 'Europa'),
    (gen_random_uuid(), 'AS', 'Asia'),
    (gen_random_uuid(), 'AF', 'África'),
    (gen_random_uuid(), 'OC', 'Oceanía')
ON CONFLICT (continent_code) DO NOTHING;

-- Países
INSERT INTO country (country_id, continent_id, iso_alpha2, iso_alpha3, country_name)
SELECT gen_random_uuid(), c.continent_id, 'CO', 'COL', 'Colombia'
FROM continent c WHERE c.continent_code = 'AM'
ON CONFLICT (iso_alpha2) DO NOTHING;

INSERT INTO country (country_id, continent_id, iso_alpha2, iso_alpha3, country_name)
SELECT gen_random_uuid(), c.continent_id, 'US', 'USA', 'Estados Unidos'
FROM continent c WHERE c.continent_code = 'AM'
ON CONFLICT (iso_alpha2) DO NOTHING;

INSERT INTO country (country_id, continent_id, iso_alpha2, iso_alpha3, country_name)
SELECT gen_random_uuid(), c.continent_id, 'ES', 'ESP', 'España'
FROM continent c WHERE c.continent_code = 'EU'
ON CONFLICT (iso_alpha2) DO NOTHING;

-- Monedas
INSERT INTO currency (currency_id, iso_currency_code, currency_name, minor_units) VALUES
    (gen_random_uuid(), 'COP', 'Peso colombiano', 2),
    (gen_random_uuid(), 'USD', 'Dólar estadounidense', 2),
    (gen_random_uuid(), 'EUR', 'Euro', 2)
ON CONFLICT (iso_currency_code) DO NOTHING;