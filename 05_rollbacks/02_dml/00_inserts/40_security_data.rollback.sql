-- ============================================
-- Rollback: Datos de prueba Security (usuarios)
-- ============================================

-- Eliminar asignaciones de roles y usuarios
DELETE FROM user_role WHERE user_account_id IN (SELECT user_account_id FROM user_account WHERE username IN ('carlos.lopez', 'juan.perez', 'maria.gomez'));
DELETE FROM user_account WHERE username IN ('carlos.lopez', 'juan.perez', 'maria.gomez');
DELETE FROM user_status WHERE status_code IN ('ACTIVE', 'LOCKED', 'EXPIRED');