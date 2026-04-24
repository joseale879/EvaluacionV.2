# Análisis de Dominios Funcionales del Modelo de Datos

**Proyecto:** Sistema de Gestión de Aerolínea  
**Archivo base analizado:** `modelo_postgresql.sql`  
**Fecha de análisis:** 14 de abril de 2026  
**Autor:** José  

## 1. Introducción

El modelo de datos entregado presenta una estructura **madura y bien organizada**, separada claramente por **dominios funcionales**. Esto facilita su mantenimiento, escalabilidad y futura evolución con Liquibase.

Se identificaron **exactamente 12 dominios funcionales** principales en el script original. Cada dominio agrupa tablas relacionadas lógicamente, mantiene consistencia en el uso de UUID como clave primaria, campos de auditoría (`created_at` / `updated_at`) y restricciones de integridad (CHECK, UNIQUE, FOREIGN KEY).

Adicionalmente, según **ADR-001**, se propone agregar un **nuevo dominio (Notifications)** para completar las necesidades reales de un sistema de aerolínea.

## 2. Dominios Funcionales Identificados (12 dominios originales)


1. Geography & Reference: `time_zone`, `continent`, `country`, `state_province`, `city`, `district`, `address`, `currency`.
Base para Airport, Person, Airline y Maintenance.

2. Airline: `airline`.
Relacionado con Customer, Aircraft, Fare y Loyalty.

3. Identity: `person_type`, `document_type`, `contact_type`, `person`, `person_document`, `person_contact`.
Usado por User Account, Customer y Reservation Passenger.

4. Security: `user_status`, `security_role`, `security_permission`, `user_account`, `user_role`, `role_permission`.
Transversal (seguridad en todo el sistema).

5. Customer & Loyalty: `customer_category`, `benefit_type`, `loyalty_program`, `loyalty_tier`, `customer`, `loyalty_account`, `loyalty_account_tier`, `miles_transaction`, `customer_benefit`.
Fidelización y beneficios del pasajero.

6. Airport: `airport`, `terminal`, `boarding_gate`, `runway`, `airport_regulation`.
Origen/Destino de Flight Segment y Maintenance.

7. Aircraft: `aircraft_manufacturer`, `aircraft_model`, `cabin_class`, `aircraft`, `aircraft_cabin`, `aircraft_seat`, `maintenance_event`, `maintenance_provider`, `maintenance_type`.
Usado por Flight y Seat Assignment.

8. Flight Operations: `flight_status`, `delay_reason_type`, `flight`, `flight_segment`, `flight_delay`.
Operación real de vuelos y retrasos.

9. Sales & Reservation: `reservation_status`, `sale_channel`, `fare_class`, `fare`, `reservation`, `reservation_passenger`, `sale`, `ticket`, `ticket_segment`, `seat_assignment`, `baggage`
Flujo comercial principal (reservas → tickets → asientos).

10. Boarding: `boarding_group`, `check_in_status`, `check_in`, `boarding_pass`, `boarding_validation`.
Proceso de check-in y embarque.

11. Payment: `payment_status`, `payment_method`, `payment`, `payment_transaction`, `refund`.
Pagos y reembolsos.

12. Billing: `tax`, `exchange_rate`, `invoice_status`, `invoice`, `invoice_line`.
Facturación e impuestos.

## 3. Observaciones Generales del Modelo

- **Fortalezas:**
  - Excelente separación por dominios funcionales.
  - Uso consistente de UUID como PK.
  - Restricciones de integridad fuertes (CHECK, UNIQUE).
  - Índices bien definidos para rendimiento.
  - Comentarios técnicos claros en las tablas más importantes.

- **Oportunidades de mejora (identificadas en los ADR):**
  - Falta de auditoría completa de cambios → **ADR-001** (ya reemplazado por Notifications).
  - Falta de dominio de Notificaciones → **ADR-001**.
  - Roles y permisos no están poblados con datos concretos → **ADR-002**.
  - No existe versionamiento del DDL → **ADR-003**.
  - No hay estrategia de despliegue reproducible → **ADR-005**.

## 4. Nuevo Dominio Propuesto (ADR-001)

**Dominio 13: Notifications**  
Tablas principales:
- `notification_type`
- `notification`
- `notification_recipient`
- `notification_log`

Este dominio es **transversal** y se relaciona con casi todos los dominios existentes (Flight, Sales, Boarding, Payment, Loyalty, Customer).

## 5. Conclusión

El modelo base entregado es de **alta calidad técnica** y está listo para ser evolucionado hacia un sistema productivo. La separación por dominios facilita enormemente:
- El versionamiento con Liquibase
- La contenerización con Docker
- El trabajo en equipo (ramas develop/qa/main)
- La futura implementación de la capa de aplicación