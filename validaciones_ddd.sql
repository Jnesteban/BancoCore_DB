-- ============================================================================
-- VALIDACIONES DE DOMINIO - TRIGGERS
-- ============================================================================
-- Propósito: Implementar mecanismos de validación y control de reglas de negocio
-- Descripción: Triggers que aseguran la consistencia del modelo ante operaciones
--              de inserción, actualización o eliminación, evitando que se violen
--              invariantes del dominio
-- ============================================================================

-- ============================================================================
-- 1. VALIDACIONES: CLIENTE PERSONA NATURAL
-- ============================================================================

/**
 * Trigger: Validar edad mínima en Cliente Persona Natural
 * Regla: Debe ser mayor de 18 años
 */
CREATE OR REPLACE FUNCTION trg_validar_edad_cliente_persona()
RETURNS TRIGGER AS $$
DECLARE
    v_edad INT;
BEGIN
    v_edad := EXTRACT(YEAR FROM AGE(NEW.fecha_nacimiento));
    
    IF v_edad < 18 THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Cliente debe ser mayor de 18 años. Edad actual: %', v_edad;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cliente_persona_validar_edad
BEFORE INSERT OR UPDATE ON cliente_persona_natural
FOR EACH ROW
EXECUTE FUNCTION trg_validar_edad_cliente_persona();

/**
 * Trigger: Validar email en Cliente Persona Natural
 */
CREATE OR REPLACE FUNCTION trg_validar_email_cliente_persona()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.correo_electronico !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$' THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Email inválido: %', NEW.correo_electronico;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cliente_persona_validar_email
BEFORE INSERT OR UPDATE ON cliente_persona_natural
FOR EACH ROW
EXECUTE FUNCTION trg_validar_email_cliente_persona();

/**
 * Trigger: Validar teléfono en Cliente Persona Natural
 */
CREATE OR REPLACE FUNCTION trg_validar_telefono_cliente_persona()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.numero_telefono !~ '^[0-9]{7,15}$' THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Teléfono debe contener entre 7 y 15 dígitos';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cliente_persona_validar_telefono
BEFORE INSERT OR UPDATE ON cliente_persona_natural
FOR EACH ROW
EXECUTE FUNCTION trg_validar_telefono_cliente_persona();

/**
 * Trigger: Actualizar timestamp en Cliente Persona Natural
 */
CREATE OR REPLACE FUNCTION trg_cliente_persona_actualizar_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fecha_ultima_actualizacion := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cliente_persona_timestamp
BEFORE UPDATE ON cliente_persona_natural
FOR EACH ROW
EXECUTE FUNCTION trg_cliente_persona_actualizar_timestamp();

-- ============================================================================
-- 2. VALIDACIONES: CLIENTE EMPRESA
-- ============================================================================

/**
 * Trigger: Validar representante legal en Cliente Empresa
 * Regla: Representante debe ser cliente persona natural existente
 */
CREATE OR REPLACE FUNCTION trg_validar_representante_empresa()
RETURNS TRIGGER AS $$
DECLARE
    v_existe BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM cliente_persona_natural 
        WHERE id_cliente = NEW.id_representante_legal
    ) INTO v_existe;
    
    IF NOT v_existe THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Representante legal debe ser cliente persona natural';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cliente_empresa_validar_representante
BEFORE INSERT OR UPDATE ON cliente_empresa
FOR EACH ROW
EXECUTE FUNCTION trg_validar_representante_empresa();

/**
 * Trigger: Actualizar timestamp en Cliente Empresa
 */
CREATE OR REPLACE FUNCTION trg_cliente_empresa_actualizar_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fecha_ultima_actualizacion := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cliente_empresa_timestamp
BEFORE UPDATE ON cliente_empresa
FOR EACH ROW
EXECUTE FUNCTION trg_cliente_empresa_actualizar_timestamp();

-- ============================================================================
-- 3. VALIDACIONES: CUENTA BANCARIA
-- ============================================================================

/**
 * Trigger: Validar que cliente esté activo al abrir cuenta
 * Regla de Negocio: No se puede abrir cuenta a cliente inactivo o bloqueado
 */
CREATE OR REPLACE FUNCTION trg_validar_cliente_activo_cuenta()
RETURNS TRIGGER AS $$
DECLARE
    v_estado_cliente VARCHAR;
