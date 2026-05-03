-- ============================================================================
-- SERVICIOS DE DOMINIO - PROCEDIMIENTOS ALMACENADOS
-- ============================================================================
-- Propósito: Encapsular la lógica de negocio del dominio bancario
-- Descripción: Procedimientos que representan operaciones significativas del
--              sistema, controlando el flujo de datos y centralizando la lógica
-- ============================================================================

-- ============================================================================
-- 1. SERVICIOS DE DOMINIO: GESTIÓN DE CLIENTES
-- ============================================================================

/**
 * Servicio: Registrar Cliente Persona Natural
 * Descripción: Crea un nuevo cliente persona natural validando todas las reglas
 * Reglas:
 *   - Número de identificación único
 *   - Email válido
 *   - Mayor de 18 años
 * Genera evento: CLIENTE_CREADO en bitácora
 */
CREATE OR REPLACE FUNCTION sd_registrar_cliente_persona(
    p_numero_id VARCHAR,
    p_nombre_completo VARCHAR,
    p_email VARCHAR,
    p_telefono VARCHAR,
    p_fecha_nacimiento DATE,
    p_direccion TEXT,
    p_ciudad VARCHAR,
    p_pais VARCHAR,
    p_id_usuario_creador INT,
    OUT p_id_cliente INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_edad INT;
    v_existe BOOLEAN;
BEGIN
    -- Validar que no existe cliente con este número de identificación
    SELECT EXISTS (
        SELECT 1 FROM cliente_persona_natural WHERE numero_identificacion = p_numero_id
    ) INTO v_existe;
    
    IF v_existe THEN
        p_mensaje := 'ERROR: Número de identificación ya existe en el sistema';
        p_id_cliente := NULL;
        RETURN;
    END IF;
    
    -- Validar edad mayor de 18 años
    v_edad := EXTRACT(YEAR FROM AGE(p_fecha_nacimiento));
    IF v_edad < 18 THEN
        p_mensaje := 'ERROR: Cliente debe ser mayor de 18 años';
        p_id_cliente := NULL;
        RETURN;
    END IF;
    
    -- Insertar nuevo cliente
    INSERT INTO cliente_persona_natural (
        numero_identificacion,
        nombre_completo,
        correo_electronico,
        numero_telefono,
        fecha_nacimiento,
        direccion,
        ciudad,
        pais,
        estado_cliente
    ) VALUES (
        p_numero_id,
        p_nombre_completo,
        p_email,
        p_telefono,
        p_fecha_nacimiento,
        p_direccion,
        p_ciudad,
        p_pais,
        'ACTIVO'
    ) RETURNING id_cliente INTO p_id_cliente;
    
    -- Registrar en bitácora
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
        'CLIENTE_CREADO',
        p_id_usuario_creador,
        p_id_cliente,
        'CLIENTE',
        'cliente_persona_natural',
        'INSERT',
        jsonb_build_object(
            'numero_identificacion', p_numero_id,
            'nombre_completo', p_nombre_completo,
            'email', p_email
        ),
        'Exitoso'
    );
    
    p_mensaje := 'Cliente persona natural registrado exitosamente. ID: ' || p_id_cliente;
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
    p_id_cliente := NULL;
END;
$$;

/**
 * Servicio: Registrar Cliente Empresa
 * Descripción: Crea un nuevo cliente empresa validando reglas de negocio
 * Reglas:
 *   - NIT único
 *   - Representante legal debe ser cliente persona existente
 */
CREATE OR REPLACE FUNCTION sd_registrar_cliente_empresa(
    p_nit VARCHAR,
    p_razon_social VARCHAR,
    p_email VARCHAR,
    p_telefono VARCHAR,
    p_direccion TEXT,
    p_ciudad VARCHAR,
    p_pais VARCHAR,
    p_id_representante_legal INT,
    p_id_usuario_creador INT,
    OUT p_id_cliente INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_existe BOOLEAN;
    v_representante_existe BOOLEAN;
BEGIN
    -- Validar que no existe empresa con este NIT
    SELECT EXISTS (
        SELECT 1 FROM cliente_empresa WHERE nit = p_nit
    ) INTO v_existe;
    
    IF v_existe THEN
        p_mensaje := 'ERROR: NIT ya existe en el sistema';
        p_id_cliente := NULL;
        RETURN;
    END IF;
    
    -- Validar que representante legal existe
    SELECT EXISTS (
        SELECT 1 FROM cliente_persona_natural WHERE id_cliente = p_id_representante_legal
    ) INTO v_representante_existe;
    
    IF NOT v_representante_existe THEN
        p_mensaje := 'ERROR: Representante legal no existe como cliente persona';
        p_id_cliente := NULL;
        RETURN;
    END IF;
    
    -- Insertar nueva empresa
    INSERT INTO cliente_empresa (
        nit,
        razon_social,
        correo_electronico,
        numero_telefono,
        direccion,
        ciudad,
        pais,
        id_representante_legal,
        estado_cliente
    ) VALUES (
        p_nit,
        p_razon_social,
        p_email,
        p_telefono,
        p_direccion,
        p_ciudad,
        p_pais,
        p_id_representante_legal,
        'ACTIVO'
    ) RETURNING id_cliente INTO p_id_cliente;
    
    -- Registrar en bitácora
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
        'CLIENTE_EMPRESA_CREADO',
        p_id_usuario_creador,
        p_id_cliente,
        'CLIENTE',
        'cliente_empresa',
        'INSERT',
        jsonb_build_object(
            'nit', p_nit,
            'razon_social', p_razon_social,
            'representante_legal', p_id_representante_legal
        ),
        'Exitoso'
    );
    
    p_mensaje := 'Cliente empresa registrado exitosamente. ID: ' || p_id_cliente;
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
    p_id_cliente := NULL;
