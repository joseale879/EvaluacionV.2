-- ============================================
-- Rollback: Datos de prueba Airport
-- ============================================

-- Las puertas dependen de terminales, terminales de aeropuertos, aeropuertos de direcciones
DELETE FROM boarding_gate WHERE gate_code = 'G1';
DELETE FROM terminal WHERE terminal_code = 'T1';
DELETE FROM airport WHERE iata_code IN ('BOG', 'MIA', 'MAD');
DELETE FROM address WHERE address_line_1 IN ('El Dorado Ave', 'Miami Intl Blvd', 'Barajas s/n');