BEGIN
    -- Obtener estado del cliente según tipo
    IF NEW.tipo_cliente = 'PERSONA' THEN
        SELECT estado_cliente INTO v_estado_cliente 
        FROM cliente_persona_natural WHERE id_cliente = NEW.id_cliente;
    ELSIF NEW.tipo_cliente = 'EMPRESA' THEN
        SELECT estado_cliente INTO v_estado_cliente 
        FROM cliente_empresa WHERE id_cliente = NEW.id_cliente;
    ELSE
        RAISE EXCEPTION 'ERROR DE DOMINIO: Tipo de cliente no válido';
    END IF;
    
    IF v_estado_cliente NOT IN ('ACTIVO') THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: No se puede abrir cuenta a cliente inactivo o bloqueado';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cuenta_validar_cliente_activo
BEFORE INSERT ON cuenta_bancaria
FOR EACH ROW
EXECUTE FUNCTION trg_validar_cliente_activo_cuenta();

/**
 * Trigger: Validar tipo de cuenta válido
 */
CREATE OR REPLACE FUNCTION trg_validar_tipo_cuenta()
RETURNS TRIGGER AS $$
DECLARE
    v_existe BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM tipo_cuenta_catalogo 
        WHERE id_tipo = NEW.id_tipo_cuenta AND activo = TRUE
    ) INTO v_existe;
    
    IF NOT v_existe THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Tipo de cuenta no es válido o está inactivo';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cuenta_validar_tipo
BEFORE INSERT ON cuenta_bancaria
FOR EACH ROW
EXECUTE FUNCTION trg_validar_tipo_cuenta();

/**
 * Trigger: Validar operaciones en cuentas bloqueadas/canceladas
 * Regla: No se permiten operaciones (transferencias, retiros) en cuentas con
 *        Estado_Cuenta 'Bloqueada' o 'Cancelada'
 */
CREATE OR REPLACE FUNCTION trg_validar_cuenta_operativa_transferencia()
RETURNS TRIGGER AS $$
DECLARE
    v_estado_origen VARCHAR;
BEGIN
    -- Obtener estado de cuenta origen
    SELECT estado_cuenta INTO v_estado_origen
    FROM cuenta_bancaria
    WHERE id_cuenta = NEW.id_cuenta_origen;
    
    IF v_estado_origen NOT IN ('ACTIVA') THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: No se pueden realizar operaciones en cuenta bloqueada o cancelada';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_transferencia_validar_cuenta_operativa
BEFORE INSERT ON transferencia
FOR EACH ROW
EXECUTE FUNCTION trg_validar_cuenta_operativa_transferencia();

/**
 * Trigger: Validar saldo inicial mayor o igual a cero
 */
CREATE OR REPLACE FUNCTION trg_validar_saldo_inicial_cuenta()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.saldo_actual < 0 THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: El saldo no puede ser negativo';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cuenta_validar_saldo_inicial
BEFORE INSERT ON cuenta_bancaria
FOR EACH ROW
EXECUTE FUNCTION trg_validar_saldo_inicial_cuenta();

-- ============================================================================
-- 4. VALIDACIONES: TRANSFERENCIA
-- ============================================================================

/**
 * Trigger: Validar que monto sea mayor a cero
 */
CREATE OR REPLACE FUNCTION trg_validar_monto_transferencia()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.monto <= 0 THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: El monto de transferencia debe ser mayor a cero';
    END IF;
    
    -- Validar que no sea a la misma cuenta
    IF NEW.id_cuenta_origen = NEW.id_cuenta_destino THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: No se puede transferir a la misma cuenta';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_transferencia_validar_monto
BEFORE INSERT ON transferencia
FOR EACH ROW
EXECUTE FUNCTION trg_validar_monto_transferencia();

/**
 * Trigger: Validar fondos suficientes en transferencias PENDIENTE
 * Regla: No se permite ejecutar transferencias desde Cuenta_Origen con 
 *        Saldo_Actual insuficiente
 * Nota: Solo aplica para transferencias que se ejecutan inmediatamente
 */
CREATE OR REPLACE FUNCTION trg_validar_fondos_transferencia()
RETURNS TRIGGER AS $$
DECLARE
    v_saldo_origen DECIMAL;
BEGIN
    -- Solo validar si la transferencia NO requiere aprobación y es PENDIENTE
    IF NEW.requiere_aprobacion = FALSE AND NEW.estado_transferencia = 'PENDIENTE' THEN
        SELECT saldo_actual INTO v_saldo_origen
        FROM cuenta_bancaria
        WHERE id_cuenta = NEW.id_cuenta_origen;
        
        IF v_saldo_origen < NEW.monto THEN
            RAISE EXCEPTION 'ERROR DE DOMINIO: Fondos insuficientes. Disponible: %, Requerido: %', 
                v_saldo_origen, NEW.monto;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_transferencia_validar_fondos
