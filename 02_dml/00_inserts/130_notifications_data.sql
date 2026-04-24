-- ============================================
-- Datos de prueba: Notifications (ADR-001)
-- ============================================

-- Tipos de notificación
INSERT INTO notification_type (notification_type_id, type_code, type_name, description) VALUES
    (gen_random_uuid(), 'FLIGHT_DELAY', 'Retraso de vuelo', 'Notificación cuando un vuelo sufre retraso'),
    (gen_random_uuid(), 'FLIGHT_CANCELLATION', 'Cancelación de vuelo', 'Notificación de cancelación'),
    (gen_random_uuid(), 'CHECKIN_REMINDER', 'Recordatorio de check-in', 'Recordatorio para realizar check-in'),
    (gen_random_uuid(), 'BOARDING_READY', 'Abordaje disponible', 'Aviso de puerta de embarque abierta'),
    (gen_random_uuid(), 'PAYMENT_CONFIRMATION', 'Confirmación de pago', 'Pago exitoso'),
    (gen_random_uuid(), 'MILES_EARNED', 'Millas acreditadas', 'Notificación de acreditación de millas'),
    (gen_random_uuid(), 'RESERVATION_CONFIRMATION', 'Confirmación de reserva', 'Reserva creada/modificada')
ON CONFLICT (type_code) DO NOTHING;

-- Notificaciones de ejemplo (asociadas a personas y clientes existentes)
DO $$
DECLARE
    v_person_id uuid;
    v_customer_id uuid;
    v_notification_type_id uuid;
    v_notification_id uuid;
BEGIN
    -- Obtener persona y cliente de Juan Pérez
    SELECT person_id INTO v_person_id FROM person WHERE first_name = 'Juan' AND last_name = 'Pérez' LIMIT 1;
    SELECT customer_id INTO v_customer_id FROM customer WHERE person_id = v_person_id LIMIT 1;
    
    -- Notificación de confirmación de reserva
    SELECT notification_type_id INTO v_notification_type_id FROM notification_type WHERE type_code = 'RESERVATION_CONFIRMATION';
    INSERT INTO notification (notification_id, notification_type_id, channel, subject, body, status, scheduled_at)
    VALUES (gen_random_uuid(), v_notification_type_id, 'EMAIL', 'Tu reserva ha sido confirmada', 
            'Hola Juan, tu vuelo AV128 ha sido confirmado.', 'SENT', CURRENT_TIMESTAMP)
    RETURNING notification_id INTO v_notification_id;
    
    -- Destinatario de la notificación
    INSERT INTO notification_recipient (notification_recipient_id, notification_id, person_id, customer_id, recipient_email)
    VALUES (gen_random_uuid(), v_notification_id, v_person_id, v_customer_id, 'juan.perez@example.com')
    ON CONFLICT DO NOTHING;
    
    -- Log de envío
    INSERT INTO notification_log (notification_log_id, notification_id, action, action_at, metadata)
    VALUES (gen_random_uuid(), v_notification_id, 'SEND', CURRENT_TIMESTAMP, '{"provider":"sendgrid","message_id":"abc123"}')
    ON CONFLICT DO NOTHING;
    
    -- Notificación de retraso de vuelo
    SELECT notification_type_id INTO v_notification_type_id FROM notification_type WHERE type_code = 'FLIGHT_DELAY';
    INSERT INTO notification (notification_id, notification_type_id, channel, subject, body, status, scheduled_at)
    VALUES (gen_random_uuid(), v_notification_type_id, 'PUSH', 'Retraso en tu vuelo AV128', 
            'El vuelo AV128 con destino a Miami ha sido retrasado 30 minutos.', 'PENDING', CURRENT_TIMESTAMP + INTERVAL '1 hour')
    RETURNING notification_id INTO v_notification_id;
    
    INSERT INTO notification_recipient (notification_recipient_id, notification_id, person_id, customer_id, recipient_email)
    VALUES (gen_random_uuid(), v_notification_id, v_person_id, v_customer_id, 'juan.perez@example.com')
    ON CONFLICT DO NOTHING;
    
    -- Notificación de millas acreditadas (para María Gómez)
    SELECT person_id INTO v_person_id FROM person WHERE first_name = 'María' AND last_name = 'Gómez' LIMIT 1;
    SELECT customer_id INTO v_customer_id FROM customer WHERE person_id = v_person_id LIMIT 1;
    SELECT notification_type_id INTO v_notification_type_id FROM notification_type WHERE type_code = 'MILES_EARNED';
    INSERT INTO notification (notification_id, notification_type_id, channel, subject, body, status, scheduled_at)
    VALUES (gen_random_uuid(), v_notification_type_id, 'EMAIL', 'Has ganado millas', 
            'María, has acumulado 500 millas por tu reciente vuelo.', 'SENT', CURRENT_TIMESTAMP)
    RETURNING notification_id INTO v_notification_id;
    
    INSERT INTO notification_recipient (notification_recipient_id, notification_id, person_id, customer_id, recipient_email)
    VALUES (gen_random_uuid(), v_notification_id, v_person_id, v_customer_id, 'maria.gomez@example.com')
    ON CONFLICT DO NOTHING;
END $$;