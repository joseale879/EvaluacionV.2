# Registro de Seguimiento Técnico

**Proyecto:** Aerolínea – Base de Datos  
**Responsable:** [Tu nombre]  
**Período:** Abril 2026

## Sesión 1 – Fase supervisada (5 horas)

| Hora | Actividad | Avance | Incidencias | Solución |
|------|-----------|--------|-------------|-----------|
| 0:00-0:30 | Lectura del modelo | 100% | Ninguna | - |
| 0:30-1:00 | Identificación de dominios | 100% | Duda sobre dominio Billing | Se verificaron tablas `invoice`, `tax`, `exchange_rate` |
| 1:00-2:00 | Redacción de ADR | 100% | ADR-005 (contenedorización) se definió con Docker Compose | Se documentó correctamente |
| 2:00-2:30 | Estructura del repositorio | 100% | Creación de ramas en GitHub | Se usó `git branch develop`, `git branch qa` |
| 2:30-3:30 | Backlog y HUs | 100% | Priorización de Must | Se definieron 8 HUs esenciales |
| 3:30-4:30 | Contenerización PostgreSQL (HU-003) | 100% | Problema con Docker Desktop no iniciado | Se reinició Docker y funcionó |
| 4:30-5:00 | Configuración inicial de Liquibase (HU-004) | 80% | Error `lpm add` por versión de driver | Se eliminó `lpm add` y se usó driver incluido |

**Notas:** Al final de la supervisada, PostgreSQL funcionando y Liquibase en proceso. Se continuó en desescolarizado.

## Sesión 2 – Desescolarizado (día 1)

| Actividad | Duración | Resultado |
|-----------|----------|-----------|
| Completar HU-004 (Dockerfile sin `lpm add`) | 30 min | ✅ Éxito |
| Crear 13 archivos DDL (dominios) | 2 horas | ✅ Completado |
| Crear changelog-master.yaml con includes | 1 hora | ✅ Completado |
| Probar migración de tablas | 30 min | ✅ Sin errores |

**Observaciones:** Se usó formato YAML por preferencia del instructor. Los dominios quedaron en orden correcto.

## Sesión 3 – Desescolarizado (día 2)

| Actividad | Duración | Resultado |
|-----------|----------|-----------|
| Implementar RBAC (HU-006) | 1 hora | ✅ Roles y permisos cargados |
| Crear datos de prueba por dominio | 3 horas | ✅ 13 scripts de inserción |
| Crear rollbacks por dominio | 1 hora | ✅ 13 rollbacks individuales + general |
| Probar carga de datos | 30 min | ✅ Todos los inserts exitosos |

**Incidencias:** En `80_flight_operations_data.sql`, el vuelo no encontraba `aircraft_id`. Se corrigió usando `registration_number = 'HK-1234'` ya existente.

## Sesión 4 – Desescolarizado (día 3)

| Actividad | Duración | Resultado |
|-----------|----------|-----------|
| Modificar compose para ejecución automática | 15 min | ✅ Eliminado `profile: tooling` |
| Probar `docker compose up -d` completo | 30 min | ✅ Todas las tablas y datos creados |
| Escribir `docker/README.md` | 30 min | ✅ Documento claro |
| Validar datos de prueba en BD | 15 min | ✅ Consultas devuelven registros |

**Pruebas de validación:**

```sql
SELECT COUNT(*) FROM airline;   -- 3
SELECT COUNT(*) FROM airport;   -- 3
SELECT COUNT(*) FROM flight;    -- 1
SELECT COUNT(*) FROM notification; -- 3