BEFORE INSERT ON transferencia
FOR EACH ROW
EXECUTE FUNCTION trg_validar_fondos_transferencia();

/**
 * Trigger: Validar que cuentas origen y destino existan
 */
CREATE OR REPLACE FUNCTION trg_validar_cuentas_existen()
RETURNS TRIGGER AS $$
DECLARE
    v_cuenta_origen_existe BOOLEAN;
    v_cuenta_destino_existe BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM cuenta_bancaria WHERE id_cuenta = NEW.id_cuenta_origen) 
    INTO v_cuenta_origen_existe;
    
    SELECT EXISTS (SELECT 1 FROM cuenta_bancaria WHERE id_cuenta = NEW.id_cuenta_destino) 
    INTO v_cuenta_destino_existe;
    
    IF NOT v_cuenta_origen_existe THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Cuenta origen no existe';
    END IF;
    
    IF NOT v_cuenta_destino_existe THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Cuenta destino no existe';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_transferencia_validar_cuentas_existen
BEFORE INSERT ON transferencia
FOR EACH ROW
EXECUTE FUNCTION trg_validar_cuentas_existen();

/**
 * Trigger: Prevenir modificación de transferencia ejecutada
 */
CREATE OR REPLACE FUNCTION trg_prevenir_modificacion_transferencia_ejecutada()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.estado_transferencia = 'EJECUTADA' AND NEW.estado_transferencia <> OLD.estado_transferencia THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: No se puede modificar una transferencia ejecutada';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_transferencia_prevenir_modificacion
BEFORE UPDATE ON transferencia
FOR EACH ROW
EXECUTE FUNCTION trg_prevenir_modificacion_transferencia_ejecutada();

-- ============================================================================
-- 5. VALIDACIONES: PRÉSTAMO
-- ============================================================================

/**
 * Trigger: Validar monto solicitado válido
 */
CREATE OR REPLACE FUNCTION trg_validar_monto_prestamo()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.monto_solicitado <= 0 THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Monto solicitado debe ser mayor a cero';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prestamo_validar_monto_solicitado
BEFORE INSERT ON prestamo
FOR EACH ROW
EXECUTE FUNCTION trg_validar_monto_prestamo();

/**
 * Trigger: Validar cliente activo para préstamo
 */
CREATE OR REPLACE FUNCTION trg_validar_cliente_activo_prestamo()
RETURNS TRIGGER AS $$
DECLARE
    v_estado_cliente VARCHAR;
BEGIN
    -- Obtener estado del cliente según tipo
    IF NEW.tipo_cliente = 'PERSONA' THEN
        SELECT estado_cliente INTO v_estado_cliente 
        FROM cliente_persona_natural WHERE id_cliente = NEW.id_cliente;
    ELSIF NEW.tipo_cliente = 'EMPRESA' THEN
        SELECT estado_cliente INTO v_estado_cliente 
        FROM cliente_empresa WHERE id_cliente = NEW.id_cliente;
    ELSE
        RAISE EXCEPTION 'ERROR DE DOMINIO: Tipo de cliente no válido';
    END IF;
    
    IF v_estado_cliente NOT IN ('ACTIVO') THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Cliente debe estar activo para solicitar préstamo';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prestamo_validar_cliente_activo
BEFORE INSERT ON prestamo
FOR EACH ROW
EXECUTE FUNCTION trg_validar_cliente_activo_prestamo();

/**
 * Trigger: Validar tipo de préstamo válido
 */
CREATE OR REPLACE FUNCTION trg_validar_tipo_prestamo()
RETURNS TRIGGER AS $$
DECLARE
    v_existe BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM tipo_prestamo_catalogo 
        WHERE id_tipo = NEW.id_tipo_prestamo AND activo = TRUE
    ) INTO v_existe;
    
    IF NOT v_existe THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Tipo de préstamo no es válido o está inactivo';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prestamo_validar_tipo
BEFORE INSERT ON prestamo
FOR EACH ROW
EXECUTE FUNCTION trg_validar_tipo_prestamo();

/**
 * Trigger: Validar transiciones de estado en préstamo
 * Regla: Un préstamo solo puede pasar de "En estudio" a "Aprobado" o "Rechazado"
 *        El paso a "Desembolsado" solo es posible desde el estado "Aprobado"
 */
