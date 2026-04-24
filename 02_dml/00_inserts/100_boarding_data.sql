-- ============================================
-- Datos de prueba: Boarding
-- ============================================

-- Grupos de abordaje
INSERT INTO boarding_group (boarding_group_id, group_code, group_name, sequence_no) VALUES
    (gen_random_uuid(), 'A', 'Grupo A (Priority)', 1),
    (gen_random_uuid(), 'B', 'Grupo B', 2),
    (gen_random_uuid(), 'C', 'Grupo C', 3),
    (gen_random_uuid(), 'D', 'Grupo D', 4)
ON CONFLICT (group_code) DO NOTHING;

-- Estados de check-in
INSERT INTO check_in_status (check_in_status_id, status_code, status_name) VALUES
    (gen_random_uuid(), 'PENDING', 'Pendiente'),
    (gen_random_uuid(), 'COMPLETED', 'Completado'),
    (gen_random_uuid(), 'SKIPPED', 'No se presentó')
ON CONFLICT (status_code) DO NOTHING;