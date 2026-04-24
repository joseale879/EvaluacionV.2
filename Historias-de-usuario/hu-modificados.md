

### HU-007: Construir plan de datos de prueba con orden de carga por dependencias
**Como** desarrollador de pruebas,  
**quiero** tener un plan y scripts de datos de prueba ordenados según dependencias,  
**para** poblar la base de datos de forma coherente y sin errores de integridad.

**Criterios de Aceptación:**
- Documento `docs/plan_datos_prueba.md` completo.
- Scripts SQL de inserción documentados y ordenados.

**Entregables:** `docs/plan_datos_prueba.md` + scripts de datos  
**Prioridad:** Must

---

### HU-008: Crear y probar el docker-compose.yml completo (levantar toda la BD funcional)
**Como** desarrollador,  
**quiero** tener un `docker-compose.yml` completo y probado,  
**para** que con un solo comando (`docker compose up -d`) se levante **toda la base de datos funcional** (estructura + Liquibase + datos de prueba).

**Descripción detallada:**  
Integrar PostgreSQL + Liquibase + carga automática de datos de prueba y verificar que todo funcione correctamente.

**Criterios de Aceptación:**
- `docker compose up -d` crea todas las tablas, índices y constraints.
- Liquibase aplica los 13 changelogs sin errores.
- Se pueden consultar datos de prueba.
- Instrucciones claras en `docker/README.md`.

**Entregables:**  
- `docker/docker-compose.yml` final  
- `docker/README.md`

**Prioridad:** Must | **Estado:** Pendiente (última HU – integra todo el trabajo)