END;
$$;

-- ============================================================================
-- 2. SERVICIOS DE DOMINIO: GESTIÓN DE CUENTAS BANCARIAS
-- ============================================================================

/**
 * Servicio: Abrir Nueva Cuenta Bancaria
 * Descripción: Crea una nueva cuenta para un cliente
 * Reglas de Negocio:
 *   - Cliente debe estar activo (estado_usuario <> 'INACTIVO' y <> 'BLOQUEADO')
 *   - Número de cuenta debe ser único
 *   - El tipo de cuenta debe ser válido
 */
CREATE OR REPLACE FUNCTION sd_abrir_cuenta_bancaria(
    p_id_cliente INT,
    p_tipo_cliente VARCHAR,
    p_id_tipo_cuenta INT,
    p_id_moneda INT,
    p_saldo_inicial DECIMAL DEFAULT 0,
    p_id_usuario_creador INT,
    OUT p_id_cuenta INT,
    OUT p_numero_cuenta VARCHAR,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_cliente VARCHAR;
    v_tipo_cuenta_existe BOOLEAN;
    v_numero_cuenta VARCHAR;
    v_contador INT;
BEGIN
    -- Validar cliente según tipo
    IF p_tipo_cliente = 'PERSONA' THEN
        SELECT estado_cliente INTO v_estado_cliente 
        FROM cliente_persona_natural WHERE id_cliente = p_id_cliente;
    ELSIF p_tipo_cliente = 'EMPRESA' THEN
        SELECT estado_cliente INTO v_estado_cliente 
        FROM cliente_empresa WHERE id_cliente = p_id_cliente;
    ELSE
        p_mensaje := 'ERROR: Tipo de cliente inválido';
        RETURN;
    END IF;
    
    -- Verificar estado del cliente
    IF v_estado_cliente NOT IN ('ACTIVO') THEN
        p_mensaje := 'ERROR: No se puede abrir cuenta a cliente inactivo o bloqueado';
        p_id_cuenta := NULL;
        RETURN;
    END IF;
    
    -- Validar tipo de cuenta existe
    SELECT EXISTS (
        SELECT 1 FROM tipo_cuenta_catalogo WHERE id_tipo = p_id_tipo_cuenta AND activo = TRUE
    ) INTO v_tipo_cuenta_existe;
    
    IF NOT v_tipo_cuenta_existe THEN
        p_mensaje := 'ERROR: Tipo de cuenta no válido';
        p_id_cuenta := NULL;
        RETURN;
    END IF;
    
    -- Generar número de cuenta único (formato: BANCO-TIPO-CLIENTE-SECUENCIAL)
    SELECT COUNT(*) + 1 INTO v_contador 
    FROM cuenta_bancaria 
    WHERE id_cliente = p_id_cliente;
    
    v_numero_cuenta := p_tipo_cliente || '-' || p_id_tipo_cuenta || '-' || p_id_cliente || '-' || 
                       LPAD(v_contador::TEXT, 4, '0');
    
    -- Insertar nueva cuenta
    INSERT INTO cuenta_bancaria (
        numero_cuenta,
        id_cliente,
        tipo_cliente,
        id_tipo_cuenta,
        saldo_actual,
        saldo_disponible,
        id_moneda,
        estado_cuenta,
        activa
    ) VALUES (
        v_numero_cuenta,
        p_id_cliente,
        p_tipo_cliente,
        p_id_tipo_cuenta,
        p_saldo_inicial,
        p_saldo_inicial,
        p_id_moneda,
        'ACTIVA',
        TRUE
    ) RETURNING id_cuenta INTO p_id_cuenta;
    
    p_numero_cuenta := v_numero_cuenta;
    
    -- Registrar en bitácora
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
        'CUENTA_ABIERTA',
        p_id_usuario_creador,
        p_id_cuenta,
        'CUENTA',
        'cuenta_bancaria',
        'INSERT',
        jsonb_build_object(
            'numero_cuenta', v_numero_cuenta,
            'cliente_id', p_id_cliente,
            'tipo_cliente', p_tipo_cliente,
            'tipo_cuenta', p_id_tipo_cuenta,
            'saldo_inicial', p_saldo_inicial
        ),
        'Exitoso'
    );
    
    p_mensaje := 'Cuenta bancaria abierta exitosamente';
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
    p_id_cuenta := NULL;
    p_numero_cuenta := NULL;