CREATE OR REPLACE FUNCTION trg_validar_transiciones_prestamo()
RETURNS TRIGGER AS $$
BEGIN
    -- Validar transiciones permitidas
    IF NEW.estado_prestamo <> OLD.estado_prestamo THEN
        -- De EN_ESTUDIO solo puede ir a APROBADO o RECHAZADO
        IF OLD.estado_prestamo = 'EN_ESTUDIO' THEN
            IF NEW.estado_prestamo NOT IN ('APROBADO', 'RECHAZADO') THEN
                RAISE EXCEPTION 'ERROR DE DOMINIO: Transición no permitida de % a %', 
                    OLD.estado_prestamo, NEW.estado_prestamo;
            END IF;
        -- De APROBADO solo puede ir a DESEMBOLSADO o CANCELADO
        ELSIF OLD.estado_prestamo = 'APROBADO' THEN
            IF NEW.estado_prestamo NOT IN ('DESEMBOLSADO', 'CANCELADO') THEN
                RAISE EXCEPTION 'ERROR DE DOMINIO: Transición no permitida de % a %', 
                    OLD.estado_prestamo, NEW.estado_prestamo;
            END IF;
        -- De DESEMBOLSADO solo puede ir a PAGADO, VENCIDO o CANCELADO
        ELSIF OLD.estado_prestamo = 'DESEMBOLSADO' THEN
            IF NEW.estado_prestamo NOT IN ('PAGADO', 'VENCIDO', 'CANCELADO') THEN
                RAISE EXCEPTION 'ERROR DE DOMINIO: Transición no permitida de % a %', 
                    OLD.estado_prestamo, NEW.estado_prestamo;
            END IF;
        -- Estados finales no pueden cambiar
        ELSIF OLD.estado_prestamo IN ('RECHAZADO', 'PAGADO', 'VENCIDO', 'CANCELADO') THEN
            RAISE EXCEPTION 'ERROR DE DOMINIO: No se puede cambiar estado de un préstamo %', 
                OLD.estado_prestamo;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prestamo_validar_transiciones
BEFORE UPDATE ON prestamo
FOR EACH ROW
EXECUTE FUNCTION trg_validar_transiciones_prestamo();

/**
 * Trigger: Validar desembolso tiene cuenta destino válida
 * Regla: No se puede marcar como "Desembolsado" sin definir cuenta_destino_desembolso
 */
CREATE OR REPLACE FUNCTION trg_validar_desembolso_cuenta_destino()
RETURNS TRIGGER AS $$
DECLARE
    v_cuenta_existe BOOLEAN;
    v_cuenta_activa BOOLEAN;
BEGIN
    -- Solo validar si cambia a DESEMBOLSADO
    IF NEW.estado_prestamo = 'DESEMBOLSADO' AND OLD.estado_prestamo <> 'DESEMBOLSADO' THEN
        -- Validar que cuenta destino está definida
        IF NEW.id_cuenta_destino_desembolso IS NULL THEN
            RAISE EXCEPTION 'ERROR DE DOMINIO: Debe definir cuenta destino para desembolso';
        END IF;
        
        -- Validar que cuenta existe y está activa
        SELECT EXISTS (
            SELECT 1 FROM cuenta_bancaria 
            WHERE id_cuenta = NEW.id_cuenta_destino_desembolso AND estado_cuenta = 'ACTIVA'
        ) INTO v_cuenta_activa;
        
        IF NOT v_cuenta_activa THEN
            RAISE EXCEPTION 'ERROR DE DOMINIO: Cuenta destino debe existir y estar activa';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prestamo_validar_desembolso_cuenta
BEFORE UPDATE ON prestamo
FOR EACH ROW
EXECUTE FUNCTION trg_validar_desembolso_cuenta_destino();

/**
 * Trigger: Validar monto aprobado mayor a cero
 */
CREATE OR REPLACE FUNCTION trg_validar_monto_aprobado()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.monto_aprobado IS NOT NULL AND NEW.monto_aprobado <= 0 THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Monto aprobado debe ser mayor a cero';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prestamo_validar_monto_aprobado
BEFORE UPDATE ON prestamo
FOR EACH ROW
EXECUTE FUNCTION trg_validar_monto_aprobado();

-- ============================================================================
-- 6. VALIDACIONES: USUARIO SISTEMA
-- ============================================================================

/**
 * Trigger: Validar que rol existe
 */
CREATE OR REPLACE FUNCTION trg_validar_rol_usuario()
RETURNS TRIGGER AS $$
DECLARE
    v_existe BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM rol_sistema 
        WHERE id_rol = NEW.id_rol AND activo = TRUE
    ) INTO v_existe;
    
    IF NOT v_existe THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Rol no existe o está inactivo';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_usuario_validar_rol
BEFORE INSERT OR UPDATE ON usuario_sistema
FOR EACH ROW
EXECUTE FUNCTION trg_validar_rol_usuario();

