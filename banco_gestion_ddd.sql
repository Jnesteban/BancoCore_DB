-- ============================================================================
-- SISTEMA DE GESTIÓN BANCARIA - MODELO DDD EN POSTGRESQL
-- ============================================================================
-- Autor: Programador Senior - Arquitectura Backend & DB
-- Propósito: Implementación de Domain-Driven Design (DDD) en PostgreSQL
-- Descripción: Diseño relacional que representa directamente entidades del dominio
--              con reglas de negocio encapsuladas en triggers y procedimientos
-- ============================================================================

-- Establecer encoding y zona horaria
SET client_encoding = 'UTF8';
SET timezone = 'UTC';

-- ============================================================================
-- 1. CATÁLOGOS (VALUE OBJECTS DEL DOMINIO)
-- ============================================================================

-- Tabla de Roles del Sistema - Define autoridades en el dominio
CREATE TABLE rol_sistema (
    id_rol SERIAL PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    permisos TEXT,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Estados de Usuario
CREATE TABLE estado_usuario_catalogo (
    id_estado SERIAL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Estados de Cuenta
CREATE TABLE estado_cuenta_catalogo (
    id_estado SERIAL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Tipos de Cuenta
CREATE TABLE tipo_cuenta_catalogo (
    id_tipo SERIAL PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    requiere_aprobacion BOOLEAN DEFAULT FALSE,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Estados de Préstamo
CREATE TABLE estado_prestamo_catalogo (
    id_estado SERIAL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Estados de Transferencia
CREATE TABLE estado_transferencia_catalogo (
    id_estado SERIAL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Monedas Soportadas
CREATE TABLE moneda_catalogo (
    id_moneda SERIAL PRIMARY KEY,
    codigo_iso VARCHAR(3) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    simbolo VARCHAR(5),
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Tipos de Préstamo
CREATE TABLE tipo_prestamo_catalogo (
    id_tipo SERIAL PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    tasa_interes_minima DECIMAL(5,2),
    tasa_interes_maxima DECIMAL(5,2),
    plazo_minimo_meses INT,
    plazo_maximo_meses INT,
    monto_minimo DECIMAL(15,2),
    monto_maximo DECIMAL(15,2),
    activo BOOLEAN DEFAULT TRUE
);

-- ============================================================================
-- 2. ENTIDADES DEL DOMINIO - AGREGADOS RAÍZ
-- ============================================================================

-- AGREGADO: Cliente Persona Natural
-- Valor: Representa una persona física como cliente del banco
CREATE TABLE cliente_persona_natural (
    id_cliente SERIAL PRIMARY KEY,
    numero_identificacion VARCHAR(20) NOT NULL UNIQUE,
    nombre_completo VARCHAR(255) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    numero_telefono VARCHAR(15) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion TEXT NOT NULL,
    ciudad VARCHAR(100),
    pais VARCHAR(100),
    estado_cliente VARCHAR(30) DEFAULT 'ACTIVO',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (numero_telefono ~ '^[0-9]{7,15}$'),
    CHECK (correo_electronico ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$')
);

-- AGREGADO: Cliente Empresa
-- Valor: Representa una entidad jurídica como cliente del banco
CREATE TABLE cliente_empresa (
    id_cliente SERIAL PRIMARY KEY,
    nit VARCHAR(20) NOT NULL UNIQUE,
    razon_social VARCHAR(255) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    numero_telefono VARCHAR(15) NOT NULL,
    direccion TEXT NOT NULL,
    ciudad VARCHAR(100),
    pais VARCHAR(100),
    id_representante_legal INT NOT NULL,
    estado_cliente VARCHAR(30) DEFAULT 'ACTIVO',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (numero_telefono ~ '^[0-9]{7,15}$'),
    CHECK (correo_electronico ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$'),
    FOREIGN KEY (id_representante_legal) REFERENCES cliente_persona_natural(id_cliente)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- AGREGADO: Usuario del Sistema
-- Valor: Representa un usuario con acceso al sistema y asignación de rol
CREATE TABLE usuario_sistema (
    id_usuario SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    nombre_completo VARCHAR(255) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    numero_identificacion VARCHAR(20) NOT NULL UNIQUE,
    numero_telefono VARCHAR(15),
    id_rol INT NOT NULL,
    id_cliente_relacionado INT,
    tipo_cliente VARCHAR(20),  -- 'PERSONA' o 'EMPRESA'
    contrasena_hash VARCHAR(255) NOT NULL,
    estado_usuario VARCHAR(30) DEFAULT 'ACTIVO',
    ultimo_acceso TIMESTAMP,
    intento_fallidos INT DEFAULT 0,
    bloqueado BOOLEAN DEFAULT FALSE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_rol) REFERENCES rol_sistema(id_rol)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (tipo_cliente IN ('PERSONA', 'EMPRESA', NULL))
);

-- AGREGADO: Cuenta Bancaria
-- Valor: Representa el depósito de dinero de un cliente
CREATE TABLE cuenta_bancaria (
    id_cuenta SERIAL PRIMARY KEY,
    numero_cuenta VARCHAR(30) NOT NULL UNIQUE,
    id_cliente INT NOT NULL,
    tipo_cliente VARCHAR(20) NOT NULL,  -- 'PERSONA' o 'EMPRESA'
    id_tipo_cuenta INT NOT NULL,
    saldo_actual DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    saldo_disponible DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    id_moneda INT NOT NULL,
    estado_cuenta VARCHAR(30) DEFAULT 'ACTIVA',
    fecha_apertura DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_clausura DATE,
    limite_diario_retiro DECIMAL(15,2),
    tasa_interes_anual DECIMAL(5,2) DEFAULT 0.00,
    interes_acumulado DECIMAL(15,2) DEFAULT 0.00,
    fecha_ultima_movimiento TIMESTAMP,
    activa BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_tipo_cuenta) REFERENCES tipo_cuenta_catalogo(id_tipo)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_moneda) REFERENCES moneda_catalogo(id_moneda)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (tipo_cliente IN ('PERSONA', 'EMPRESA')),
    CHECK (saldo_actual >= 0),
    CHECK (saldo_disponible >= 0)
);

-- AGREGADO: Préstamo / Crédito
-- Valor: Representa un producto de endeudamiento otorgado al cliente
CREATE TABLE prestamo (
    id_prestamo SERIAL PRIMARY KEY,
    numero_prestamo VARCHAR(30) NOT NULL UNIQUE,
    id_cliente INT NOT NULL,
    tipo_cliente VARCHAR(20) NOT NULL,  -- 'PERSONA' o 'EMPRESA'
    id_tipo_prestamo INT NOT NULL,
    monto_solicitado DECIMAL(15,2) NOT NULL,
    monto_aprobado DECIMAL(15,2),
    tasa_interes DECIMAL(5,2),
    plazo_meses INT,
    estado_prestamo VARCHAR(30) DEFAULT 'EN_ESTUDIO',
    id_cuenta_destino_desembolso INT,
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_aprobacion TIMESTAMP,
    fecha_desembolso TIMESTAMP,
    id_usuario_creador INT NOT NULL,
    id_usuario_aprobador INT,
    motivo_rechazo TEXT,
    fecha_vencimiento DATE,
    interes_total DECIMAL(15,2),
    interes_acumulado DECIMAL(15,2) DEFAULT 0.00,
    fecha_proximo_pago DATE,
    saldo_pendiente DECIMAL(15,2),
    FOREIGN KEY (id_tipo_prestamo) REFERENCES tipo_prestamo_catalogo(id_tipo)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_cuenta_destino_desembolso) REFERENCES cuenta_bancaria(id_cuenta)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario_creador) REFERENCES usuario_sistema(id_usuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario_aprobador) REFERENCES usuario_sistema(id_usuario)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CHECK (monto_solicitado > 0),
    CHECK (monto_aprobado IS NULL OR monto_aprobado > 0),
    CHECK (tasa_interes IS NULL OR tasa_interes >= 0),
    CHECK (plazo_meses IS NULL OR plazo_meses > 0),
    CHECK (tipo_cliente IN ('PERSONA', 'EMPRESA'))
);

-- AGREGADO: Transferencia
-- Valor: Representa el movimiento de fondos entre cuentas
CREATE TABLE transferencia (
    id_transferencia SERIAL PRIMARY KEY,
    numero_transferencia VARCHAR(30) NOT NULL UNIQUE,
    id_cuenta_origen INT NOT NULL,
    id_cuenta_destino INT NOT NULL,
    monto DECIMAL(15,2) NOT NULL,
    estado_transferencia VARCHAR(30) DEFAULT 'PENDIENTE',
    id_usuario_creador INT NOT NULL,
    id_usuario_aprobador INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_aprobacion TIMESTAMP,
    fecha_ejecucion TIMESTAMP,
    fecha_vencimiento TIMESTAMP,
    concepto TEXT,
    tipo_transferencia VARCHAR(30),  -- 'INTERNA', 'TERCERO', 'MASIVA'
    saldo_origen_antes DECIMAL(15,2),
    saldo_origen_despues DECIMAL(15,2),
    saldo_destino_antes DECIMAL(15,2),
    saldo_destino_despues DECIMAL(15,2),
    requiere_aprobacion BOOLEAN DEFAULT FALSE,
    motivo_rechazo TEXT,
    FOREIGN KEY (id_cuenta_origen) REFERENCES cuenta_bancaria(id_cuenta)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_cuenta_destino) REFERENCES cuenta_bancaria(id_cuenta)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario_creador) REFERENCES usuario_sistema(id_usuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario_aprobador) REFERENCES usuario_sistema(id_usuario)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CHECK (monto > 0),
    CHECK (id_cuenta_origen <> id_cuenta_destino)
);

-- ============================================================================
-- 3. ENTIDADES DE SOPORTE (NO SON AGREGADOS RAÍZ)
-- ============================================================================

-- Tabla de Pagos de Préstamo
CREATE TABLE pago_prestamo (
    id_pago SERIAL PRIMARY KEY,
    id_prestamo INT NOT NULL,
    numero_pago INT NOT NULL,
    monto_pago DECIMAL(15,2) NOT NULL,
    monto_interes DECIMAL(15,2) DEFAULT 0.00,
    monto_capital DECIMAL(15,2) NOT NULL,
    saldo_pendiente_antes DECIMAL(15,2),
    saldo_pendiente_despues DECIMAL(15,2),
    fecha_pago_programada DATE,
    fecha_pago_real TIMESTAMP,
    estado_pago VARCHAR(30) DEFAULT 'PENDIENTE',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_prestamo) REFERENCES prestamo(id_prestamo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE(id_prestamo, numero_pago),
    CHECK (monto_pago > 0)
);

-- Tabla de Delegación de Permisos (Para Empresa)
CREATE TABLE delegacion_permisos (
    id_delegacion SERIAL PRIMARY KEY,
    id_empresa INT NOT NULL,
    id_usuario_delegante INT NOT NULL,
    id_usuario_delegado INT NOT NULL,
    tipos_operacion TEXT,  -- JSON: ["TRANSFERENCIAS", "PAGOS", "CONSULTAS"]
    fecha_inicio DATE DEFAULT CURRENT_DATE,
    fecha_fin DATE,
    activa BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_empresa) REFERENCES cliente_empresa(id_cliente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario_delegante) REFERENCES usuario_sistema(id_usuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario_delegado) REFERENCES usuario_sistema(id_usuario)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ============================================================================
-- 4. BITÁCORA DE OPERACIONES (INMUTABLE)
-- ============================================================================

-- Tabla de Bitácora de Operaciones
CREATE TABLE bitacora_operacion (
    id_bitacora SERIAL PRIMARY KEY,
    tipo_operacion VARCHAR(50) NOT NULL,
    fecha_hora_operacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT NOT NULL,
    rol_usuario VARCHAR(50),
    id_producto_afectado INT,
    tipo_producto VARCHAR(50),  -- 'CUENTA', 'PRESTAMO', 'TRANSFERENCIA'
    detalles_operacion JSONB,
    estado_operacion VARCHAR(30) DEFAULT 'EJECUTADA',
    resultado TEXT,
    tabla_afectada VARCHAR(100),
    accion_realizada VARCHAR(100),  -- INSERT, UPDATE, DELETE
    usuario_ip VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES usuario_sistema(id_usuario)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Crear índices para la bitácora
CREATE INDEX idx_bitacora_fecha ON bitacora_operacion(fecha_hora_operacion DESC);
CREATE INDEX idx_bitacora_usuario ON bitacora_operacion(id_usuario);
CREATE INDEX idx_bitacora_tipo_operacion ON bitacora_operacion(tipo_operacion);
CREATE INDEX idx_bitacora_producto ON bitacora_operacion(id_producto_afectado);

-- ============================================================================
-- 5. VISTAS DE DOMINIO (Para queries del dominio)
-- ============================================================================

-- Vista: Cliente Completo (Unificación de Persona y Empresa)
CREATE OR REPLACE VIEW vw_cliente_completo AS
SELECT 
    'PERSONA' AS tipo_cliente,
    id_cliente,
    numero_identificacion AS numero_id,
    nombre_completo AS nombre,
    correo_electronico,
    numero_telefono,
    estado_cliente,
    fecha_registro,
    NULL::VARCHAR AS razon_social,
    NULL::INT AS id_representante_legal
FROM cliente_persona_natural
UNION ALL
SELECT 
    'EMPRESA' AS tipo_cliente,
    id_cliente,
    nit AS numero_id,
    razon_social AS nombre,
    correo_electronico,
    numero_telefono,
    estado_cliente,
    fecha_registro,
    razon_social,
    id_representante_legal
FROM cliente_empresa;

-- Vista: Resumen de Cuentas por Cliente
CREATE OR REPLACE VIEW vw_resumen_cuentas_cliente AS
SELECT 
    c.id_cliente,
    c.tipo_cliente,
    COUNT(*) AS total_cuentas,
    SUM(c.saldo_actual) AS saldo_total,
    COUNT(CASE WHEN c.estado_cuenta = 'ACTIVA' THEN 1 END) AS cuentas_activas,
    COUNT(CASE WHEN c.estado_cuenta = 'BLOQUEADA' THEN 1 END) AS cuentas_bloqueadas
FROM cuenta_bancaria c
GROUP BY c.id_cliente, c.tipo_cliente;

-- Vista: Resumen de Préstamos por Cliente
CREATE OR REPLACE VIEW vw_resumen_prestamos_cliente AS
SELECT 
    p.id_cliente,
    p.tipo_cliente,
    COUNT(*) AS total_prestamos,
    SUM(p.monto_aprobado) AS monto_total_aprobado,
    SUM(p.saldo_pendiente) AS monto_total_pendiente,
    COUNT(CASE WHEN p.estado_prestamo = 'DESEMBOLSADO' THEN 1 END) AS prestamos_activos
FROM prestamo p
GROUP BY p.id_cliente, p.tipo_cliente;

-- Vista: Transferencias Pendientes de Aprobación
CREATE OR REPLACE VIEW vw_transferencias_pendientes_aprobacion AS
SELECT 
    t.*,
    cb_origen.numero_cuenta AS numero_cuenta_origen,
    cb_destino.numero_cuenta AS numero_cuenta_destino,
    cb_origen.saldo_actual AS saldo_origen_actual,
    EXTRACT(EPOCH FROM (NOW() - t.fecha_creacion))/60 AS minutos_pendiente
FROM transferencia t
JOIN cuenta_bancaria cb_origen ON t.id_cuenta_origen = cb_origen.id_cuenta
JOIN cuenta_bancaria cb_destino ON t.id_cuenta_destino = cb_destino.id_cuenta
WHERE t.estado_transferencia = 'EN_ESPERA_APROBACION'
    AND t.requiere_aprobacion = TRUE;

-- Vista: Auditoría de Usuario
CREATE OR REPLACE VIEW vw_auditoria_usuario AS
SELECT 
    b.id_bitacora,
    b.fecha_hora_operacion,
    u.nombre_usuario,
    u.nombre_completo,
    r.nombre_rol,
    b.tipo_operacion,
    b.tipo_producto,
    b.accion_realizada,
    b.detalles_operacion
FROM bitacora_operacion b
JOIN usuario_sistema u ON b.id_usuario = u.id_usuario
JOIN rol_sistema r ON u.id_rol = r.id_rol
ORDER BY b.fecha_hora_operacion DESC;

-- ============================================================================
-- 6. ÍNDICES PARA OPTIMIZACIÓN DE DOMINIO
-- ============================================================================

-- Índices para búsquedas de clientes
CREATE INDEX idx_cliente_persona_numero_id ON cliente_persona_natural(numero_identificacion);
CREATE INDEX idx_cliente_persona_email ON cliente_persona_natural(correo_electronico);
CREATE INDEX idx_cliente_empresa_nit ON cliente_empresa(nit);
CREATE INDEX idx_cliente_empresa_email ON cliente_empresa(correo_electronico);

-- Índices para búsquedas de usuarios
CREATE INDEX idx_usuario_nombre ON usuario_sistema(nombre_usuario);
CREATE INDEX idx_usuario_email ON usuario_sistema(correo_electronico);
CREATE INDEX idx_usuario_id_cliente ON usuario_sistema(id_cliente_relacionado);
CREATE INDEX idx_usuario_rol ON usuario_sistema(id_rol);

-- Índices para búsquedas de cuentas
CREATE INDEX idx_cuenta_numero ON cuenta_bancaria(numero_cuenta);
CREATE INDEX idx_cuenta_cliente ON cuenta_bancaria(id_cliente, tipo_cliente);
CREATE INDEX idx_cuenta_estado ON cuenta_bancaria(estado_cuenta);

-- Índices para búsquedas de préstamos
CREATE INDEX idx_prestamo_numero ON prestamo(numero_prestamo);
CREATE INDEX idx_prestamo_cliente ON prestamo(id_cliente, tipo_cliente);
CREATE INDEX idx_prestamo_estado ON prestamo(estado_prestamo);
CREATE INDEX idx_prestamo_usuario_creador ON prestamo(id_usuario_creador);

-- Índices para búsquedas de transferencias
CREATE INDEX idx_transferencia_numero ON transferencia(numero_transferencia);
CREATE INDEX idx_transferencia_estado ON transferencia(estado_transferencia);
CREATE INDEX idx_transferencia_fecha_creacion ON transferencia(fecha_creacion DESC);
CREATE INDEX idx_transferencia_cuentas ON transferencia(id_cuenta_origen, id_cuenta_destino);
CREATE INDEX idx_transferencia_usuario_creador ON transferencia(id_usuario_creador);

-- ============================================================================
-- 7. INSERTANDO DATOS INICIALES DE CATÁLOGOS
-- ============================================================================

-- Insertar roles del sistema
INSERT INTO rol_sistema (nombre_rol, descripcion, permisos) VALUES
('CLIENTE_PERSONA', 'Cliente Persona Natural', '["consultar_propias_cuentas", "solicitar_prestamo", "realizar_transferencias"]'),
('CLIENTE_EMPRESA', 'Cliente Empresa - Representante Legal', '["consultar_empresa", "delegar_permisos", "aprobar_transferencias"]'),
('EMPLEADO_VENTANILLA', 'Empleado de Ventanilla - Cajero', '["consultar_saldo_clientes", "registrar_cuentas", "procesar_depositos_retiros"]'),
('EMPLEADO_COMERCIAL', 'Empleado Comercial - Asesor', '["consultar_clientes", "solicitar_productos", "seguimiento_solicitudes"]'),
('EMPLEADO_EMPRESA', 'Empleado de Empresa - Usuario Operativo', '["crear_transferencias", "ver_empresa"]'),
('SUPERVISOR_EMPRESA', 'Supervisor de Empresa - Aprobador', '["aprobar_rechazar_transferencias", "gestionar_usuarios_empresa"]'),
('ANALISTA_INTERNO', 'Analista Interno - Riesgo/Compliance', '["aprobar_rechazar_prestamos", "desembolsar_prestamos", "acceso_bitacora_completa"]'),
('ADMINISTRADOR', 'Administrador del Sistema', '["acceso_total"]')
ON CONFLICT DO NOTHING;

-- Insertar estados de usuario
INSERT INTO estado_usuario_catalogo (nombre, descripcion) VALUES
('ACTIVO', 'Usuario activo en el sistema'),
('INACTIVO', 'Usuario inactivo'),
('BLOQUEADO', 'Usuario bloqueado por seguridad'),
('SUSPENDIDO', 'Usuario suspendido temporalmente')
ON CONFLICT DO NOTHING;

-- Insertar estados de cuenta
INSERT INTO estado_cuenta_catalogo (nombre, descripcion) VALUES
('ACTIVA', 'Cuenta activa y operativa'),
('BLOQUEADA', 'Cuenta bloqueada - sin operaciones'),
('SUSPENDIDA', 'Cuenta suspendida temporalmente'),
('CANCELADA', 'Cuenta cancelada - archivada'),
('INACTIVA', 'Cuenta inactiva - requiere reactivación')
ON CONFLICT DO NOTHING;

-- Insertar tipos de cuenta
INSERT INTO tipo_cuenta_catalogo (codigo, nombre, descripcion, requiere_aprobacion) VALUES
('AH', 'Ahorros', 'Cuenta de ahorros para personas', FALSE),
('CC', 'Corriente', 'Cuenta corriente para personas y empresas', FALSE),
('PER', 'Personal', 'Cuenta personal con servicios adicionales', FALSE),
('EMP', 'Empresarial', 'Cuenta empresarial con operaciones masivas', FALSE)
ON CONFLICT DO NOTHING;

-- Insertar estados de préstamo
INSERT INTO estado_prestamo_catalogo (nombre, descripcion) VALUES
('EN_ESTUDIO', 'Préstamo en análisis'),
('APROBADO', 'Préstamo aprobado - pendiente desembolso'),
('DESEMBOLSADO', 'Préstamo desembolsado - activo'),
('RECHAZADO', 'Préstamo rechazado'),
('CANCELADO', 'Préstamo cancelado'),
('VENCIDO', 'Préstamo vencido - mora'),
('PAGADO', 'Préstamo completamente pagado')
ON CONFLICT DO NOTHING;

-- Insertar estados de transferencia
INSERT INTO estado_transferencia_catalogo (nombre, descripcion) VALUES
('PENDIENTE', 'Transferencia pendiente de procesamiento'),
('EN_ESPERA_APROBACION', 'Transferencia esperando aprobación'),
('EJECUTADA', 'Transferencia ejecutada exitosamente'),
('RECHAZADA', 'Transferencia rechazada'),
('VENCIDA', 'Transferencia vencida - no aprobada a tiempo'),
('CANCELADA', 'Transferencia cancelada por usuario'),
('FALLIDA', 'Transferencia fallida por error')
ON CONFLICT DO NOTHING;

-- Insertar monedas
INSERT INTO moneda_catalogo (codigo_iso, nombre, simbolo) VALUES
('USD', 'Dólar Estadounidense', '$'),
('COP', 'Peso Colombiano', '$'),
('EUR', 'Euro', '€'),
('MXN', 'Peso Mexicano', '$'),
('PEN', 'Sol Peruano', 'S/'),
('ARS', 'Peso Argentino', '$')
ON CONFLICT DO NOTHING;

-- Insertar tipos de préstamo
INSERT INTO tipo_prestamo_catalogo 
(codigo, nombre, descripcion, tasa_interes_minima, tasa_interes_maxima, 
 plazo_minimo_meses, plazo_maximo_meses, monto_minimo, monto_maximo) VALUES
('PERSONAL', 'Préstamo Personal', 'Préstamo para personas naturales', 8.50, 18.00, 6, 60, 1000000, 50000000),
('HIPOTECARIO', 'Hipotecario', 'Financiamiento para vivienda', 3.50, 8.00, 120, 360, 50000000, 500000000),
('VEHICULAR', 'Préstamo Vehicular', 'Financiamiento para vehículos', 5.00, 12.00, 24, 84, 10000000, 200000000),
('EMPRESARIAL', 'Préstamo Empresarial', 'Préstamo para empresas', 6.00, 15.00, 12, 120, 10000000, 1000000000),
('NÓMINA', 'Préstamo Nómina', 'Préstamo descontado de nómina', 7.00, 14.00, 6, 36, 500000, 30000000)
ON CONFLICT DO NOTHING;

-- ============================================================================
-- FIN DEL SCRIPT DE CREACIÓN DE SCHEMA DDD
-- ============================================================================
-- El modelo resultante refleja directamente los conceptos de Domain-Driven Design:
-- - ENTIDADES: Cliente Persona, Cliente Empresa, Cuenta, Préstamo, Transferencia
-- - VALUE OBJECTS: Estados, Tipos, Monedas (catálogos)
-- - AGREGADOS RAÍZ: Cada tabla principal es un agregado con integridad propia
-- - REPOSITORIOS: Las vistas permiten acceso consistente a datos del dominio
-- ============================================================================