END;
$$;

-- ============================================================================
-- 3. SERVICIOS DE DOMINIO: GESTIÓN DE TRANSFERENCIAS
-- ============================================================================

/**
 * Servicio: Crear Solicitud de Transferencia
 * Descripción: Crea una nueva transferencia con validaciones de negocio
 * Reglas:
 *   - Cuentas origen y destino deben existir y estar activas
 *   - Monto debe ser mayor a cero
 *   - Si es empresa y monto > umbral, requiere aprobación
 *   - Registra saldos antes y después
 */
CREATE OR REPLACE FUNCTION sd_crear_transferencia(
    p_id_cuenta_origen INT,
    p_id_cuenta_destino INT,
    p_monto DECIMAL,
    p_concepto TEXT,
    p_id_usuario_creador INT,
    p_umbral_aprobacion DECIMAL DEFAULT 10000000,
    OUT p_id_transferencia INT,
    OUT p_numero_transferencia VARCHAR,
    OUT p_estado VARCHAR,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_saldo_origen DECIMAL;
    v_saldo_destino DECIMAL;
    v_estado_cuenta_origen VARCHAR;
    v_estado_cuenta_destino VARCHAR;
    v_estado_transferencia VARCHAR;
    v_requiere_aprobacion BOOLEAN;
    v_tipo_cliente_origen VARCHAR;
    v_numero_transferencia VARCHAR;
    v_contador INT;
BEGIN
    -- Validar que el monto sea mayor a cero
    IF p_monto <= 0 THEN
        p_mensaje := 'ERROR: El monto debe ser mayor a cero';
        RETURN;
    END IF;
    
    -- Validar que no sea transferencia a la misma cuenta
    IF p_id_cuenta_origen = p_id_cuenta_destino THEN
        p_mensaje := 'ERROR: No se puede transferir a la misma cuenta';
        RETURN;
    END IF;
    
    -- Obtener información de la cuenta origen
    SELECT 
        c.saldo_actual,
        c.estado_cuenta,
        c.tipo_cliente,
        m.saldo_actual
    INTO 
        v_saldo_origen,
        v_estado_cuenta_origen,
        v_tipo_cliente_origen,
        v_saldo_destino
    FROM cuenta_bancaria c
    LEFT JOIN cuenta_bancaria m ON c.id_cuenta = p_id_cuenta_destino
    WHERE c.id_cuenta = p_id_cuenta_origen;
    
    -- Validar que cuenta origen existe
    IF v_saldo_origen IS NULL THEN
        p_mensaje := 'ERROR: Cuenta origen no existe';
        RETURN;
    END IF;
    
    -- Validar que cuenta origen esté activa
    IF v_estado_cuenta_origen NOT IN ('ACTIVA') THEN
        p_mensaje := 'ERROR: Cuenta origen bloqueada o cancelada';
        RETURN;
    END IF;
    
    -- Obtener información de la cuenta destino
    SELECT 
        saldo_actual,
        estado_cuenta
    INTO 
        v_saldo_destino,
        v_estado_cuenta_destino
    FROM cuenta_bancaria
    WHERE id_cuenta = p_id_cuenta_destino;
    
    -- Validar que cuenta destino existe
    IF v_saldo_destino IS NULL THEN
        p_mensaje := 'ERROR: Cuenta destino no existe';
        RETURN;
    END IF;
    
    -- Validar que cuenta destino esté activa
    IF v_estado_cuenta_destino NOT IN ('ACTIVA') THEN
        p_mensaje := 'ERROR: Cuenta destino bloqueada o cancelada';
        RETURN;
    END IF;
    
    -- Determinar si requiere aprobación (transferencias de empresa > umbral)
    v_requiere_aprobacion := (v_tipo_cliente_origen = 'EMPRESA' AND p_monto > p_umbral_aprobacion);
    
    -- Definir estado inicial
    IF v_requiere_aprobacion THEN
        v_estado_transferencia := 'EN_ESPERA_APROBACION';
    ELSE
        -- Validar fondos suficientes solo si no requiere aprobación
        IF v_saldo_origen < p_monto THEN
            p_mensaje := 'ERROR: Fondos insuficientes en la cuenta origen';
            RETURN;
        END IF;
        v_estado_transferencia := 'PENDIENTE';
    END IF;
    
    -- Generar número de transferencia único
    SELECT COUNT(*) + 1 INTO v_contador FROM transferencia;
    v_numero_transferencia := 'TRF-' || TO_CHAR(NOW(), 'YYYYMMDD') || '-' || 
                               LPAD(v_contador::TEXT, 6, '0');
    
    -- Insertar transferencia
    INSERT INTO transferencia (
        numero_transferencia,
        id_cuenta_origen,
        id_cuenta_destino,
        monto,
        concepto,
        estado_transferencia,
        requiere_aprobacion,
        id_usuario_creador,
        saldo_origen_antes,
        saldo_destino_antes,
        fecha_creacion,
        tipo_transferencia,
        fecha_vencimiento
    ) VALUES (
        v_numero_transferencia,
        p_id_cuenta_origen,
        p_id_cuenta_destino,
        p_monto,
        p_concepto,
        v_estado_transferencia,
        v_requiere_aprobacion,
        p_id_usuario_creador,
        v_saldo_origen,
        v_saldo_destino,
        CURRENT_TIMESTAMP,
        'INTERNA',
        CASE 
            WHEN v_requiere_aprobacion THEN CURRENT_TIMESTAMP + INTERVAL '1 hour'
            ELSE NULL
        END
    ) RETURNING id_transferencia INTO p_id_transferencia;
    
    -- Si no requiere aprobación, ejecutar inmediatamente
    IF NOT v_requiere_aprobacion THEN
        PERFORM sd_ejecutar_transferencia(p_id_transferencia, p_id_usuario_creador);
    END IF;
    
    -- Registrar en bitácora
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
        'TRANSFERENCIA_CREADA',
        p_id_usuario_creador,
        p_id_transferencia,
        'TRANSFERENCIA',
        'transferencia',
        'INSERT',
        jsonb_build_object(
            'numero_transferencia', v_numero_transferencia,
            'monto', p_monto,
            'requiere_aprobacion', v_requiere_aprobacion
        ),
        'Exitoso'
    );
    
    p_numero_transferencia := v_numero_transferencia;
    p_estado := v_estado_transferencia;
    p_mensaje := 'Transferencia creada: ' || v_numero_transferencia;
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
    p_id_transferencia := NULL;
