# BancoCore_DB - Sistema de Gestión Bancaria con Domain-Driven Design

**Autor:** Juan Esteban Correa Cano  
**Curso:** Base De Datos II 2026-1  
**Tecnología:** PostgreSQL + DDD Architecture

---

## 🎯 Descripción del Proyecto

Sistema completo de gestión de información bancaria diseñado siguiendo principios de **Domain-Driven Design (DDD)** en PostgreSQL. La solución modela directamente el dominio bancario, implementando entidades del negocio, servicios de dominio, validaciones y auditoría.

### Características Principales

✅ **Modelo Relacional basado en DDD** - Entidades, agregados y value objects claramente definidos  
✅ **Servicios de Dominio (Procedimientos Almacenados)** - Lógica de negocio centralizada y reutilizable  
✅ **Validaciones Automáticas (Triggers)** - Cumplimiento de reglas de negocio a nivel de BD  
✅ **Flujos de Aprobación Completos** - Transferencias de alto monto y préstamos  
✅ **Auditoría Inmutable** - Bitácora de operaciones con trazabilidad completa  
✅ **Seguridad por Roles** - Control de acceso basado en roles del sistema  

---

## 📋 Archivos del Proyecto

| Archivo | Propósito | Descripción |
|---------|-----------|-------------|
| **banco_gestion_ddd.sql** | Schema Relacional | Entidades, catálogos, índices y vistas del modelo DDD |
| **servicios_dominio.sql** | Servicios de Negocio | Procedimientos almacenados que representan operaciones significativas |
| **validaciones_ddd.sql** | Reglas de Negocio | Triggers que validan invariantes del dominio |
| **ARQUITECTURA_DDD.md** | Documentación Detallada | Guía completa de arquitectura, ejemplos y mejores prácticas |

---

## 🚀 Guía de Implementación Rápida

### Requisitos Previos

- PostgreSQL 12+ instalado
- pgAdmin 4 (opcional, para interfaz gráfica)
- Cliente psql (incluido con PostgreSQL)

### Paso 1: Crear Base de Datos

```bash
# Conectar a PostgreSQL
psql -U postgres

# Crear base de datos
CREATE DATABASE gestion_banco ENCODING 'UTF8';

# Conectar a la nueva base de datos
\c gestion_banco
```

### Paso 2: Ejecutar Scripts en Orden

```bash
# 1. Schema relacional (entidades, catálogos, vistas)
psql -U postgres -d gestion_banco -f banco_gestion_ddd.sql

# 2. Validaciones (triggers para reglas de negocio)
psql -U postgres -d gestion_banco -f validaciones_ddd.sql

# 3. Servicios de dominio (procedimientos almacenados)
psql -U postgres -d gestion_banco -f servicios_dominio.sql
```

### Paso 3: Verificar Instalación

```sql
-- Verificar tablas
SELECT COUNT(*) as total_tablas FROM information_schema.tables 
WHERE table_schema = 'public';
-- Resultado esperado: 19+

-- Verificar servicios de dominio
SELECT COUNT(*) as total_funciones FROM information_schema.routines
WHERE routine_schema = 'public' AND routine_name LIKE 'sd_%';
-- Resultado esperado: 16+

-- Verificar triggers
SELECT COUNT(*) as total_triggers FROM information_schema.triggers
WHERE trigger_schema = 'public';
-- Resultado esperado: 20+
```

---

## 🏗️ Estructura del Modelo

### Entidades del Dominio

```
CLIENTE (Agregado Raíz)
├── Persona Natural
│   ├── Cuentas Bancarias
│   ├── Préstamos
│   └── Transferencias (como originador)
└── Empresa
    ├── Cuentas Empresariales
    ├── Préstamos Empresariales
    ├── Delegación de Permisos
    └── Representante Legal (vinculado a Persona)

TRANSFERENCIA (Agregado)
├── Cuenta Origen
├── Cuenta Destino
├── Usuario Creador
└── Usuario Aprobador (si requiere)

PRÉSTAMO (Agregado)
├── Cliente (Persona o Empresa)
├── Tipo de Préstamo
├── Pagos asociados
└── Cuenta destino desembolso
```

### Servicios de Dominio Principales

| Servicio | Propósito | Reglas |
|----------|-----------|--------|
| `sd_registrar_cliente_persona()` | Onboarding persona natural | Edad ≥18, ID único |
| `sd_registrar_cliente_empresa()` | Onboarding empresa | NIT único, representante válido |
| `sd_abrir_cuenta_bancaria()` | Apertura de cuenta | Cliente activo, tipo válido |
| `sd_crear_transferencia()` | Crear transferencia | Cuentas activas, fondos suficientes, determina aprobación |
| `sd_aprobar_transferencia()` | Aprobar transferencia | Revalida fondos, ejecuta movimiento |
| `sd_solicitar_prestamo()` | Solicitar préstamo | Montos en rango, plazo válido |
| `sd_aprobar_prestamo()` | Aprobar solicitud | Calcula intereses, define tasas |
| `sd_desembolsar_prestamo()` | Desembolsar dinero | Actualiza saldo, inicia cronograma pagos |

