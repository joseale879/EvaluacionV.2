-- ============================================
-- Datos de prueba: Airport
-- ============================================

-- Direcciones para aeropuertos
INSERT INTO address (address_id, district_id, address_line_1, postal_code) VALUES
    (gen_random_uuid(), NULL, 'El Dorado Ave', '111111'),
    (gen_random_uuid(), NULL, 'Miami Intl Blvd', '33122'),
    (gen_random_uuid(), NULL, 'Barajas s/n', '28042')
ON CONFLICT DO NOTHING;

-- Aeropuertos
INSERT INTO airport (airport_id, address_id, airport_name, iata_code, icao_code)
SELECT gen_random_uuid(), a.address_id, 'El Dorado International', 'BOG', 'SKBO'
FROM address a WHERE a.address_line_1 = 'El Dorado Ave'
ON CONFLICT (iata_code) DO NOTHING;

INSERT INTO airport (airport_id, address_id, airport_name, iata_code, icao_code)
SELECT gen_random_uuid(), a.address_id, 'Miami International', 'MIA', 'KMIA'
FROM address a WHERE a.address_line_1 = 'Miami Intl Blvd'
ON CONFLICT (iata_code) DO NOTHING;

INSERT INTO airport (airport_id, address_id, airport_name, iata_code, icao_code)
SELECT gen_random_uuid(), a.address_id, 'Adolfo Suárez Madrid-Barajas', 'MAD', 'LEMD'
FROM address a WHERE a.address_line_1 = 'Barajas s/n'
ON CONFLICT (iata_code) DO NOTHING;

-- Terminales
INSERT INTO terminal (terminal_id, airport_id, terminal_code, terminal_name)
SELECT gen_random_uuid(), a.airport_id, 'T1', 'Terminal 1'
FROM airport a WHERE a.iata_code = 'BOG'
ON CONFLICT (terminal_code) DO NOTHING;

-- Puertas de embarque
INSERT INTO boarding_gate (boarding_gate_id, terminal_id, gate_code)
SELECT gen_random_uuid(), t.terminal_id, 'G1'
FROM terminal t WHERE t.terminal_code = 'T1'
ON CONFLICT (gate_code) DO NOTHING;