END;
$$;

/**
 * Servicio: Ejecutar Transferencia
 * Descripción: Ejecuta una transferencia validada moviendo fondos
 */
CREATE OR REPLACE FUNCTION sd_ejecutar_transferencia(
    p_id_transferencia INT,
    p_id_usuario_ejecutor INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_cuenta_origen INT;
    v_id_cuenta_destino INT;
    v_monto DECIMAL;
    v_saldo_origen_actual DECIMAL;
    v_saldo_destino_actual DECIMAL;
    v_saldo_origen_nuevo DECIMAL;
    v_saldo_destino_nuevo DECIMAL;
    v_estado_transferencia VARCHAR;
BEGIN
    -- Obtener datos de transferencia
    SELECT 
        id_cuenta_origen,
        id_cuenta_destino,
        monto,
        estado_transferencia
    INTO 
        v_id_cuenta_origen,
        v_id_cuenta_destino,
        v_monto,
        v_estado_transferencia
    FROM transferencia
    WHERE id_transferencia = p_id_transferencia;
    
    -- Validar que transferencia existe
    IF v_id_cuenta_origen IS NULL THEN
        p_mensaje := 'ERROR: Transferencia no encontrada';
        RETURN;
    END IF;
    
    -- Obtener saldos actuales
    SELECT saldo_actual INTO v_saldo_origen_actual
    FROM cuenta_bancaria
    WHERE id_cuenta = v_id_cuenta_origen;
    
    SELECT saldo_actual INTO v_saldo_destino_actual
    FROM cuenta_bancaria
    WHERE id_cuenta = v_id_cuenta_destino;
    
    -- Validar fondos suficientes
    IF v_saldo_origen_actual < v_monto THEN
        -- Actualizar estado a FALLIDA
        UPDATE transferencia
        SET estado_transferencia = 'FALLIDA'
        WHERE id_transferencia = p_id_transferencia;
        
        p_mensaje := 'ERROR: Fondos insuficientes al momento de ejecutar transferencia';
        RETURN;
    END IF;
    
    -- Calcular nuevos saldos
    v_saldo_origen_nuevo := v_saldo_origen_actual - v_monto;
    v_saldo_destino_nuevo := v_saldo_destino_actual + v_monto;
    
    -- Actualizar saldos
    UPDATE cuenta_bancaria
    SET saldo_actual = v_saldo_origen_nuevo,
        saldo_disponible = v_saldo_origen_nuevo,
        fecha_ultima_movimiento = CURRENT_TIMESTAMP
    WHERE id_cuenta = v_id_cuenta_origen;
    
    UPDATE cuenta_bancaria
    SET saldo_actual = v_saldo_destino_nuevo,
        saldo_disponible = v_saldo_destino_nuevo,
        fecha_ultima_movimiento = CURRENT_TIMESTAMP
    WHERE id_cuenta = v_id_cuenta_destino;
    
    -- Actualizar transferencia
    UPDATE transferencia
    SET estado_transferencia = 'EJECUTADA',
        fecha_ejecucion = CURRENT_TIMESTAMP,
        id_usuario_aprobador = p_id_usuario_ejecutor,
        saldo_origen_despues = v_saldo_origen_nuevo,
        saldo_destino_despues = v_saldo_destino_nuevo
    WHERE id_transferencia = p_id_transferencia;
    
    -- Registrar en bitácora
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
        'TRANSFERENCIA_EJECUTADA',
        p_id_usuario_ejecutor,
        p_id_transferencia,
        'TRANSFERENCIA',
        'transferencia',
        'UPDATE',
        jsonb_build_object(
            'monto', v_monto,
            'saldo_origen_antes', v_saldo_origen_actual,
            'saldo_origen_despues', v_saldo_origen_nuevo,
            'saldo_destino_antes', v_saldo_destino_actual,
            'saldo_destino_despues', v_saldo_destino_nuevo
        ),
        'Exitoso'
    );
    
    p_mensaje := 'Transferencia ejecutada exitosamente';
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
END;
$$;

