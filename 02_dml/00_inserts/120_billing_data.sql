-- ============================================
-- Datos de prueba: Billing
-- ============================================

-- Impuestos
INSERT INTO tax (tax_id, tax_code, tax_name, rate_percentage, effective_from) VALUES
    (gen_random_uuid(), 'IVA', 'Impuesto al Valor Agregado', 19.0, '2024-01-01'),
    (gen_random_uuid(), 'AIRPORT_TAX', 'Tasa aeroportuaria', 15.0, '2024-01-01')
ON CONFLICT (tax_code) DO NOTHING;

-- Estados de factura
INSERT INTO invoice_status (invoice_status_id, status_code, status_name) VALUES
    (gen_random_uuid(), 'DRAFT', 'Borrador'),
    (gen_random_uuid(), 'ISSUED', 'Emitida'),
    (gen_random_uuid(), 'PAID', 'Pagada'),
    (gen_random_uuid(), 'CANCELLED', 'Cancelada')
ON CONFLICT (status_code) DO NOTHING;

-- Tipo de cambio ejemplo (COP a USD)
INSERT INTO exchange_rate (exchange_rate_id, from_currency_id, to_currency_id, effective_date, rate_value)
SELECT gen_random_uuid(), cur_from.currency_id, cur_to.currency_id, CURRENT_DATE, 0.00025
FROM currency cur_from, currency cur_to
WHERE cur_from.iso_currency_code = 'COP' AND cur_to.iso_currency_code = 'USD'
ON CONFLICT DO NOTHING;