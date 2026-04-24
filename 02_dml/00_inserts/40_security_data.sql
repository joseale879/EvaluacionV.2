-- ============================================
-- Datos de prueba: Security (usuarios, roles y permisos ya cargados en HU-006)
-- Solo agregamos usuarios y asignaciones de roles
-- ============================================

-- Estados de usuario
INSERT INTO user_status (user_status_id, status_code, status_name) VALUES
    (gen_random_uuid(), 'ACTIVE', 'Activo'),
    (gen_random_uuid(), 'LOCKED', 'Bloqueado'),
    (gen_random_uuid(), 'EXPIRED', 'Expirado')
ON CONFLICT (status_code) DO NOTHING;

-- Usuarios (asociados a las personas creadas)
DO $$
DECLARE
    v_person_id uuid;
    v_role_id uuid;
    v_status_id uuid;
BEGIN
    -- Usuario administrador (persona 'Carlos López')
    SELECT person_id INTO v_person_id FROM person WHERE first_name = 'Carlos' AND last_name = 'López' LIMIT 1;
    SELECT security_role_id INTO v_role_id FROM security_role WHERE role_code = 'ADMIN';
    SELECT user_status_id INTO v_status_id FROM user_status WHERE status_code = 'ACTIVE';
    INSERT INTO user_account (user_account_id, person_id, user_status_id, username, password_hash)
    VALUES (gen_random_uuid(), v_person_id, v_status_id, 'carlos.lopez', 'dummy_hash')
    ON CONFLICT (username) DO NOTHING;
    -- Asignar rol ADMIN
    INSERT INTO user_role (user_role_id, user_account_id, security_role_id)
    SELECT gen_random_uuid(), ua.user_account_id, v_role_id
    FROM user_account ua WHERE ua.username = 'carlos.lopez'
    ON CONFLICT DO NOTHING;

    -- Usuario agente de ventas (persona 'Juan Pérez')
    SELECT person_id INTO v_person_id FROM person WHERE first_name = 'Juan' AND last_name = 'Pérez' LIMIT 1;
    SELECT security_role_id INTO v_role_id FROM security_role WHERE role_code = 'SALES_AGENT';
    INSERT INTO user_account (user_account_id, person_id, user_status_id, username, password_hash)
    VALUES (gen_random_uuid(), v_person_id, v_status_id, 'juan.perez', 'dummy_hash')
    ON CONFLICT (username) DO NOTHING;
    INSERT INTO user_role (user_role_id, user_account_id, security_role_id)
    SELECT gen_random_uuid(), ua.user_account_id, v_role_id
    FROM user_account ua WHERE ua.username = 'juan.perez'
    ON CONFLICT DO NOTHING;

    -- Usuario cliente (persona 'María Gómez')
    SELECT person_id INTO v_person_id FROM person WHERE first_name = 'María' AND last_name = 'Gómez' LIMIT 1;
    SELECT security_role_id INTO v_role_id FROM security_role WHERE role_code = 'CUSTOMER';
    INSERT INTO user_account (user_account_id, person_id, user_status_id, username, password_hash)
    VALUES (gen_random_uuid(), v_person_id, v_status_id, 'maria.gomez', 'dummy_hash')
    ON CONFLICT (username) DO NOTHING;
    INSERT INTO user_role (user_role_id, user_account_id, security_role_id)
    SELECT gen_random_uuid(), ua.user_account_id, v_role_id
    FROM user_account ua WHERE ua.username = 'maria.gomez'
    ON CONFLICT DO NOTHING;
END $$;