/**
 * Servicio: Aprobar Transferencia
 * Descripción: Aprueba una transferencia pendiente de aprobación
 */
CREATE OR REPLACE FUNCTION sd_aprobar_transferencia(
    p_id_transferencia INT,
    p_id_usuario_aprobador INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual VARCHAR;
    v_saldo_origen DECIMAL;
    v_monto DECIMAL;
BEGIN
    -- Obtener estado actual y monto
    SELECT estado_transferencia, monto INTO v_estado_actual, v_monto
    FROM transferencia
    WHERE id_transferencia = p_id_transferencia;
    
    -- Validar que está en espera de aprobación
    IF v_estado_actual <> 'EN_ESPERA_APROBACION' THEN
        p_mensaje := 'ERROR: La transferencia no está en estado de espera de aprobación';
        RETURN;
    END IF;
    
    -- Validar fondos suficientes
    SELECT saldo_actual INTO v_saldo_origen
    FROM cuenta_bancaria c
    JOIN transferencia t ON c.id_cuenta = t.id_cuenta_origen
    WHERE t.id_transferencia = p_id_transferencia;
    
    IF v_saldo_origen < v_monto THEN
        -- Cambiar a RECHAZADA por fondos insuficientes
        UPDATE transferencia
        SET estado_transferencia = 'RECHAZADA',
            motivo_rechazo = 'Fondos insuficientes en el momento de aprobación'
        WHERE id_transferencia = p_id_transferencia;
        
        p_mensaje := 'ERROR: Fondos insuficientes. Transferencia rechazada';
        RETURN;
    END IF;
    
    -- Ejecutar transferencia
    PERFORM sd_ejecutar_transferencia(p_id_transferencia, p_id_usuario_aprobador);
    
    -- Registrar aprobación en bitácora
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
        'TRANSFERENCIA_APROBADA',
        p_id_usuario_aprobador,
        p_id_transferencia,
        'TRANSFERENCIA',
        'transferencia',
        'UPDATE',
        jsonb_build_object('accion', 'Aprobada'),
        'Exitoso'
    );
    
    p_mensaje := 'Transferencia aprobada y ejecutada exitosamente';
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
END;
$$;

/**
 * Servicio: Rechazar Transferencia
 */
CREATE OR REPLACE FUNCTION sd_rechazar_transferencia(
    p_id_transferencia INT,
    p_id_usuario_aprobador INT,
    p_motivo TEXT DEFAULT '',
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual VARCHAR;
BEGIN
    -- Obtener estado actual
    SELECT estado_transferencia INTO v_estado_actual
    FROM transferencia
    WHERE id_transferencia = p_id_transferencia;
    
    -- Validar que está en espera de aprobación
    IF v_estado_actual <> 'EN_ESPERA_APROBACION' THEN
        p_mensaje := 'ERROR: La transferencia no puede ser rechazada en este estado';
        RETURN;
    END IF;
    
    -- Rechazar transferencia
    UPDATE transferencia
    SET estado_transferencia = 'RECHAZADA',
        motivo_rechazo = p_motivo
    WHERE id_transferencia = p_id_transferencia;
    
    -- Registrar rechazo en bitácora
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
        'TRANSFERENCIA_RECHAZADA',
        p_id_usuario_aprobador,
        p_id_transferencia,
        'TRANSFERENCIA',
        'transferencia',
        'UPDATE',
        jsonb_build_object('motivo', p_motivo),
        'Exitoso'
    );
    
    p_mensaje := 'Transferencia rechazada';
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
END;
$$;

-- ============================================================================
-- 4. SERVICIOS DE DOMINIO: GESTIÓN DE PRÉSTAMOS
-- ============================================================================

/**
 * Servicio: Solicitar Nuevo Préstamo
 * Descripción: Crea una solicitud de préstamo en estado EN_ESTUDIO
 * Reglas:
 *   - Cliente debe estar activo
 *   - Monto debe estar dentro de rango del tipo de préstamo
 *   - Plazo debe ser válido
 */
