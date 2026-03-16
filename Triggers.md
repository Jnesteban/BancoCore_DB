


# Triggers Implementados

Se implementaron **triggers en PostgreSQL** para controlar automáticamente las transferencias y evitar inconsistencias en los saldos de las cuentas.

Los triggers permiten ejecutar acciones automáticas cuando ocurren ciertos eventos en la base de datos, como inserciones o actualizaciones.

En este proyecto se implementaron dos escenarios principales.

---

# Caso 1: Carga masiva de transferencias, las transferencias se realizan uno a uno hasta que no hayan fondos, alli deben detenerse.

En este caso se simulamos la ejecución de múltiples transferencias desde una misma cuenta.

## Función del Trigger

```sql
CREATE OR REPLACE FUNCTION validar_transferencia()
RETURNS TRIGGER AS $$
DECLARE
    saldo_origen NUMERIC;
BEGIN

    SELECT saldo_actual
    INTO saldo_origen
    FROM cuenta_bancaria
    WHERE id_cuenta = NEW.id_cuenta_origen;

    IF saldo_origen < NEW.monto THEN
        RAISE EXCEPTION 'Fondos insuficientes para realizar la transferencia';
    END IF;

    UPDATE cuenta_bancaria
    SET saldo_actual = saldo_actual - NEW.monto
    WHERE id_cuenta = NEW.id_cuenta_origen;

    UPDATE cuenta_bancaria
    SET saldo_actual = saldo_actual + NEW.monto
    WHERE id_cuenta = NEW.id_cuenta_destino;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

## Creación del Trigger

```sql
CREATE TRIGGER trigger_validar_transferencia
BEFORE INSERT ON transferencia
FOR EACH ROW
EXECUTE FUNCTION validar_transferencia();
```

## Consulta de Prueba

Se intenta realizar una transferencia mayor al saldo disponible.

```sql
INSERT INTO transferencia
(id_cuenta_origen, id_cuenta_destino, monto, fecha_creacion, id_usuario_creador, id_estado)
VALUES (1, 2, 5000000, NOW(), 1, 1);
```

Resultado esperado:

El sistema genera un error indicando que **no existen fondos suficientes**, deteniendo la operación.

---

# Caso 2: Varias operaciones pendientes de aprobacion, con las aplicaciones masivas en los escenarios 1 a 1 donde la persona esta aprobando las transferencias, cuando una transferencia se realice y deje sin fondo a las demas, debe detenerse

En este escenario se simulan varias transferencias que se encuentran en estado **pendiente**.

Cuando el usuario intenta aprobar las transferencias una por una, el sistema debe verificar nuevamente el saldo de la cuenta. Si una aprobación deja sin fondos suficientes para las siguientes operaciones, estas deben detenerse automáticamente.


## Función del Trigger

```sql
CREATE OR REPLACE FUNCTION aprobar_transferencia()
RETURNS TRIGGER AS $$
DECLARE
    saldo_origen NUMERIC;
BEGIN

    IF NEW.id_estado = 12 THEN

        SELECT saldo_actual
        INTO saldo_origen
        FROM cuenta_bancaria
        WHERE id_cuenta = NEW.id_cuenta_origen;

        IF saldo_origen < NEW.monto THEN
            RAISE EXCEPTION 'No hay fondos para aprobar esta transferencia';
        END IF;

        UPDATE cuenta_bancaria
        SET saldo_actual = saldo_actual - NEW.monto
        WHERE id_cuenta = NEW.id_cuenta_origen;

        UPDATE cuenta_bancaria
        SET saldo_actual = saldo_actual + NEW.monto
        WHERE id_cuenta = NEW.id_cuenta_destino;

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

## Creación del Trigger

```sql
CREATE TRIGGER trigger_aprobar_transferencia
BEFORE UPDATE ON transferencia
FOR EACH ROW
EXECUTE FUNCTION aprobar_transferencia();
```

---

# Consultas Utilizadas para el Caso 2

## Crear transferencias pendientes

```sql
INSERT INTO transferencia
(id_cuenta_origen,id_cuenta_destino,monto,fecha_creacion,id_usuario_creador,id_estado)
VALUES (1,2,40000,NOW(),1,11);
```

```sql
INSERT INTO transferencia
(id_cuenta_origen,id_cuenta_destino,monto,fecha_creacion,id_usuario_creador,id_estado)
VALUES (1,3,40000,NOW(),1,11);
```

```sql
INSERT INTO transferencia
(id_cuenta_origen,id_centa_destino,monto,fecha_creacion,id_usuario_creador,id_estado)
VALUES (1,4,40000,NOW(),1,11);
```

## Aprobar transferencias

```sql
UPDATE transferencia
SET id_estado = 12
WHERE id_transferencia = 24;
```

```sql
UPDATE transferencia
SET id_estado = 12
WHERE id_transferencia = 25;
```

```sql
UPDATE transferencia
SET id_estado = 12
WHERE id_transferencia = 26;
```

Resultado esperado:

Cuando el saldo no sea suficiente para aprobar la última transferencia, el sistema mostrará un error indicando que **no hay fondos disponibles**.

---

# JUAN ESTEBAN CORREA CANO - BASE DE DATOS II

Md apoyado con IA para mejor redacción

---