---

## 📊 Flujos de Aprobación

### Transferencia de Empresa (Alto Monto)

```
CREAR
  ↓
Monto > $10M Y Tipo = EMPRESA?
  ├─ SÍ  → EN_ESPERA_APROBACION (vencimiento: +60 min)
  └─ NO  → PENDIENTE (ejecuta inmediatamente)
  ↓
¿Requiere aprobación?
  ├─ SÍ → Supervisor Empresa APRUEBA/RECHAZA
  │       ├─ APRUEBA → Valida fondos → EJECUTADA
  │       └─ RECHAZA → RECHAZADA
  ├─ NO → Empleado puede aprobar
  └─ Automático → Pasados 60 min → VENCIDA
```

### Préstamo

```
SOLICITAR (Cliente)
  ├─ Valida: Activo, monto en rango, plazo válido
  ├─ Estado: EN_ESTUDIO
  └─ Registra: PRESTAMO_SOLICITADO
  ↓
REVISAR (Analista Interno)
  ├─ Aprueba → APROBADO (define monto, tasa, plazo)
  ├─ Rechaza → RECHAZADO
  └─ Registra evento
  ↓
DESEMBOLSAR (Analista Interno)
  ├─ Valida: Cuenta destino activa
  ├─ Actualiza: Saldo cuenta destino += monto
  ├─ Estado: DESEMBOLSADO
  ├─ Inicia: Cronograma de pagos
  └─ Registra: PRESTAMO_DESEMBOLSADO
```

---

## 🔐 Validaciones Automáticas

Las reglas de negocio se validan automáticamente mediante **triggers**:

### Por Entidad

| Entidad | Validaciones | Trigger |
|---------|-------------|---------|
| **Cliente Persona** | Edad ≥18, Email válido, Teléfono válido | 3 triggers |
| **Cliente Empresa** | Representante existe, Email válido | 1 trigger |
| **Cuenta Bancaria** | Cliente activo, Tipo válido, Saldo ≥ 0 | 4 triggers |
| **Transferencia** | Monto > 0, Cuentas activas, Fondos suficientes | 5 triggers |
| **Préstamo** | Monto > 0, Transiciones válidas, Cuenta destino válida | 6 triggers |
| **Usuario** | Rol válido, Email válido | 2 triggers |

---

## 📝 Bitácora de Operaciones

Todas las operaciones críticas se registran en `bitacora_operacion`:

```sql
-- Estructura del registro
{
    "id_bitacora": 1,
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

### Consultar Bitácora

```sql
-- Evento reciente de un cliente
SELECT * FROM vw_auditoria_usuario
WHERE id_usuario = 5
ORDER BY fecha_hora_operacion DESC
LIMIT 10;

-- Transferencias ejecutadas del mes
SELECT detalles_operacion->>'numero_transferencia' AS transferencia,
       (detalles_operacion->>'monto')::NUMERIC AS monto,
       fecha_hora_operacion
FROM bitacora_operacion
WHERE tipo_operacion = 'TRANSFERENCIA_EJECUTADA'
  AND EXTRACT(MONTH FROM fecha_hora_operacion) = EXTRACT(MONTH FROM NOW());
```

---

## 💡 Ejemplos de Uso

### Ejemplo 1: Registrar Cliente y Abrir Cuenta

```sql
-- Registrar cliente persona natural
SELECT * FROM sd_registrar_cliente_persona(
    '12345678',                    -- Número ID
    'Juan Pérez García',           -- Nombre
    'juan@email.com',              -- Email
    '3101234567',                  -- Teléfono
    '1990-05-15',                  -- Fecha nacimiento
    'Calle 10 #20-30',            -- Dirección
    'Bogotá',                      -- Ciudad
    'Colombia',                    -- País
    1                              -- ID usuario creador
) AS (id_cliente INT, mensaje VARCHAR);

-- Abrir cuenta de ahorros
SELECT * FROM sd_abrir_cuenta_bancaria(
    1,                             -- ID cliente
    'PERSONA',                     -- Tipo cliente
    1,                             -- Tipo cuenta (Ahorros)
    2,                             -- Moneda (COP)
    500000,                        -- Saldo inicial
    1                              -- ID usuario
) AS (id_cuenta INT, numero_cuenta VARCHAR, mensaje VARCHAR);
```

### Ejemplo 2: Crear y Ejecutar Transferencia

```sql
-- Transferencia que se ejecuta inmediatamente (monto < umbral)
SELECT * FROM sd_crear_transferencia(
    1,                             -- Cuenta origen
    2,                             -- Cuenta destino
    100000,                        -- Monto
    'Pago servicios',             -- Concepto
    1,                             -- ID usuario
    10000000                       -- Umbral aprobación
) AS (id_transferencia INT, numero_transferencia VARCHAR, 
      estado VARCHAR, mensaje VARCHAR);

-- Resultado: estado = 'PENDIENTE' (se ejecutó inmediatamente)

