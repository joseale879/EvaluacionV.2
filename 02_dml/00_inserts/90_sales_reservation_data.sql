-- ============================================
-- Datos de prueba: Sales & Reservation
-- ============================================

-- Estados de reserva
INSERT INTO reservation_status (reservation_status_id, status_code, status_name) VALUES
    (gen_random_uuid(), 'CONFIRMED', 'Confirmada'),
    (gen_random_uuid(), 'PENDING', 'Pendiente'),
    (gen_random_uuid(), 'CANCELLED', 'Cancelada'),
    (gen_random_uuid(), 'CHECKED_IN', 'Check-in realizado')
ON CONFLICT (status_code) DO NOTHING;

-- Canales de venta
INSERT INTO sale_channel (sale_channel_id, channel_code, channel_name) VALUES
    (gen_random_uuid(), 'WEB', 'Sitio web'),
    (gen_random_uuid(), 'APP', 'Aplicación móvil'),
    (gen_random_uuid(), 'COUNTER', 'Taquilla'),
    (gen_random_uuid(), 'CALL', 'Call center')
ON CONFLICT (channel_code) DO NOTHING;

-- Clases de tarifa
INSERT INTO fare_class (fare_class_id, cabin_class_id, fare_class_code, fare_class_name)
SELECT gen_random_uuid(), cc.cabin_class_id, 'Y', 'Económica estándar'
FROM cabin_class cc WHERE cc.class_code = 'ECON'
ON CONFLICT (fare_class_code) DO NOTHING;

INSERT INTO fare_class (fare_class_id, cabin_class_id, fare_class_code, fare_class_name)
SELECT gen_random_uuid(), cc.cabin_class_id, 'C', 'Business flexible'
FROM cabin_class cc WHERE cc.class_code = 'BUS'
ON CONFLICT (fare_class_code) DO NOTHING;

-- Tarifas (fares) para ruta BOG-MIA
DO $$
DECLARE
    v_airline_id uuid;
    v_origin_id uuid;
    v_dest_id uuid;
    v_fare_class_id uuid;
    v_currency_id uuid;
BEGIN
    SELECT airline_id INTO v_airline_id FROM airline WHERE airline_code = 'AV';
    SELECT airport_id INTO v_origin_id FROM airport WHERE iata_code = 'BOG';
    SELECT airport_id INTO v_dest_id FROM airport WHERE iata_code = 'MIA';
    SELECT fare_class_id INTO v_fare_class_id FROM fare_class WHERE fare_class_code = 'Y';
    SELECT currency_id INTO v_currency_id FROM currency WHERE iso_currency_code = 'COP';
    
    INSERT INTO fare (fare_id, airline_id, origin_airport_id, destination_airport_id, fare_class_id, currency_id, fare_code, base_amount, valid_from)
    VALUES (gen_random_uuid(), v_airline_id, v_origin_id, v_dest_id, v_fare_class_id, v_currency_id, 'FARE_Y_BOG_MIA', 450000, CURRENT_DATE)
    ON CONFLICT (fare_code) DO NOTHING;
END $$;

-- Estado de ticket
INSERT INTO ticket_status (ticket_status_id, status_code, status_name) VALUES
    (gen_random_uuid(), 'ISSUED', 'Emitido'),
    (gen_random_uuid(), 'USED', 'Usado'),
    (gen_random_uuid(), 'REFUNDED', 'Reembolsado')
ON CONFLICT (status_code) DO NOTHING;

-- Reserva de ejemplo para Juan Pérez
DO $$
DECLARE
    v_reservation_id uuid;
    v_person_id uuid;
    v_res_status_id uuid;
    v_sale_channel_id uuid;
BEGIN
    SELECT person_id INTO v_person_id FROM person WHERE first_name = 'Juan' AND last_name = 'Pérez';
    SELECT reservation_status_id INTO v_res_status_id FROM reservation_status WHERE status_code = 'CONFIRMED';
    SELECT sale_channel_id INTO v_sale_channel_id FROM sale_channel WHERE channel_code = 'WEB';
    
    INSERT INTO reservation (reservation_id, reservation_status_id, sale_channel_id, reservation_code, booked_at)
    VALUES (gen_random_uuid(), v_res_status_id, v_sale_channel_id, 'ABC123', CURRENT_TIMESTAMP)
    RETURNING reservation_id INTO v_reservation_id;
    
    -- Asociar pasajero a la reserva
    INSERT INTO reservation_passenger (reservation_passenger_id, reservation_id, person_id, passenger_sequence_no, passenger_type)
    VALUES (gen_random_uuid(), v_reservation_id, v_person_id, 1, 'ADULT')
    ON CONFLICT DO NOTHING;
END $$;