CREATE OR REPLACE FUNCTION sd_solicitar_prestamo(
    p_id_cliente INT,
    p_tipo_cliente VARCHAR,
    p_id_tipo_prestamo INT,
    p_monto_solicitado DECIMAL,
    p_plazo_meses INT,
    p_id_usuario_creador INT,
    OUT p_id_prestamo INT,
    OUT p_numero_prestamo VARCHAR,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_cliente VARCHAR;
    v_tipo_existe BOOLEAN;
    v_monto_minimo DECIMAL;
    v_monto_maximo DECIMAL;
    v_plazo_minimo INT;
    v_plazo_maximo INT;
    v_numero_prestamo VARCHAR;
    v_contador INT;
BEGIN
    -- Validar cliente según tipo
    IF p_tipo_cliente = 'PERSONA' THEN
        SELECT estado_cliente INTO v_estado_cliente 
        FROM cliente_persona_natural WHERE id_cliente = p_id_cliente;
    ELSIF p_tipo_cliente = 'EMPRESA' THEN
        SELECT estado_cliente INTO v_estado_cliente 
        FROM cliente_empresa WHERE id_cliente = p_id_cliente;
    ELSE
        p_mensaje := 'ERROR: Tipo de cliente inválido';
        RETURN;
    END IF;
    
    -- Verificar estado del cliente
    IF v_estado_cliente NOT IN ('ACTIVO') THEN
        p_mensaje := 'ERROR: Cliente no está activo';
        RETURN;
    END IF;
    
    -- Validar tipo de préstamo
    SELECT 
        TRUE,
        monto_minimo,
        monto_maximo,
        plazo_minimo_meses,
        plazo_maximo_meses
    INTO 
        v_tipo_existe,
        v_monto_minimo,
        v_monto_maximo,
        v_plazo_minimo,
        v_plazo_maximo
    FROM tipo_prestamo_catalogo
    WHERE id_tipo = p_id_tipo_prestamo AND activo = TRUE;
    
    IF NOT v_tipo_existe THEN
        p_mensaje := 'ERROR: Tipo de préstamo no válido';
        RETURN;
    END IF;
    
    -- Validar monto
    IF p_monto_solicitado < v_monto_minimo OR p_monto_solicitado > v_monto_maximo THEN
        p_mensaje := 'ERROR: Monto fuera de rango permitido (' || v_monto_minimo || ' - ' || v_monto_maximo || ')';
        RETURN;
    END IF;
    
    -- Validar plazo
    IF p_plazo_meses < v_plazo_minimo OR p_plazo_meses > v_plazo_maximo THEN
        p_mensaje := 'ERROR: Plazo fuera de rango permitido (' || v_plazo_minimo || ' - ' || v_plazo_maximo || ' meses)';
        RETURN;
    END IF;
    
    -- Generar número de préstamo
    SELECT COUNT(*) + 1 INTO v_contador FROM prestamo;
    v_numero_prestamo := 'PRE-' || TO_CHAR(NOW(), 'YYYYMMDD') || '-' || 
                         LPAD(v_contador::TEXT, 6, '0');
    
    -- Insertar solicitud
    INSERT INTO prestamo (
        numero_prestamo,
        id_cliente,
        tipo_cliente,
        id_tipo_prestamo,
        monto_solicitado,
        plazo_meses,
        estado_prestamo,
        fecha_solicitud,
        id_usuario_creador
    ) VALUES (
        v_numero_prestamo,
        p_id_cliente,
        p_tipo_cliente,
        p_id_tipo_prestamo,
        p_monto_solicitado,
        p_plazo_meses,
        'EN_ESTUDIO',
        CURRENT_TIMESTAMP,
        p_id_usuario_creador
    ) RETURNING id_prestamo INTO p_id_prestamo;
    
    -- Registrar en bitácora
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
        'PRESTAMO_SOLICITADO',
        p_id_usuario_creador,
        p_id_prestamo,
        'PRESTAMO',
        'prestamo',
        'INSERT',
        jsonb_build_object(
            'numero_prestamo', v_numero_prestamo,
            'monto_solicitado', p_monto_solicitado,
            'plazo_meses', p_plazo_meses
        ),
        'Exitoso'
    );
    
    p_numero_prestamo := v_numero_prestamo;
    p_mensaje := 'Solicitud de préstamo registrada: ' || v_numero_prestamo;
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
    p_id_prestamo := NULL;
END;
$$;

/**
 * Servicio: Aprobar Préstamo
 * Descripción: El Analista Interno aprueba una solicitud
 */
