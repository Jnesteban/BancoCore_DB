# ARQUITECTURA DOMAIN-DRIVEN DESIGN (DDD) - SISTEMA BANCARIO

## Índice
1. [Introducción](#introducción)
2. [Principios de DDD Implementados](#principios-de-ddd-implementados)
3. [Estructura de la Base de Datos](#estructura-de-la-base-de-datos)
4. [Entidades del Dominio](#entidades-del-dominio)
5. [Servicios de Dominio](#servicios-de-dominio)
6. [Validaciones y Reglas de Negocio](#validaciones-y-reglas-de-negocio)
7. [Flujos de Aprobación](#flujos-de-aprobación)
8. [Auditoría y Bitácora](#auditoría-y-bitácora)
9. [Guía de Implementación](#guía-de-implementación)
10. [Ejemplos de Uso](#ejemplos-de-uso)

---

## Introducción

Esta solución implementa un **Sistema de Gestión Bancaria** basado en los principios de **Domain-Driven Design (DDD)** en PostgreSQL. La arquitectura está diseñada para:

- Representar directamente los conceptos del dominio bancario como entidades de base de datos
- Encapsular reglas de negocio complejas mediante triggers y procedimientos almacenados
- Garantizar la integridad y consistencia del modelo mediante validaciones a nivel de base de datos
- Proporcionar auditoría completa de todas las operaciones críticas
- Facilitar transacciones seguras y flujos de aprobación robustos

---

## Principios de DDD Implementados

### 1. **Entidades (Entities)**
Las entidades son objetos con identidad única que representan conceptos clave del dominio:

| Entidad | Tabla | Identificador | Rol en el Dominio |
|---------|-------|----------------|-------------------|
| Cliente Persona Natural | `cliente_persona_natural` | `id_cliente` | Persona física cliente del banco |
| Cliente Empresa | `cliente_empresa` | `id_cliente` | Entidad jurídica cliente del banco |
| Usuario del Sistema | `usuario_sistema` | `id_usuario` | Actores del sistema con permisos |
| Cuenta Bancaria | `cuenta_bancaria` | `id_cuenta` | Depósito de dinero del cliente |
| Préstamo | `prestamo` | `id_prestamo` | Producto de endeudamiento |
| Transferencia | `transferencia` | `id_transferencia` | Movimiento de fondos entre cuentas |

### 2. **Value Objects (Objetos de Valor)**
Los Value Objects son conceptos sin identidad única que describen atributos del dominio:

- **Estados**: `estado_usuario_catalogo`, `estado_cuenta_catalogo`, `estado_prestamo_catalogo`, `estado_transferencia_catalogo`
- **Tipos**: `tipo_cuenta_catalogo`, `tipo_prestamo_catalogo`
- **Monedas**: `moneda_catalogo`
- **Roles**: `rol_sistema`

### 3. **Agregados Raíz (Aggregate Roots)**
Cada tabla principal es un agregado raíz que controla la integridad de sus datos relacionados:

```
CLIENTE PERSONA NATURAL
├── Cuentas Bancarias
├── Préstamos
└── Transferencias (como originador)

CLIENTE EMPRESA
├── Cuentas Empresariales
├── Préstamos Empresariales
├── Delegaciones de Permiso
└── Representante Legal (Cliente Persona)

TRANSFERENCIA (Agregado pequeño)
├── Cuenta Origen
├── Cuenta Destino
├── Usuario Creador
└── Usuario Aprobador
```

### 4. **Repositorios (Repositories)**
Las **vistas** actúan como repositorios del dominio, permitiendo acceso consistente a datos:

- `vw_cliente_completo`: Unificación de clientes persona y empresa
- `vw_resumen_cuentas_cliente`: Consolidación de cuentas por cliente
- `vw_resumen_prestamos_cliente`: Consolidación de préstamos por cliente
- `vw_transferencias_pendientes_aprobacion`: Transferencias en espera
- `vw_auditoria_usuario`: Historial de auditoría

### 5. **Servicios de Dominio (Domain Services)**
Procedimientos almacenados que encapsulan lógica de negocio significativa:

- `sd_registrar_cliente_persona()`: Onboarding de cliente persona
- `sd_registrar_cliente_empresa()`: Onboarding de cliente empresa
- `sd_abrir_cuenta_bancaria()`: Apertura de cuenta con validaciones
- `sd_crear_transferencia()`: Creación de transferencia con reglas de negocio
- `sd_ejecutar_transferencia()`: Ejecución de transferencia
- `sd_aprobar_transferencia()`: Aprobación de transferencia
- `sd_solicitar_prestamo()`: Solicitud de nuevo préstamo
- `sd_aprobar_prestamo()`: Aprobación de préstamo
- `sd_desembolsar_prestamo()`: Desembolso de fondos
- `sd_marcar_transferencias_vencidas()`: Job automático de vencimiento

---

## Estructura de la Base de Datos

### Modelo Conceptual

```
┌─────────────────────────────────────────────────────────────┐
│                    DOMINIO BANCARIO                         │
└─────────────────────────────────────────────────────────────┘
                            │
                ┌───────────┼───────────┐
                │           │           │
                ▼           ▼           ▼
         ┌──────────┐ ┌──────────┐ ┌─────────┐
         │ CLIENTES │ │ PRODUCTOS│ │OPERACIO-│
         │          │ │          │ │   NES   │
         └──────────┘ └──────────┘ └─────────┘
             │ │         │ │         │ │
        Persona│        Cuenta      Transfer│
        Empresa│        Préstamo    Aprobac│
         │ │                       │ │
         └─┼─────────────────────┬─┘ │
           │    Bitácora de       │   │
           │    Operaciones       │   │
           └─────────────────────┘   │
                                     │
                        ┌────────────┘
                        │
                    Auditoría
                 (Trazabilidad)
```

### Componentes Principales

#### 1. **Catálogos (Value Objects)**
- Definen los valores permitidos en el dominio
- Son inmutables y no tiene operaciones especiales
- Se replican en validaciones y triggers

#### 2. **Agregados (Entidades Principales)**
- Cliente Persona Natural / Empresa: Agregados de alto nivel
- Cuenta Bancaria: Agregado mediado por cliente
- Préstamo: Agregado con ciclo de vida definido
- Transferencia: Agregado con flujo de aprobación

#### 3. **Servicios de Dominio**
- Encapsulan lógica que no pertenece a una entidad
- Manejan coordinación entre agregados
- Registran eventos en la bitácora
- Retornan mensajes estructurados

#### 4. **Validaciones (Triggers)**
- Aseguran integridad a nivel de base de datos
- Validan reglas de negocio antes de INSERT/UPDATE
- Previenen estados inconsistentes
- Registro automático de cambios

#### 5. **Auditoría**
- Tabla `bitacora_operacion` inmutable
- Contiene detalles en JSON (JSONB)
- Disponible solo lectura
- Sirve para trazabilidad y cumplimiento

---

## Entidades del Dominio

### 1. Cliente Persona Natural

**Responsabilidades del Dominio:**
- Representar personas naturales como clientes
- Garantizar mayor de edad (18+)
- Mantener unicidad de identificación
- Validar datos de contacto

**Reglas de Negocio:**
```sql
-- Validación de edad
v_edad := EXTRACT(YEAR FROM AGE(fecha_nacimiento))
CHECK: v_edad >= 18

-- Validación de identificación única
UNIQUE: numero_identificacion

-- Validación de email
CHECK: correo_electronico ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$'

-- Validación de teléfono
CHECK: numero_telefono ~ '^[0-9]{7,15}$'
```

**Atributos Clave:**
- `numero_identificacion`: Cédula, DNI, etc. (UNIQUE)
- `nombre_completo`: Nombre del cliente
- `correo_electronico`: Email de contacto (UNIQUE)
- `numero_telefono`: Teléfono (7-15 dígitos)
- `fecha_nacimiento`: Debe ser mayor de 18 años
- `estado_cliente`: ACTIVO, INACTIVO, BLOQUEADO, SUSPENDIDO

### 2. Cliente Empresa

**Responsabilidades del Dominio:**
- Representar entidades jurídicas como clientes
- Asociar representante legal válido
- Garantizar unicidad de NIT
- Gestionar delegación de permisos

**Reglas de Negocio:**
```sql
-- NIT único
UNIQUE: nit

-- Representante legal debe ser cliente persona existente
FOREIGN KEY: id_representante_legal REFERENCES cliente_persona_natural

-- Email válido
CHECK: correo_electronico ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$'
```

### 3. Cuenta Bancaria

**Responsabilidades del Dominio:**
- Representar depósitos de dinero del cliente
- Mantener saldo consistente
- Controlar operatividad de la cuenta
- Generar número de cuenta único

**Reglas de Negocio:**
```sql
-- Número de cuenta único
UNIQUE: numero_cuenta

-- Cliente debe estar ACTIVO para abrir cuenta
CHECK: cliente.estado_cliente = 'ACTIVO'

-- Tipo de cuenta debe ser válido
FOREIGN KEY: id_tipo_cuenta REFERENCES tipo_cuenta_catalogo WHERE activo = TRUE

-- Saldo no negativo
CHECK: saldo_actual >= 0
CHECK: saldo_disponible >= 0

-- No operaciones en cuentas bloqueadas/canceladas
CHECK: estado_cuenta IN ('ACTIVA', 'SUSPENDIDA', 'INACTIVA')
  -- Para operaciones, solo ACTIVA

-- Fecha de apertura requerida
DEFAULT: fecha_apertura = CURRENT_DATE
```

### 4. Préstamo

**Responsabilidades del Dominio:**
- Representar productos de endeudamiento
- Controlar ciclo de vida: EN_ESTUDIO → APROBADO → DESEMBOLSADO
- Validar montos según tipo
- Generar plan de pagos

**Reglas de Negocio:**
```sql
-- Transiciones válidas
EN_ESTUDIO → APROBADO | RECHAZADO
APROBADO → DESEMBOLSADO | CANCELADO
DESEMBOLSADO → PAGADO | VENCIDO | CANCELADO

-- Monto debe estar en rango del tipo de préstamo
monto_solicitado BETWEEN tipo_prestamo.monto_minimo AND tipo_prestamo.monto_maximo

-- Plazo debe estar en rango
plazo_meses BETWEEN tipo_prestamo.plazo_minimo_meses AND tipo_prestamo.plazo_maximo_meses

-- Cliente debe estar ACTIVO
cliente.estado_cliente = 'ACTIVO'

-- Desembolso requiere cuenta destino activa
id_cuenta_destino_desembolso NOT NULL
cuenta_destino.estado_cuenta = 'ACTIVA'

-- Monto aprobado mayor a cero
CHECK: monto_aprobado > 0

-- Cálculo de interés total
interes_total = monto_aprobado * (tasa_interes / 100) * (plazo_meses / 12)
```

### 5. Transferencia

**Responsabilidades del Dominio:**
- Representar movimiento de fondos
- Controlar flujo de aprobación
- Garantizar integridad de saldos
- Validar temporización de aprobaciones

**Reglas de Negocio:**
```sql
-- Estados válidos
PENDIENTE → EJECUTADA
EN_ESPERA_APROBACION → EJECUTADA | RECHAZADA | VENCIDA

-- Monto mayor a cero
CHECK: monto > 0

-- No a la misma cuenta
CHECK: id_cuenta_origen <> id_cuenta_destino

-- Cuentas deben estar activas
cuenta_origen.estado_cuenta = 'ACTIVA'
cuenta_destino.estado_cuenta = 'ACTIVA'

-- Fondos suficientes en origen
saldo_actual >= monto

-- Transferencias de empresa > umbral requieren aprobación
IF (cliente.tipo = 'EMPRESA' AND monto > umbral_aprobacion)
  THEN estado = 'EN_ESPERA_APROBACION'
  ELSE estado = 'PENDIENTE' (se ejecuta inmediatamente)

-- Vencimiento automático después de 1 hora
IF (estado = 'EN_ESPERA_APROBACION' AND NOW() - fecha_creacion > 60 MINUTOS)
  THEN estado = 'VENCIDA'
```

---

## Servicios de Dominio

Los servicios de dominio encapsulan la lógica de negocio compleja que no pertenece a una entidad individual.

### Patrón de Servicio de Dominio

Cada servicio sigue este patrón:

```sql
CREATE OR REPLACE FUNCTION sd_operacion_significativa(
    p_parametros IN,
    OUT p_resultado_esperado OUT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- 1. Validar precondiciones (reglas de negocio)
    -- 2. Realizar la operación (UPDATE/INSERT)
    -- 3. Registrar en bitácora
    -- 4. Retornar resultado y mensaje
EXCEPTION WHEN OTHERS THEN
    -- Manejo de errores
END;
$$;
```

### Servicios Implementados

#### 1. **Gestión de Clientes**

```sql
sd_registrar_cliente_persona(
    p_numero_id, p_nombre, p_email, p_telefono,
    p_fecha_nacimiento, p_direccion, p_ciudad, p_pais,
    p_id_usuario_creador
)
-- Valida: edad >= 18, email válido, teléfono válido, id único
-- Genera evento: CLIENTE_CREADO

sd_registrar_cliente_empresa(
    p_nit, p_razon_social, p_email, p_telefono,
    p_direccion, p_ciudad, p_pais, p_id_representante_legal,
    p_id_usuario_creador
)
-- Valida: NIT único, representante existe, datos válidos
-- Genera evento: CLIENTE_EMPRESA_CREADO
```

#### 2. **Gestión de Cuentas**

```sql
sd_abrir_cuenta_bancaria(
    p_id_cliente, p_tipo_cliente, p_id_tipo_cuenta,
    p_id_moneda, p_saldo_inicial,
    p_id_usuario_creador
)
-- Valida: cliente activo, tipo válido, moneda válida
-- Genera número único de cuenta: TIPO-TIPOCUENTA-CLIENTE-SECUENCIAL
-- Registra: CUENTA_ABIERTA
```

#### 3. **Gestión de Transferencias**

```sql
sd_crear_transferencia(
    p_id_cuenta_origen, p_id_cuenta_destino, p_monto,
    p_concepto, p_id_usuario_creador,
    p_umbral_aprobacion
)
-- Valida: cuentas existen y activas, monto > 0, fondos suficientes
-- Determina si requiere aprobación: empresa Y monto > umbral
-- Estados: PENDIENTE (ejecuta) o EN_ESPERA_APROBACION
-- Fija vencimiento: NOW() + 60 minutos si requiere aprobación

sd_ejecutar_transferencia(
    p_id_transferencia, p_id_usuario_ejecutor
)
-- Valida fondos en el momento de ejecución
-- Actualiza saldos (débito/crédito)
-- Registra: TRANSFERENCIA_EJECUTADA con detalles

sd_aprobar_transferencia(
    p_id_transferencia, p_id_usuario_aprobador
)
-- Valida: estado = EN_ESPERA_APROBACION
-- Valida fondos nuevamente
-- Ejecuta transferencia
-- Registra: TRANSFERENCIA_APROBADA

sd_rechazar_transferencia(
    p_id_transferencia, p_id_usuario_aprobador, p_motivo
)
-- Valida: estado = EN_ESPERA_APROBACION
-- Cambia estado a RECHAZADA
-- Registra: TRANSFERENCIA_RECHAZADA
```

#### 4. **Gestión de Préstamos**

```sql
sd_solicitar_prestamo(
    p_id_cliente, p_tipo_cliente, p_id_tipo_prestamo,
    p_monto_solicitado, p_plazo_meses,
    p_id_usuario_creador
)
-- Valida: cliente activo, tipo válido, montos en rango, plazo válido
-- Estado inicial: EN_ESTUDIO
-- Registra: PRESTAMO_SOLICITADO

sd_aprobar_prestamo(
    p_id_prestamo, p_monto_aprobado, p_tasa_interes,
    p_plazo_meses, p_id_usuario_aprobador
)
-- Valida: estado = EN_ESTUDIO
-- Calcula: interes_total = monto * (tasa / 100) * (meses / 12)
-- Cambiar estado: APROBADO
-- Registra: PRESTAMO_APROBADO

sd_desembolsar_prestamo(
    p_id_prestamo, p_id_cuenta_destino,
    p_id_usuario_desembolsor
)
-- Valida: estado = APROBADO
-- Valida: cuenta_destino activa y existe
-- Actualiza saldo: cuenta_destino.saldo += monto_aprobado
-- Cambiar estado: DESEMBOLSADO
-- Registra: PRESTAMO_DESEMBOLSADO

sd_rechazar_prestamo(
    p_id_prestamo, p_id_usuario_aprobador, p_motivo
)
-- Valida: estado = EN_ESTUDIO
-- Cambiar estado: RECHAZADO
-- Registra: PRESTAMO_RECHAZADO
```

#### 5. **Mantenimiento**

```sql
sd_marcar_transferencias_vencidas()
-- Job automático: búsqueda cada 5 minutos
-- Criterio: EN_ESPERA_APROBACION + minutos >= 60
-- Cambiar estado: VENCIDA
-- Registra: TRANSFERENCIA_VENCIDA

sd_obtener_resumen_cliente(p_id_cliente, p_tipo_cliente)
-- Retorna: total_cuentas, saldo_total, cuentas_activas,
--          total_prestamos, prestamos_desembolsados, monto_activos,
--          transferencias_pendientes, última_transacción
```

---

## Validaciones y Reglas de Negocio

### Validaciones mediante Triggers

Las validaciones se implementan como triggers BEFORE INSERT/UPDATE:

| Tabla | Trigger | Regla |
|-------|---------|-------|
| `cliente_persona_natural` | `trg_cliente_persona_validar_edad` | Edad >= 18 años |
| `cliente_persona_natural` | `trg_cliente_persona_validar_email` | Email válido |
| `cliente_persona_natural` | `trg_cliente_persona_validar_telefono` | Teléfono 7-15 dígitos |
| `cliente_empresa` | `trg_cliente_empresa_validar_representante` | Representante existe |
| `cuenta_bancaria` | `trg_cuenta_validar_cliente_activo` | Cliente activo |
| `cuenta_bancaria` | `trg_cuenta_validar_tipo` | Tipo válido |
| `cuenta_bancaria` | `trg_cuenta_validar_saldo_inicial` | Saldo >= 0 |
| `transferencia` | `trg_transferencia_validar_monto` | Monto > 0 |
| `transferencia` | `trg_transferencia_validar_cuentas_existen` | Cuentas existen |
| `transferencia` | `trg_transferencia_validar_cuenta_operativa` | Cuentas activas |
| `transferencia` | `trg_transferencia_validar_fondos` | Fondos suficientes |
| `prestamo` | `trg_prestamo_validar_monto_solicitado` | Monto > 0 |
| `prestamo` | `trg_prestamo_validar_cliente_activo` | Cliente activo |
| `prestamo` | `trg_prestamo_validar_transiciones` | Transiciones válidas |
| `prestamo` | `trg_prestamo_validar_desembolso_cuenta` | Cuenta destino válida |

---

## Flujos de Aprobación

### Flujo de Aprobación de Transferencias (Empresa - Alto Monto)

```
PASO 1: CREAR TRANSFERENCIA
    Cliente Empresa → sd_crear_transferencia()
    ├─ Validar: Cuentas activas, monto > 0
    ├─ Validar: Cliente empresa
    ├─ Determinar: monto > umbral_aprobacion (10M COP por defecto)
    │   ├─ SI: estado = EN_ESPERA_APROBACION, vencimiento = NOW() + 60 min
    │   └─ NO: estado = PENDIENTE, ejecutar inmediatamente
    └─ Registrar: TRANSFERENCIA_CREADA en bitácora

PASO 2 (SI REQUIERE APROBACIÓN): SUPERVISOR EMPRESA
    Supervisor Empresa → sd_aprobar_transferencia() ó sd_rechazar_transferencia()
    
    Si APRUEBA:
    ├─ Validar: Estado = EN_ESPERA_APROBACION
    ├─ Validar: Fondos suficientes (nuevamente)
    ├─ Ejecutar: sd_ejecutar_transferencia()
    │   ├─ Débito: cuenta_origen.saldo -= monto
    │   ├─ Crédito: cuenta_destino.saldo += monto
    │   └─ Estado: EJECUTADA
    └─ Registrar: TRANSFERENCIA_APROBADA y TRANSFERENCIA_EJECUTADA
    
    Si RECHAZA:
    ├─ Cambiar estado: RECHAZADA
    └─ Registrar: TRANSFERENCIA_RECHAZADA

PASO 3 (AUTOMÁTICO): VENCIMIENTO
    Job: sd_marcar_transferencias_vencidas() cada 5 minutos
    ├─ Buscar: Estado = EN_ESPERA_APROBACION Y NOW() - fecha_creacion > 60 min
    ├─ Cambiar: Estado = VENCIDA
    └─ Registrar: TRANSFERENCIA_VENCIDA con motivo
```

### Flujo de Aprobación de Préstamos

```
PASO 1: SOLICITAR PRÉSTAMO
    Cliente → sd_solicitar_prestamo()
    ├─ Validar: Cliente activo
    ├─ Validar: Tipo válido
    ├─ Validar: Monto dentro de rango
    ├─ Validar: Plazo dentro de rango
    ├─ Estado: EN_ESTUDIO
    └─ Registrar: PRESTAMO_SOLICITADO

PASO 2: ANALISTA INTERNO REVISA Y DECIDE
    Analista → sd_aprobar_prestamo() ó sd_rechazar_prestamo()
    
    Si APRUEBA:
    ├─ Validar: Estado = EN_ESTUDIO
    ├─ Definir: monto_aprobado, tasa_interes, plazo_meses
    ├─ Calcular: interes_total = monto_aprobado * (tasa/100) * (meses/12)
    ├─ Estado: APROBADO
    ├─ Registrar: PRESTAMO_APROBADO
    └─ LISTA PARA DESEMBOLSO
    
    Si RECHAZA:
    ├─ Definir: motivo_rechazo
    ├─ Estado: RECHAZADO
    └─ Registrar: PRESTAMO_RECHAZADO

PASO 3: DESEMBOLSO
    Back-Office (Analista) → sd_desembolsar_prestamo()
    ├─ Validar: Estado = APROBADO
    ├─ Validar: Cuenta destino existe y activa
    ├─ Actualizar: cuenta_destino.saldo += monto_aprobado
    ├─ Estado: DESEMBOLSADO
    ├─ Inicializar: Cronograma de pagos
    └─ Registrar: PRESTAMO_DESEMBOLSADO
```

---

## Auditoría y Bitácora

### Tabla `bitacora_operacion`

```sql
CREATE TABLE bitacora_operacion (
    id_bitacora SERIAL PRIMARY KEY,
    tipo_operacion VARCHAR(50),           -- Qué pasó: CLIENTE_CREADO, TRANSFERENCIA_EJECUTADA
    fecha_hora_operacion TIMESTAMP,       -- Cuándo pasó
    id_usuario INT,                       -- Quién lo hizo
    rol_usuario VARCHAR(50),              -- Qué rol tenía
    id_producto_afectado INT,             -- Qué entidad fue afectada
    tipo_producto VARCHAR(50),            -- Tipo: CLIENTE, CUENTA, PRESTAMO, TRANSFERENCIA
    detalles_operacion JSONB,             -- Detalles variables en JSON
    estado_operacion VARCHAR(30),         -- EJECUTADA, FALLIDA
    tabla_afectada VARCHAR(100),          -- Tabla: cliente_persona_natural, transferencia
    accion_realizada VARCHAR(100),        -- INSERT, UPDATE, DELETE
    resultado TEXT,                       -- Descripción del resultado
    usuario_ip VARCHAR(50)                -- IP del usuario
);
```

### Ejemplos de Registros en Bitácora

#### Transferencia Ejecutada
```json
{
    "tipo_operacion": "TRANSFERENCIA_EJECUTADA",
    "fecha_hora_operacion": "2024-05-03T14:30:45Z",
    "id_usuario": 5,
    "rol_usuario": "SUPERVISOR_EMPRESA",
    "id_producto_afectado": 1001,
    "tipo_producto": "TRANSFERENCIA",
    "detalles_operacion": {
        "monto": 5000000,
        "saldo_origen_antes": 20000000,
        "saldo_origen_despues": 15000000,
        "saldo_destino_antes": 1000000,
        "saldo_destino_despues": 6000000
    },
    "resultado": "Exitoso"
}
```

#### Préstamo Aprobado
```json
{
    "tipo_operacion": "PRESTAMO_APROBADO",
    "fecha_hora_operacion": "2024-05-03T15:00:00Z",
    "id_usuario": 10,
    "rol_usuario": "ANALISTA_INTERNO",
    "id_producto_afectado": 2001,
    "tipo_producto": "PRESTAMO",
    "detalles_operacion": {
        "monto_aprobado": 30000000,
        "tasa_interes": 10.5,
        "plazo_meses": 60,
        "interes_total": 15750000
    },
    "resultado": "Exitoso"
}
```

#### Transferencia Vencida
```json
{
    "tipo_operacion": "TRANSFERENCIA_VENCIDA",
    "fecha_hora_operacion": "2024-05-03T16:00:00Z",
    "id_usuario": null,
    "rol_usuario": null,
    "id_producto_afectado": 1005,
    "tipo_producto": "TRANSFERENCIA",
    "detalles_operacion": {
        "minutos_espera": 65,
        "motivo": "Vencida por falta de aprobación en el tiempo establecido"
    },
    "resultado": "Automático"
}
```

---

## Guía de Implementación

### Paso 1: Crear Base de Datos

```bash
# Conectar a PostgreSQL como superusuario
psql -U postgres

# En psql:
CREATE DATABASE gestion_banco
    ENCODING 'UTF8'
    LOCALE 'es_ES.UTF-8';

\c gestion_banco
```

### Paso 2: Ejecutar Scripts en Orden

```bash
# 1. Script de schema DDD (Entidades y Catálogos)
psql -U postgres -d gestion_banco -f banco_gestion_ddd.sql

# 2. Script de Validaciones (Triggers)
psql -U postgres -d gestion_banco -f validaciones_ddd.sql

# 3. Script de Servicios de Dominio (Procedimientos)
psql -U postgres -d gestion_banco -f servicios_dominio.sql
```

### Paso 3: Verificar Instalación

```sql
-- Verificar tablas
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

-- Verificar funciones (Servicios de Dominio)
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'public' AND routine_name LIKE 'sd_%'
ORDER BY routine_name;

-- Verificar triggers
SELECT trigger_name, event_object_table
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY event_object_table;
```

### Paso 4: Crear Usuario Aplicación

```sql
-- Crear usuario con permisos limitados
CREATE USER app_banco WITH PASSWORD 'StrongPassword123!';

-- Otorgar permisos de lectura en tablas
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_banco;

-- Otorgar permisos para ejecutar procedimientos
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO app_banco;

-- Permitir INSERT/UPDATE en tablas específicas
GRANT INSERT, UPDATE, DELETE ON 
    cliente_persona_natural,
    cliente_empresa,
    usuario_sistema,
    cuenta_bancaria,
    prestamo,
    transferencia,
    pago_prestamo,
    delegacion_permisos
TO app_banco;

-- Permitir SELECT en bitácora (solo lectura)
GRANT SELECT ON bitacora_operacion TO app_banco;
```

---

## Ejemplos de Uso

### Ejemplo 1: Crear Cliente Persona Natural

```sql
-- Ejecutar servicio de dominio
SELECT * FROM sd_registrar_cliente_persona(
    p_numero_id := '12345678',
    p_nombre_completo := 'Juan Pérez González',
    p_email := 'juan.perez@email.com',
    p_telefono := '3101234567',
    p_fecha_nacimiento := '1990-05-15',
    p_direccion := 'Calle 10 #20-30',
    p_ciudad := 'Bogotá',
    p_pais := 'Colombia',
    p_id_usuario_creador := 1
);

-- Resultado
id_cliente  | mensaje
1           | Cliente persona natural registrado exitosamente. ID: 1
```

### Ejemplo 2: Abrir Cuenta Bancaria

```sql
-- Ejecutar servicio de dominio
SELECT * FROM sd_abrir_cuenta_bancaria(
    p_id_cliente := 1,
    p_tipo_cliente := 'PERSONA',
    p_id_tipo_cuenta := 1,              -- Ahorros
    p_id_moneda := 2,                  -- COP
    p_saldo_inicial := 500000,
    p_id_usuario_creador := 1
);

-- Resultado
id_cuenta  | numero_cuenta       | mensaje
1          | PERSONA-1-1-0001    | Cuenta bancaria abierta exitosamente
```

### Ejemplo 3: Crear Transferencia (Aprobación Requerida)

```sql
-- Empresa crea transferencia > umbral (requiere aprobación)
SELECT * FROM sd_crear_transferencia(
    p_id_cuenta_origen := 5,            -- Cuenta empresa
    p_id_cuenta_destino := 3,           -- Cuenta tercero
    p_monto := 15000000,                -- Supera umbral
    p_concepto := 'Pago de nómina',
    p_id_usuario_creador := 8,          -- Empleado empresa
    p_umbral_aprobacion := 10000000     -- Umbral en COP
);

-- Resultado
id_transferencia  | numero_transferencia  | estado                    | mensaje
101               | TRF-20240503-000101   | EN_ESPERA_APROBACION      | Transferencia creada: TRF-20240503-000101

-- Supervisor empresa APRUEBA la transferencia
SELECT * FROM sd_aprobar_transferencia(
    p_id_transferencia := 101,
    p_id_usuario_aprobador := 7           -- Supervisor empresa
);

-- Resultado
mensaje
Transferencia aprobada y ejecutada exitosamente
```

### Ejemplo 4: Solicitar Préstamo

```sql
-- Cliente solicita préstamo personal
SELECT * FROM sd_solicitar_prestamo(
    p_id_cliente := 2,                  -- Cliente persona
    p_tipo_cliente := 'PERSONA',
    p_id_tipo_prestamo := 1,            -- Personal
    p_monto_solicitado := 5000000,      -- $5M
    p_plazo_meses := 24,                -- 2 años
    p_id_usuario_creador := 2           -- Asesor comercial
);

-- Resultado
id_prestamo  | numero_prestamo       | mensaje
50           | PRE-20240503-000050   | Solicitud de préstamo registrada: PRE-20240503-000050

-- Analista APRUEBA
SELECT * FROM sd_aprobar_prestamo(
    p_id_prestamo := 50,
    p_monto_aprobado := 5000000,
    p_tasa_interes := 10.5,
    p_plazo_meses := 24,
    p_id_usuario_aprobador := 10        -- Analista interno
);

-- Resultado
mensaje
Préstamo aprobado exitosamente

-- Analista DESEMBOLSA
SELECT * FROM sd_desembolsar_prestamo(
    p_id_prestamo := 50,
    p_id_cuenta_destino := 2,           -- Cuenta donde enviar dinero
    p_id_usuario_desembolsor := 10
);

-- Resultado
mensaje
Préstamo desembolsado exitosamente. Saldo actualizado en cuenta destino
```

### Ejemplo 5: Consultar Bitácora

```sql
-- Ver todos los eventos de un cliente
SELECT 
    b.fecha_hora_operacion,
    u.nombre_usuario,
    b.tipo_operacion,
    b.detalles_operacion
FROM bitacora_operacion b
JOIN usuario_sistema u ON b.id_usuario = u.id_usuario
WHERE b.id_producto_afectado = 50  -- Préstamo ID 50
ORDER BY b.fecha_hora_operacion DESC;

-- Ver transferencias ejecutadas del mes
SELECT 
    b.fecha_hora_operacion,
    b.detalles_operacion->>'numero_transferencia' AS transferencia,
    (b.detalles_operacion->>'monto')::NUMERIC AS monto,
    u.rol_usuario
FROM bitacora_operacion b
JOIN usuario_sistema u ON b.id_usuario = u.id_usuario
WHERE b.tipo_operacion = 'TRANSFERENCIA_EJECUTADA'
  AND EXTRACT(MONTH FROM b.fecha_hora_operacion) = EXTRACT(MONTH FROM NOW())
ORDER BY b.fecha_hora_operacion DESC;
```

### Ejemplo 6: Consultar Resumen de Cliente

```sql
-- Obtener resumen completo de un cliente
SELECT * FROM sd_obtener_resumen_cliente(
    p_id_cliente := 1,
    p_tipo_cliente := 'PERSONA'
);

-- Resultado
total_cuentas | saldo_total | cuentas_activas | total_prestamos | prestamos_desembolsados
3             | 12500000    | 3               | 2               | 1
```

---

## Características Avanzadas

### 1. Integridad Referencial Cascada

```sql
-- Cascada controlada: Cliente → Cuentas → Transferencias
ALTER TABLE cuenta_bancaria
ADD CONSTRAINT fk_cuenta_cliente
FOREIGN KEY (id_cliente, tipo_cliente)
REFERENCES cliente(id_cliente, tipo_cliente)
ON DELETE RESTRICT         -- No permite eliminar cliente con cuentas
ON UPDATE CASCADE;         -- Propaga cambios de ID de cliente
```

### 2. Vencimiento Automático de Transferencias

```sql
-- Job PostgreSQL: Ejecutar cada 5 minutos
SELECT * FROM sd_marcar_transferencias_vencidas();

-- Crear job (requiere pg_cron extension)
SELECT cron.schedule('marcar-transferencias-vencidas', '*/5 * * * *',
    'SELECT sd_marcar_transferencias_vencidas()');
```

### 3. Auditoría de Cambios Sensibles

```sql
-- Vista auditada
SELECT * FROM vw_auditoria_usuario
WHERE fecha_hora_operacion > NOW() - INTERVAL '24 hours'
ORDER BY fecha_hora_operacion DESC
LIMIT 100;
```

### 4. Restricciones por Rol

```sql
-- Implementadas mediante RLS (Row-Level Security) en PostgreSQL
-- Cada rol ve solo sus datos mediante policies
ALTER TABLE cuenta_bancaria ENABLE ROW LEVEL SECURITY;

CREATE POLICY cliente_ver_propias_cuentas ON cuenta_bancaria
FOR SELECT USING (id_cliente = current_user_id());
```

---

## Mejores Prácticas DDD Implementadas

| Principio DDD | Implementación | Beneficio |
|---------------|----------------|-----------|
| **Entidades** | Tablas principales con identidad única | Claridad conceptual |
| **Value Objects** | Catálogos (Estados, Tipos) | Validación centralizada |
| **Agregados** | Cliente es raíz; cuentas/préstamos son entidades | Transacciones seguras |
| **Servicios de Dominio** | Procedimientos para lógica compleja | Reutilización de lógica |
| **Repositorios** | Vistas de consulta | Acceso consistente |
| **Eventos de Dominio** | Bitácora de operaciones | Trazabilidad y auditoría |
| **Lenguaje Ubicuo** | Nombres claros en español | Comunicación con negocio |
| **Límites de Contexto** | Separación cliente/operaciones/auditoría | Mantenibilidad |

---

## Conclusión

Esta implementación de **Domain-Driven Design en PostgreSQL** proporciona:

✅ **Modelo coherente** que refleja el dominio bancario  
✅ **Validaciones robustas** a nivel de base de datos  
✅ **Servicios reutilizables** encapsulados  
✅ **Auditoría completa** de operaciones  
✅ **Flujos de aprobación** seguros  
✅ **Transacciones ACID** garantizadas  
✅ **Escalabilidad** mediante índices estratégicos  
✅ **Mantenibilidad** mediante separación de responsabilidades  

El resultado es una base de datos que actúa no solo como repositorio, sino como componente activo en la lógica del sistema, garantizando consistencia, seguridad y compliance normativo.

