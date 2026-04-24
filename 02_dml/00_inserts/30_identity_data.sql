-- ============================================
-- Datos de prueba: Identity (personas, documentos, contactos)
-- ============================================

-- Tipos de persona
INSERT INTO person_type (person_type_id, type_code, type_name) VALUES
    (gen_random_uuid(), 'CUST', 'Cliente'),
    (gen_random_uuid(), 'EMPL', 'Empleado'),
    (gen_random_uuid(), 'PILOT', 'Piloto'),
    (gen_random_uuid(), 'CREW', 'Tripulante')
ON CONFLICT (type_code) DO NOTHING;

-- Tipos de documento
INSERT INTO document_type (document_type_id, type_code, type_name) VALUES
    (gen_random_uuid(), 'CC', 'Cédula de ciudadanía'),
    (gen_random_uuid(), 'CE', 'Cédula de extranjería'),
    (gen_random_uuid(), 'PAS', 'Pasaporte'),
    (gen_random_uuid(), 'NIT', 'NIT')
ON CONFLICT (type_code) DO NOTHING;

-- Tipos de contacto
INSERT INTO contact_type (contact_type_id, type_code, type_name) VALUES
    (gen_random_uuid(), 'EMAIL', 'Correo electrónico'),
    (gen_random_uuid(), 'PHONE', 'Teléfono'),
    (gen_random_uuid(), 'MOBILE', 'Celular')
ON CONFLICT (type_code) DO NOTHING;

-- Personas (clientes y empleados)
INSERT INTO person (person_id, person_type_id, first_name, last_name, gender_code)
SELECT gen_random_uuid(), pt.person_type_id, 'Juan', 'Pérez', 'M'
FROM person_type pt WHERE pt.type_code = 'CUST'
ON CONFLICT DO NOTHING;

INSERT INTO person (person_id, person_type_id, first_name, last_name, gender_code)
SELECT gen_random_uuid(), pt.person_type_id, 'María', 'Gómez', 'F'
FROM person_type pt WHERE pt.type_code = 'CUST'
ON CONFLICT DO NOTHING;

INSERT INTO person (person_id, person_type_id, first_name, last_name, gender_code)
SELECT gen_random_uuid(), pt.person_type_id, 'Carlos', 'López', 'M'
FROM person_type pt WHERE pt.type_code = 'EMPL'
ON CONFLICT DO NOTHING;

INSERT INTO person (person_id, person_type_id, first_name, last_name, gender_code)
SELECT gen_random_uuid(), pt.person_type_id, 'Ana', 'Martínez', 'F'
FROM person_type pt WHERE pt.type_code = 'PILOT'
ON CONFLICT DO NOTHING;