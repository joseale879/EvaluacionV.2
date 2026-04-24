-- ============================================
-- Rollback: Datos de prueba Flight Operations
-- ============================================

-- Eliminar segmentos de vuelo y vuelos
DELETE FROM flight_segment WHERE flight_id IN (SELECT flight_id FROM flight WHERE flight_number = 'AV128');
DELETE FROM flight WHERE flight_number = 'AV128';
DELETE FROM delay_reason_type WHERE reason_code IN ('WEATHER', 'TECHNICAL', 'OPERATIONAL', 'ATC');
DELETE FROM flight_status WHERE status_code IN ('SCHEDULED', 'DEPARTED', 'ARRIVED', 'CANCELLED', 'DELAYED');