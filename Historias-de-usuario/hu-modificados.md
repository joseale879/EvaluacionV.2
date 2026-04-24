

### HU-003: Contenerizar PostgreSQL para levantar la base de datos en entorno local
**Como** desarrollador,  
**quiero** tener un contenedor de PostgreSQL listo con Docker,  
**para** poder levantar la base de datos de forma rápida y reproducible en cualquier equipo.

**Criterios de Aceptación:**
- `docker compose up -d` levanta PostgreSQL en el puerto 5432 con volumen persistente.

**Entregables:** `docker/docker-compose.yml` (versión inicial)  
**Prioridad:** Must

---

### HU-004: Contenerizar Liquibase e integrarlo al proyecto
**Como** desarrollador,  
**quiero** que Liquibase se ejecute automáticamente dentro del Docker Compose,  
**para** que al levantar el contenedor se aplique todo el esquema de forma controlada.

**Criterios de Aceptación:**
- Liquibase integrado correctamente en el `docker-compose.yml`.
- Se ejecuta después de PostgreSQL.

**Entregables:** Actualización del archivo `docker/docker-compose.yml`  
**Prioridad:** Must

---

### HU-005: Separar el DDL en changelogs organizados por dominio funcional
**Como** desarrollador,  
**quiero** dividir el script `modelo_postgresql.sql` en changelogs de Liquibase (uno por dominio),  
**para** cumplir con la regla “máximo un dominio por changelog” y versionar el DDL.

**Criterios de Aceptación:**
- 13 archivos de changelog creados (12 dominios originales + Notifications).
- `changelog-master.xml` que incluye todos en el orden correcto.

**Entregables:** Carpeta `liquibase/changelogs/` completa  
**Prioridad:** Must

---

### HU-006: Diseñar e implementar estrategia de roles y permisos diferenciados
**Como** desarrollador de seguridad,  
**quiero** implementar el modelo RBAC completo según ADR-002,  
**para** controlar el acceso según el perfil del usuario.

**Criterios de Aceptación:**
- 6 roles y permisos granulares definidos y cargados como datos de referencia.

**Entregables:** Datos de referencia en Liquibase  
**Prioridad:** Must

---

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