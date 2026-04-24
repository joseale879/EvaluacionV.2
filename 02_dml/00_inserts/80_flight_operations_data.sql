-- ============================================
-- Datos de prueba: Flight Operations
-- ============================================

-- Estados de vuelo
INSERT INTO flight_status (flight_status_id, status_code, status_name) VALUES
    (gen_random_uuid(), 'SCHEDULED', 'Programado'),
    (gen_random_uuid(), 'DEPARTED', 'Despegado'),
    (gen_random_uuid(), 'ARRIVED', 'Llegado'),
    (gen_random_uuid(), 'CANCELLED', 'Cancelado'),
    (gen_random_uuid(), 'DELAYED', 'Retrasado')
ON CONFLICT (status_code) DO NOTHING;

-- Tipos de razón de retraso
INSERT INTO delay_reason_type (delay_reason_type_id, reason_code, reason_name) VALUES
    (gen_random_uuid(), 'WEATHER', 'Clima adverso'),
    (gen_random_uuid(), 'TECHNICAL', 'Problemas técnicos'),
    (gen_random_uuid(), 'OPERATIONAL', 'Operaciones'),
    (gen_random_uuid(), 'ATC', 'Control de tráfico aéreo')
ON CONFLICT (reason_code) DO NOTHING;

-- Vuelo de ejemplo BOG-MIA
DO $$
DECLARE
    v_airline_id uuid;
    v_aircraft_id uuid;
    v_status_id uuid;
    v_flight_id uuid;
    v_origin_id uuid;
    v_dest_id uuid;
BEGIN
    SELECT airline_id INTO v_airline_id FROM airline WHERE airline_code = 'AV';
    SELECT aircraft_id INTO v_aircraft_id FROM aircraft WHERE registration_number = 'HK-1234';
    SELECT flight_status_id INTO v_status_id FROM flight_status WHERE status_code = 'SCHEDULED';
    SELECT airport_id INTO v_origin_id FROM airport WHERE iata_code = 'BOG';
    SELECT airport_id INTO v_dest_id FROM airport WHERE iata_code = 'MIA';
    
    INSERT INTO flight (flight_id, airline_id, aircraft_id, flight_status_id, flight_number, service_date)
    VALUES (gen_random_uuid(), v_airline_id, v_aircraft_id, v_status_id, 'AV128', CURRENT_DATE + 1)
    RETURNING flight_id INTO v_flight_id;
    
    INSERT INTO flight_segment (flight_segment_id, flight_id, origin_airport_id, destination_airport_id, segment_number, scheduled_departure_at, scheduled_arrival_at)
    VALUES (gen_random_uuid(), v_flight_id, v_origin_id, v_dest_id, 1, 
            (CURRENT_DATE + 1) + TIME '07:00:00', 
            (CURRENT_DATE + 1) + TIME '11:00:00')
    ON CONFLICT DO NOTHING;
END $$;