-- Transferencia que requiere aprobación (monto > umbral)
SELECT * FROM sd_crear_transferencia(
    5,                             -- Cuenta empresa
    3,                             -- Cuenta destino
    15000000,                      -- Monto > umbral
    'Pago nómina',                -- Concepto
    8,                             -- ID usuario empleado empresa
    10000000                       -- Umbral
) AS (id_transferencia INT, numero_transferencia VARCHAR,
      estado VARCHAR, mensaje VARCHAR);

-- Resultado: estado = 'EN_ESPERA_APROBACION'

-- Supervisor empresa APRUEBA
SELECT * FROM sd_aprobar_transferencia(
    101,                           -- ID transferencia
    7                              -- ID supervisor
) AS (mensaje VARCHAR);
```

### Ejemplo 3: Solicitar y Aprobar Préstamo

```sql
-- Cliente solicita préstamo
SELECT * FROM sd_solicitar_prestamo(
    2,                             -- ID cliente
    'PERSONA',                     -- Tipo cliente
    1,                             -- Tipo (Personal)
    5000000,                       -- Monto
    24,                            -- Plazo (meses)
    3                              -- ID usuario asesor
) AS (id_prestamo INT, numero_prestamo VARCHAR, mensaje VARCHAR);

-- Analista APRUEBA
SELECT * FROM sd_aprobar_prestamo(
    50,                            -- ID préstamo
    5000000,                       -- Monto aprobado
    10.5,                          -- Tasa interés
    24,                            -- Plazo
    10                             -- ID analista
) AS (mensaje VARCHAR);

-- Analista DESEMBOLSA
SELECT * FROM sd_desembolsar_prestamo(
    50,                            -- ID préstamo
    2,                             -- ID cuenta destino
    10                             -- ID usuario
) AS (mensaje VARCHAR);
```

---

## 🔍 Consultas Útiles

```sql
-- Resumen de cliente
SELECT * FROM vw_cliente_completo WHERE id_cliente = 1;

-- Cuentas de un cliente
SELECT * FROM vw_resumen_cuentas_cliente WHERE id_cliente = 1;

-- Préstamos activos de un cliente
SELECT * FROM vw_resumen_prestamos_cliente WHERE id_cliente = 1;

-- Transferencias pendientes de aprobación
SELECT * FROM vw_transferencias_pendientes_aprobacion;

-- Auditoría completa de operaciones
SELECT * FROM vw_auditoria_usuario 
WHERE fecha_hora_operacion > NOW() - INTERVAL '24 hours'
ORDER BY fecha_hora_operacion DESC;

-- Marcar transferencias vencidas (job automático)
SELECT * FROM sd_marcar_transferencias_vencidas();
```

---

## 📚 Documentación Completa

Para detalles completos sobre la arquitectura DDD, flujos de aprobación, reglas de negocio y mejores prácticas, consultar:

**→ [ARQUITECTURA_DDD.md](ARQUITECTURA_DDD.md)** ← Documentación Detallada

---

## 🛠️ Características Técnicas

### Integridad y Consistencia
- ✅ Transacciones ACID garantizadas
- ✅ Restricciones de integridad referencial
- ✅ Validaciones a nivel de base de datos
- ✅ Triggers para lógica compleja

### Seguridad
- ✅ Control de acceso por rol
- ✅ Auditoría inmutable de operaciones
- ✅ Registro de usuario y timestamp en bitácora
- ✅ Validación de campos sensibles

### Rendimiento
- ✅ Índices estratégicos en búsquedas frecuentes
- ✅ Vistas optimizadas para reportes
- ✅ Búsquedas rápidas por cliente, cuenta, estado
- ✅ Particionamiento posible en bitácora (grandes volúmenes)

### Mantenibilidad
- ✅ Lenguaje ubicuo (conceptos de negocio claros)
- ✅ Servicios de dominio reutilizables
- ✅ Separación de responsabilidades
- ✅ Versionable y documentado

---

## 📖 Tablas Principales del Sistema

| Tabla | Descripción | Tipo |
|-------|-------------|------|
| `cliente_persona_natural` | Personas naturales como clientes | Agregado |
| `cliente_empresa` | Entidades jurídicas como clientes | Agregado |
| `usuario_sistema` | Usuarios con acceso al sistema | Entidad |
| `cuenta_bancaria` | Depósitos de dinero | Agregado |
| `prestamo` | Productos de endeudamiento | Agregado |
| `transferencia` | Movimientos de fondos | Agregado |
| `pago_prestamo` | Cuotas de préstamos | Entidad |
| `delegacion_permisos` | Permisos delegados en empresa | Entidad |
| `bitacora_operacion` | Auditoría inmutable | Auditoría |

---

## 📞 Contacto y Soporte

- **Estudiante:** Juan Esteban Correa Cano
- **Curso:** Base de Datos II - 2026-1
- **Institución:** [Universidad]

---

## 📄 Licencia

Proyecto académico - 2026

---

**Última actualización:** 2024-05-03

