-- ============================================
-- Rollback: Datos de prueba Sales & Reservation
-- ============================================

-- Orden inverso: baggage, seat_assignment, ticket_segment, ticket, sale, reservation_passenger, reservation, fare, fare_class, etc.
DELETE FROM baggage WHERE baggage_tag IS NOT NULL;
DELETE FROM seat_assignment WHERE ticket_segment_id IN (SELECT ticket_segment_id FROM ticket_segment WHERE ticket_id IN (SELECT ticket_id FROM ticket));
DELETE FROM ticket_segment WHERE ticket_id IN (SELECT ticket_id FROM ticket);
DELETE FROM ticket;
DELETE FROM sale;
DELETE FROM reservation_passenger;
DELETE FROM reservation WHERE reservation_code = 'ABC123';
DELETE FROM fare WHERE fare_code = 'FARE_Y_BOG_MIA';
DELETE FROM fare_class WHERE fare_class_code IN ('Y', 'C');
DELETE FROM ticket_status WHERE status_code IN ('ISSUED', 'USED', 'REFUNDED');
DELETE FROM sale_channel WHERE channel_code IN ('WEB', 'APP', 'COUNTER', 'CALL');
DELETE FROM reservation_status WHERE status_code IN ('CONFIRMED', 'PENDING', 'CANCELLED', 'CHECKED_IN');