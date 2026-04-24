
-- Primero eliminar relaciones role_permission
DELETE FROM role_permission
WHERE security_role_id IN (SELECT security_role_id FROM security_role WHERE role_code IN ('ADMIN','OPERATIONS','SALES_AGENT','CHECKIN_STAFF','MAINTENANCE','CUSTOMER'));

-- Luego eliminar los permisos insertados (solo los que tienen permission_code definido)
DELETE FROM security_permission
WHERE permission_code IN (
    'role:manage', 'permission:manage', 'user:manage',
    'flight:view', 'flight:manage', 'flight:delay',
    'reservation:view', 'reservation:create', 'reservation:modify', 'reservation:cancel',
    'payment:view', 'payment:refund',
    'checkin:view', 'checkin:perform', 'boarding:validate',
    'aircraft:view', 'aircraft:manage',
    'maintenance:view', 'maintenance:schedule',
    'loyalty:view', 'loyalty:manage',
    'seat:assign', 'report:view'
);

-- Finalmente eliminar los roles
DELETE FROM security_role
WHERE role_code IN ('ADMIN','OPERATIONS','SALES_AGENT','CHECKIN_STAFF','MAINTENANCE','CUSTOMER');