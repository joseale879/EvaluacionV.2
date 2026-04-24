# Estrategia de Versionamiento con Git Flow Simplificado

**Propósito:** Establecer un flujo de trabajo ordenado, trazable y colaborativo para el desarrollo de la base de datos.

## Ramas principales

| Rama | Propósito | Protección |
|------|-----------|-------------|
| `main` | Código en producción (estable). Solo se actualiza desde `qa`. | Requiere PR + aprobación |
| `qa`   | Entorno de pruebas y validación. Se integra desde `develop`. | Requiere PR |
| `develop` | Desarrollo activo diario. Integración de features. | Libre (protegida contra push directo) |

## Flujo de trabajo

1. **Nueva funcionalidad / corrección**  
   - Crear rama `feature/HU-XXX-descripcion` desde `develop`.
   - Desarrollar y hacer commits.
   - Abrir Pull Request hacia `develop`.
   - Al aprobar, se fusiona y se elimina la rama.

2. **Pase a pruebas**  
   - Cuando `develop` está estable, se crea PR hacia `qa`.
   - Se ejecutan pruebas automatizadas (Liquibase, validaciones).
   - Si todo ok, se fusiona.

3. **Release a producción**  
   - Desde `qa` se crea PR hacia `main`.
   - Se etiqueta la versión (ej. `v1.0.0`).
   - Se despliega en producción.

## Hotfixes (urgencias)

- Crear rama `hotfix/descripcion` desde `main`.
- Corregir y fusionar directamente a `main` y luego a `develop` y `qa`.

## Ejemplo de nombres de ramas

- `feature/HU-005-changelogs-por-dominio`
- `feature/HU-006-rbac-roles`
- `hotfix/error-changelog-master`

## Beneficios

- Trazabilidad total.
- Integración continua preparada.
- Sin conflictos entre desarrolladores.
- Cumple con el requisito del instrumento (entregable 4.3).