# Plan de Datos de Prueba – Sistema de Aerolínea

## Objetivo
Poblar la base de datos con un conjunto mínimo pero representativo de datos de prueba que permita validar la funcionalidad del sistema, respetando las dependencias de integridad referencial.

## Orden de carga (por dominio)

El orden debe seguir la jerarquía de dependencias:

1. **Geography** – países, ciudades, zonas horarias, monedas (sin dependencias externas)
2. **Airline** – aerolínea (depende de country)
3. **Identity** – tipos de persona, documento, contacto; personas reales (depende de country)
4. **Security** – roles, permisos, usuarios (depende de person, security_role, security_permission)
5. **Customer & Loyalty** – clientes, cuentas de lealtad (depende de airline, person, currency, loyalty_program)
6. **Airport** – aeropuertos, terminales, puertas (depende de address)
7. **Aircraft** – fabricantes, modelos, aeronaves (depende de airline, aircraft_manufacturer)
8. **Flight Operations** – vuelos, segmentos (depende de airline, aircraft, airport, flight_status)
9. **Sales & Reservation** – tarifas, reservas, pasajeros, boletos (depende de flight, fare, person, customer)
10. **Boarding** – check-in, pases de abordar (depende de ticket_segment, boarding_group)
11. **Payment** – pagos, transacciones (depende de sale)
12. **Billing** – facturas, impuestos (depende de sale, currency)

**Nota:** El dominio Notifications (ADR-001) se poblará más adelante; por ahora se omiten sus datos de prueba.

## Scripts de inserción

Los scripts se encuentran en `02_dml/` con la siguiente nomenclatura:
- `02_dml/10_geography_data.sql`
- `02_dml/20_airline_data.sql`
- `02_dml/30_identity_data.sql`
- `02_dml/40_security_data.sql`
- `02_dml/50_customer_loyalty_data.sql`
- `02_dml/60_airport_data.sql`
- `02_dml/70_aircraft_data.sql`
- `02_dml/80_flight_operations_data.sql`
- `02_dml/90_sales_reservation_data.sql`
- `02_dml/100_boarding_data.sql`
- `02_dml/110_payment_data.sql`
- `02_dml/120_billing_data.sql`

Cada script es idempotente (usa `INSERT ... ON CONFLICT DO NOTHING` o `DELETE` previo) y respeta el orden.

## Verificación

Después de ejecutar todos los scripts, se debe comprobar que no hay errores de clave foránea y que las tablas principales contienen al menos 1 registro:
- `airline` (1)
- `airport` (≥2)
- `flight` (≥1)
- `reservation` (≥1)
- `payment` (≥1)

## Ejecución con Liquibase

Los scripts de datos de prueba se incluirán en el `changelog-master.yaml` como nuevos changeSets después de la creación de tablas y de los datos de referencia (roles/permisos). Se agruparán en un solo changeSet o en varios según se prefiera.

Ejemplo de inclusión:
```yaml
  - changeSet:
      id: 999_test_data
      author: alumno
      comment: "Carga datos de prueba para todos los dominios"
      changes:
        - sqlFile:
            path: ../02_dml/10_geography_data.sql
            relativeToChangelogFile: true
        - sqlFile:
            path: ../02_dml/20_airline_data.sql
            relativeToChangelogFile: true
        # ... etc
      rollback:
        - sqlFile:
            path: ../05_rollbacks/02_dml/999_test_data.rollback.sql