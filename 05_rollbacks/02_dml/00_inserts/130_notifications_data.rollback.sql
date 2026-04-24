-- ============================================
-- Rollback: Datos de prueba Notifications
-- ============================================

DELETE FROM notification_log;
DELETE FROM notification_recipient;
DELETE FROM notification;
DELETE FROM notification_type WHERE type_code IN ('FLIGHT_DELAY', 'FLIGHT_CANCELLATION', 'CHECKIN_REMINDER', 'BOARDING_READY', 'PAYMENT_CONFIRMATION', 'MILES_EARNED', 'RESERVATION_CONFIRMATION');