/**
 * Trigger: Validar email de usuario
 */
CREATE OR REPLACE FUNCTION trg_validar_email_usuario()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.correo_electronico !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$' THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Email de usuario inválido';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_usuario_validar_email
BEFORE INSERT OR UPDATE ON usuario_sistema
FOR EACH ROW
EXECUTE FUNCTION trg_validar_email_usuario();

-- ============================================================================
-- 7. VALIDACIONES: PAGO PRESTAMO
-- ============================================================================

/**
 * Trigger: Validar monto de pago mayor a cero
 */
CREATE OR REPLACE FUNCTION trg_validar_monto_pago()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.monto_pago <= 0 THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Monto de pago debe ser mayor a cero';
    END IF;
    
    IF NEW.monto_capital <= 0 THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Monto de capital debe ser mayor a cero';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_pago_validar_montos
BEFORE INSERT ON pago_prestamo
FOR EACH ROW
EXECUTE FUNCTION trg_validar_monto_pago();

/**
 * Trigger: Validar que préstamo existe
 */
CREATE OR REPLACE FUNCTION trg_validar_prestamo_existe()
RETURNS TRIGGER AS $$
DECLARE
    v_existe BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM prestamo WHERE id_prestamo = NEW.id_prestamo
    ) INTO v_existe;
    
    IF NOT v_existe THEN
        RAISE EXCEPTION 'ERROR DE DOMINIO: Préstamo no existe';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_pago_validar_prestamo_existe
BEFORE INSERT ON pago_prestamo
FOR EACH ROW
EXECUTE FUNCTION trg_validar_prestamo_existe();

-- ============================================================================
-- 8. TRIGGERS DE AUDITORÍA
-- ============================================================================

/**
 * Trigger: Registrar cambios en Cliente Persona Natural en bitácora
 */
CREATE OR REPLACE FUNCTION trg_auditar_cliente_persona()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO bitacora_operacion (
        tipo_operacion,
        id_usuario,
        id_producto_afectado,
        tipo_producto,
        tabla_afectada,
        accion_realizada,
        detalles_operacion,
        resultado
    ) VALUES (
        'CLIENTE_PERSONA_MODIFICADO',
        1,  -- Usuario sistema
        NEW.id_cliente,
        'CLIENTE',
        'cliente_persona_natural',
        TG_OP,
        jsonb_build_object(
            'nombre_completo', NEW.nombre_completo,
            'email', NEW.correo_electronico,
            'estado', NEW.estado_cliente
        ),
        'Automático'
    );
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditar_cliente_persona
AFTER INSERT OR UPDATE ON cliente_persona_natural
FOR EACH ROW
EXECUTE FUNCTION trg_auditar_cliente_persona();

/**
 * Trigger: Registrar cambios en Cuenta Bancaria
 */
CREATE OR REPLACE FUNCTION trg_auditar_cuenta_bancaria()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO bitacora_operacion (
        tipo_operacion,
        id_usuario,
        id_producto_afectado,
        tipo_producto,
        tabla_afectada,
        accion_realizada,
        detalles_operacion,
        resultado
    ) VALUES (
        CASE 
            WHEN TG_OP = 'INSERT' THEN 'CUENTA_ABIERTA'
            WHEN TG_OP = 'UPDATE' THEN 'CUENTA_MODIFICADA'
            WHEN TG_OP = 'DELETE' THEN 'CUENTA_ELIMINADA'
        END,
        1,  -- Usuario sistema
        COALESCE(NEW.id_cuenta, OLD.id_cuenta),
        'CUENTA',
        'cuenta_bancaria',
        TG_OP,
        jsonb_build_object(
            'numero_cuenta', COALESCE(NEW.numero_cuenta, OLD.numero_cuenta),
            'estado', COALESCE(NEW.estado_cuenta, OLD.estado_cuenta),
            'saldo_actual', COALESCE(NEW.saldo_actual, OLD.saldo_actual)
        ),
        'Automático'
    );
    
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditar_cuenta_bancaria
AFTER INSERT OR UPDATE OR DELETE ON cuenta_bancaria
FOR EACH ROW
EXECUTE FUNCTION trg_auditar_cuenta_bancaria();

-- ============================================================================
-- FIN DEL SCRIPT DE VALIDACIONES CON TRIGGERS
-- ============================================================================
-- Los triggers implementados garantizan:
-- 1. Integridad de datos (validación de formato, rango, etc.)
-- 2. Reglas de negocio (edad, estados, transiciones)
-- 3. Consistencia del dominio (relaciones, dependencias)
-- 4. Auditoría (registro de cambios para trazabilidad)
-- ============================================================================
