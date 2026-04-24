-- ============================================
-- Rollback: Datos de prueba Identity
-- ============================================

-- Las personas se eliminan en orden inverso (contactos, documentos, luego la persona)
DELETE FROM person_contact WHERE person_id IN (SELECT person_id FROM person WHERE first_name IN ('Juan', 'María', 'Carlos', 'Ana'));
DELETE FROM person_document WHERE person_id IN (SELECT person_id FROM person WHERE first_name IN ('Juan', 'María', 'Carlos', 'Ana'));
DELETE FROM person WHERE first_name IN ('Juan', 'María', 'Carlos', 'Ana');

DELETE FROM contact_type WHERE type_code IN ('EMAIL', 'PHONE', 'MOBILE');
DELETE FROM document_type WHERE type_code IN ('CC', 'CE', 'PAS', 'NIT');
DELETE FROM person_type WHERE type_code IN ('CUST', 'EMPL', 'PILOT', 'CREW');