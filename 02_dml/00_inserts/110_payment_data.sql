-- ============================================
-- Datos de prueba: Payment
-- ============================================

-- Estados de pago
INSERT INTO payment_status (payment_status_id, status_code, status_name) VALUES
    (gen_random_uuid(), 'PENDING', 'Pendiente'),
    (gen_random_uuid(), 'AUTHORIZED', 'Autorizado'),
    (gen_random_uuid(), 'PAID', 'Pagado'),
    (gen_random_uuid(), 'FAILED', 'Fallido'),
    (gen_random_uuid(), 'REFUNDED', 'Reembolsado')
ON CONFLICT (status_code) DO NOTHING;

-- Métodos de pago
INSERT INTO payment_method (payment_method_id, method_code, method_name) VALUES
    (gen_random_uuid(), 'CC', 'Tarjeta de crédito'),
    (gen_random_uuid(), 'DC', 'Tarjeta débito'),
    (gen_random_uuid(), 'CASH', 'Efectivo'),
    (gen_random_uuid(), 'TRANSFER', 'Transferencia bancaria')
ON CONFLICT (method_code) DO NOTHING;