CREATE OR REPLACE FUNCTION sd_aprobar_prestamo(
    p_id_prestamo INT,
    p_monto_aprobado DECIMAL,
    p_tasa_interes DECIMAL,
    p_plazo_meses INT,
    p_id_usuario_aprobador INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual VARCHAR;
    v_interes_total DECIMAL;
BEGIN
    -- Obtener estado actual
    SELECT estado_prestamo INTO v_estado_actual
    FROM prestamo
    WHERE id_prestamo = p_id_prestamo;
    
    -- Validar que está EN_ESTUDIO
    IF v_estado_actual <> 'EN_ESTUDIO' THEN
        p_mensaje := 'ERROR: Préstamo no está en estado EN_ESTUDIO';
        RETURN;
    END IF;
    
    -- Calcular interés total
    v_interes_total := p_monto_aprobado * (p_tasa_interes / 100) * (p_plazo_meses / 12);
    
    -- Aprobar préstamo
    UPDATE prestamo
    SET estado_prestamo = 'APROBADO',
        monto_aprobado = p_monto_aprobado,
        tasa_interes = p_tasa_interes,
        plazo_meses = p_plazo_meses,
        interes_total = v_interes_total,
        fecha_aprobacion = CURRENT_TIMESTAMP,
        id_usuario_aprobador = p_id_usuario_aprobador,
        fecha_vencimiento = CURRENT_DATE + (p_plazo_meses || ' months')::INTERVAL
    WHERE id_prestamo = p_id_prestamo;
    
    -- Registrar en bitácora
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
        'PRESTAMO_APROBADO',
        p_id_usuario_aprobador,
        p_id_prestamo,
        'PRESTAMO',
        'prestamo',
        'UPDATE',
        jsonb_build_object(
            'monto_aprobado', p_monto_aprobado,
            'tasa_interes', p_tasa_interes,
            'plazo_meses', p_plazo_meses,
            'interes_total', v_interes_total
        ),
        'Exitoso'
    );
    
    p_mensaje := 'Préstamo aprobado exitosamente';
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
END;
$$;

/**
 * Servicio: Desembolsar Préstamo
 * Descripción: Ejecuta el desembolso de un préstamo aprobado
 */
CREATE OR REPLACE FUNCTION sd_desembolsar_prestamo(
    p_id_prestamo INT,
    p_id_cuenta_destino INT,
    p_id_usuario_desembolsor INT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual VARCHAR;
    v_monto_aprobado DECIMAL;
    v_saldo_actual DECIMAL;
    v_saldo_nuevo DECIMAL;
    v_cuenta_activa BOOLEAN;
BEGIN
    -- Obtener datos del préstamo
    SELECT 
        estado_prestamo,
        monto_aprobado
    INTO 
        v_estado_actual,
        v_monto_aprobado
    FROM prestamo
    WHERE id_prestamo = p_id_prestamo;
    
    -- Validar que está APROBADO
    IF v_estado_actual <> 'APROBADO' THEN
        p_mensaje := 'ERROR: Préstamo no está en estado APROBADO';
        RETURN;
    END IF;
    
    -- Validar cuenta destino
    SELECT 
        saldo_actual,
        (estado_cuenta = 'ACTIVA')
    INTO 
        v_saldo_actual,
        v_cuenta_activa
    FROM cuenta_bancaria
    WHERE id_cuenta = p_id_cuenta_destino;
    
    IF v_saldo_actual IS NULL THEN
        p_mensaje := 'ERROR: Cuenta destino no existe';
        RETURN;
    END IF;
    
    IF NOT v_cuenta_activa THEN
        p_mensaje := 'ERROR: Cuenta destino no activa';
        RETURN;
    END IF;
    
    -- Calcular nuevo saldo
    v_saldo_nuevo := v_saldo_actual + v_monto_aprobado;
    
    -- Actualizar cuenta destino
    UPDATE cuenta_bancaria
    SET saldo_actual = v_saldo_nuevo,
        saldo_disponible = v_saldo_nuevo,
        fecha_ultima_movimiento = CURRENT_TIMESTAMP
    WHERE id_cuenta = p_id_cuenta_destino;
    
    -- Actualizar préstamo
    UPDATE prestamo
    SET estado_prestamo = 'DESEMBOLSADO',
        id_cuenta_destino_desembolso = p_id_cuenta_destino,
        fecha_desembolso = CURRENT_TIMESTAMP,
        saldo_pendiente = monto_aprobado,
        fecha_proximo_pago = CURRENT_DATE + INTERVAL '1 month'
    WHERE id_prestamo = p_id_prestamo;
    
    -- Registrar en bitácora
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
        'PRESTAMO_DESEMBOLSADO',
        p_id_usuario_desembolsor,
        p_id_prestamo,
        'PRESTAMO',
        'prestamo',
        'UPDATE',
        jsonb_build_object(
            'monto_desembolsado', v_monto_aprobado,
            'saldo_antes', v_saldo_actual,
            'saldo_despues', v_saldo_nuevo,
            'cuenta_destino', p_id_cuenta_destino
        ),
        'Exitoso'
    );
    
    p_mensaje := 'Préstamo desembolsado exitosamente. Saldo actualizado en cuenta destino';
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
END;
$$;

/**
 * Servicio: Rechazar Préstamo
 */
