-- ============================================
-- DATOS DE REFERENCIA PARA RBAC (ADR-002)
-- 6 roles y permisos granulares
-- ============================================

-- Insertar roles (con ON CONFLICT para evitar duplicados)
INSERT INTO security_role (security_role_id, role_code, role_name, role_description)
VALUES 
    (gen_random_uuid(), 'ADMIN', 'Administrador', 'Acceso total al sistema'),
    (gen_random_uuid(), 'OPERATIONS', 'Operaciones', 'Gestión de vuelos y aeronaves'),
    (gen_random_uuid(), 'SALES_AGENT', 'Agente de Ventas', 'Gestión de reservas y ventas'),
    (gen_random_uuid(), 'CHECKIN_STAFF', 'Personal de Check-in', 'Check-in y abordaje'),
    (gen_random_uuid(), 'MAINTENANCE', 'Mantenimiento', 'Mantenimiento de aeronaves'),
    (gen_random_uuid(), 'CUSTOMER', 'Cliente', 'Acceso a sus propios datos')
ON CONFLICT (role_code) DO NOTHING;

-- Insertar permisos
INSERT INTO security_permission (security_permission_id, permission_code, permission_name, permission_description)
VALUES 
    (gen_random_uuid(), 'role:manage', 'Gestionar roles', 'Crear, editar, eliminar roles'),
    (gen_random_uuid(), 'permission:manage', 'Gestionar permisos', 'Asignar permisos a roles'),
    (gen_random_uuid(), 'user:manage', 'Gestionar usuarios', 'Crear, editar, deshabilitar usuarios'),
    (gen_random_uuid(), 'flight:view', 'Ver vuelos', 'Consultar información de vuelos'),
    (gen_random_uuid(), 'flight:manage', 'Gestionar vuelos', 'Crear, modificar, cancelar vuelos'),
    (gen_random_uuid(), 'flight:delay', 'Reportar retrasos', 'Registrar retrasos de vuelos'),
    (gen_random_uuid(), 'reservation:view', 'Ver reservas', 'Consultar reservas'),
    (gen_random_uuid(), 'reservation:create', 'Crear reservas', 'Realizar nuevas reservas'),
    (gen_random_uuid(), 'reservation:modify', 'Modificar reservas', 'Cambiar reservas existentes'),
    (gen_random_uuid(), 'reservation:cancel', 'Cancelar reservas', 'Cancelar reservas'),
    (gen_random_uuid(), 'payment:view', 'Ver pagos', 'Consultar transacciones de pago'),
    (gen_random_uuid(), 'payment:refund', 'Procesar reembolsos', 'Realizar reembolsos'),
    (gen_random_uuid(), 'checkin:view', 'Ver check-in', 'Consultar estado de check-in'),
    (gen_random_uuid(), 'checkin:perform', 'Realizar check-in', 'Ejecutar check-in de pasajeros'),
    (gen_random_uuid(), 'boarding:validate', 'Validar abordaje', 'Validar pases de abordar'),
    (gen_random_uuid(), 'aircraft:view', 'Ver aeronaves', 'Consultar información de aeronaves'),
    (gen_random_uuid(), 'aircraft:manage', 'Gestionar aeronaves', 'Crear, modificar, retirar aeronaves'),
    (gen_random_uuid(), 'maintenance:view', 'Ver mantenimiento', 'Consultar eventos de mantenimiento'),
    (gen_random_uuid(), 'maintenance:schedule', 'Programar mantenimiento', 'Crear eventos de mantenimiento'),
    (gen_random_uuid(), 'loyalty:view', 'Ver millas', 'Consultar millas y beneficios'),
    (gen_random_uuid(), 'loyalty:manage', 'Gestionar millas', 'Ajustar millas de clientes'),
    (gen_random_uuid(), 'seat:assign', 'Asignar asientos', 'Asignar asientos en vuelos'),
    (gen_random_uuid(), 'report:view', 'Ver reportes', 'Acceder a reportes del sistema')
ON CONFLICT (permission_code) DO NOTHING;

-- Asignar permisos a roles (relaciones)
-- ADMIN tiene todos los permisos (se insertan todos los IDs de permisos)
INSERT INTO role_permission (role_permission_id, security_role_id, security_permission_id)
SELECT gen_random_uuid(), r.security_role_id, p.security_permission_id
FROM security_role r, security_permission p
WHERE r.role_code = 'ADMIN'
ON CONFLICT DO NOTHING;

-- OPERATIONS
INSERT INTO role_permission (role_permission_id, security_role_id, security_permission_id)
SELECT gen_random_uuid(), r.security_role_id, p.security_permission_id
FROM security_role r, security_permission p
WHERE r.role_code = 'OPERATIONS'
  AND p.permission_code IN ('flight:view', 'flight:manage', 'flight:delay', 
                            'aircraft:view', 'aircraft:manage', 
                            'maintenance:view', 'maintenance:schedule',
                            'report:view')
ON CONFLICT DO NOTHING;

-- SALES_AGENT
INSERT INTO role_permission (role_permission_id, security_role_id, security_permission_id)
SELECT gen_random_uuid(), r.security_role_id, p.security_permission_id
FROM security_role r, security_permission p
WHERE r.role_code = 'SALES_AGENT'
  AND p.permission_code IN ('reservation:view', 'reservation:create', 'reservation:modify', 'reservation:cancel',
                            'payment:view', 'loyalty:view', 'report:view')
ON CONFLICT DO NOTHING;

-- CHECKIN_STAFF
INSERT INTO role_permission (role_permission_id, security_role_id, security_permission_id)
SELECT gen_random_uuid(), r.security_role_id, p.security_permission_id
FROM security_role r, security_permission p
WHERE r.role_code = 'CHECKIN_STAFF'
  AND p.permission_code IN ('flight:view', 'reservation:view', 
                            'checkin:view', 'checkin:perform', 
                            'boarding:validate', 'seat:assign')
ON CONFLICT DO NOTHING;

-- MAINTENANCE
INSERT INTO role_permission (role_permission_id, security_role_id, security_permission_id)
SELECT gen_random_uuid(), r.security_role_id, p.security_permission_id
FROM security_role r, security_permission p
WHERE r.role_code = 'MAINTENANCE'
  AND p.permission_code IN ('aircraft:view', 'aircraft:manage', 
                            'maintenance:view', 'maintenance:schedule')
ON CONFLICT DO NOTHING;

-- CUSTOMER (permisos básicos, la aplicación debe filtrar por propietario)
INSERT INTO role_permission (role_permission_id, security_role_id, security_permission_id)
SELECT gen_random_uuid(), r.security_role_id, p.security_permission_id
FROM security_role r, security_permission p
WHERE r.role_code = 'CUSTOMER'
  AND p.permission_code IN ('flight:view', 'reservation:view', 'payment:view', 'loyalty:view')
ON CONFLICT DO NOTHING;