CREATE OR REPLACE FUNCTION sd_rechazar_prestamo(
    p_id_prestamo INT,
    p_id_usuario_aprobador INT,
    p_motivo TEXT,
    OUT p_mensaje VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual VARCHAR;
BEGIN
    -- Obtener estado actual
    SELECT estado_prestamo INTO v_estado_actual
    FROM prestamo
    WHERE id_prestamo = p_id_prestamo;
    
    -- Validar que está EN_ESTUDIO
    IF v_estado_actual <> 'EN_ESTUDIO' THEN
        p_mensaje := 'ERROR: Préstamo no puede ser rechazado en este estado';
        RETURN;
    END IF;
    
    -- Rechazar préstamo
    UPDATE prestamo
    SET estado_prestamo = 'RECHAZADO',
        motivo_rechazo = p_motivo,
        id_usuario_aprobador = p_id_usuario_aprobador,
        fecha_aprobacion = CURRENT_TIMESTAMP
    WHERE id_prestamo = p_id_prestamo;
    
    -- Registrar en bitácora
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
        'PRESTAMO_RECHAZADO',
        p_id_usuario_aprobador,
        p_id_prestamo,
        'PRESTAMO',
        'prestamo',
        'UPDATE',
        jsonb_build_object('motivo', p_motivo),
        'Exitoso'
    );
    
    p_mensaje := 'Préstamo rechazado';
    
EXCEPTION WHEN OTHERS THEN
    p_mensaje := 'ERROR: ' || SQLERRM;
END;
$$;

-- ============================================================================
-- 5. SERVICIOS DE DOMINIO: MANTENIMIENTO Y AUDITORÍA
-- ============================================================================

/**
 * Servicio: Marcar Transferencias Vencidas
 * Descripción: Job que marca transferencias como vencidas después de 1 hora
 */
CREATE OR REPLACE FUNCTION sd_marcar_transferencias_vencidas()
RETURNS TABLE (
    id_transferencia INT,
    numero_transferencia VARCHAR,
    minutos_espera DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    WITH transferencias_vencidas AS (
        UPDATE transferencia
        SET estado_transferencia = 'VENCIDA'
        WHERE estado_transferencia = 'EN_ESPERA_APROBACION'
            AND (EXTRACT(EPOCH FROM (NOW() - fecha_creacion)) / 60) > 60
            AND requiere_aprobacion = TRUE
        RETURNING id_transferencia, numero_transferencia, 
                  (EXTRACT(EPOCH FROM (NOW() - fecha_creacion)) / 60) AS minutos_espera
    )
    INSERT INTO bitacora_operacion (
        tipo_operacion,
        id_usuario,
        id_producto_afectado,
        tipo_producto,
        tabla_afectada,
        accion_realizada,
        detalles_operacion,
        resultado
    )
    SELECT 
        'TRANSFERENCIA_VENCIDA',
        NULL,
        tv.id_transferencia,
        'TRANSFERENCIA',
        'transferencia',
        'UPDATE',
        jsonb_build_object(
            'numero_transferencia', tv.numero_transferencia,
            'minutos_espera', tv.minutos_espera,
            'motivo', 'Vencida por falta de aprobación en el tiempo establecido'
        ),
        'Automático'
    FROM transferencias_vencidas tv
    RETURNING tv.id_transferencia, tv.numero_transferencia, tv.minutos_espera;
END;
$$;

/**
 * Servicio: Obtener Resumen de Cliente
 * Descripción: Proporciona resumen consolidado de un cliente
 */
CREATE OR REPLACE FUNCTION sd_obtener_resumen_cliente(
    p_id_cliente INT,
    p_tipo_cliente VARCHAR
)
RETURNS TABLE (
    total_cuentas INT,
    saldo_total DECIMAL,
    cuentas_activas INT,
    total_prestamos INT,
    prestamos_desembolsados INT,
    monto_prestamos_activos DECIMAL,
    transferencias_pendientes INT,
    última_transacción TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(DISTINCT c.id_cuenta)::INT,
        SUM(c.saldo_actual)::DECIMAL,
        COUNT(DISTINCT CASE WHEN c.estado_cuenta = 'ACTIVA' THEN c.id_cuenta END)::INT,
        COUNT(DISTINCT p.id_prestamo)::INT,
        COUNT(DISTINCT CASE WHEN p.estado_prestamo = 'DESEMBOLSADO' THEN p.id_prestamo END)::INT,
        SUM(CASE WHEN p.estado_prestamo = 'DESEMBOLSADO' THEN p.saldo_pendiente ELSE 0 END)::DECIMAL,
        COUNT(DISTINCT CASE WHEN t.estado_transferencia = 'EN_ESPERA_APROBACION' THEN t.id_transferencia END)::INT,
        MAX(GREATEST(c.fecha_ultima_movimiento, t.fecha_creacion))
    FROM cliente_persona_natural cli
    LEFT JOIN cuenta_bancaria c ON c.id_cliente = cli.id_cliente AND c.tipo_cliente = p_tipo_cliente
    LEFT JOIN prestamo p ON p.id_cliente = cli.id_cliente AND p.tipo_cliente = p_tipo_cliente
    LEFT JOIN transferencia t ON t.id_cuenta_origen IN (SELECT id_cuenta FROM cuenta_bancaria WHERE id_cliente = p_id_cliente)
    WHERE cli.id_cliente = p_id_cliente;
END;
$$;

-- ============================================================================
-- FIN DEL SCRIPT DE SERVICIOS DE DOMINIO
-- ============================================================================
