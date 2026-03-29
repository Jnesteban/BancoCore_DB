# Recuperación de Saldos Bancarios usando Cursores

## Descripción

En este proyecto se simula un incidente en un sistema bancario donde los triggers dejaron de ejecutarse. Como consecuencia, las transferencias se registraron correctamente en la base de datos, pero no se actualizaron los saldos de las cuentas ni se registraron en la bitácora.

Para solucionar este problema, se desarrolló un procedimiento almacenado utilizando cursores, el cual permite recorrer las transferencias realizadas durante la falla y reconstruir los saldos de las cuentas afectadas.

> Este README fue elaborado con apoyo de inteligencia artificial para mejorar la claridad de la explicación.

---

## Objetivo

- Simular una falla en los triggers  
- Evidenciar la inconsistencia en los datos  
- Aplicar medidas de contención  
- Recuperar los saldos mediante un procedimiento con cursor  
- Validar la correcta restauración de la información  

---

## Explicación general del proceso

Primero se simula el fallo desactivando los triggers del sistema. Luego se realizan varias transferencias que quedan registradas, pero no afectan los saldos. Esto genera una inconsistencia en la base de datos.

Después, como medida de contención, se bloquean nuevas transacciones para evitar que el problema continúe.

Finalmente, se implementa un procedimiento almacenado que recorre cada transferencia mediante un cursor y aplica manualmente los débitos y créditos correspondientes, logrando reconstruir los saldos correctamente.

---

## 1. Simulación del incidente

### Asignar saldos iniciales

```sql
UPDATE cuenta_bancaria
SET saldo_actual = 399999
WHERE id_cuenta IN (1,2,3);
```
## 1.1 Verificar saldos

```sql
SELECT id_cuenta, saldo_actual
FROM cuenta_bancaria
WHERE id_cuenta IN (1,2,3);
```
## 1.2 Desactivar triggers

```sql
ALTER TABLE transferencia DISABLE TRIGGER ALL;
```

## 1.3 Limpiar transferencias

```sql
DELETE FROM transferencia;

```
## 1.4 Insertar transferencias (sin afectar saldos)

```sql
INSERT INTO transferencia
(id_cuenta_origen,id_cuenta_destino,monto,fecha_creacion,id_usuario_creador,id_estado)
VALUES (1,2,50000,NOW(),1,12);

INSERT INTO transferencia
(id_cuenta_origen,id_cuenta_destino,monto,fecha_creacion,id_usuario_creador,id_estado)
VALUES (2,3,30000,NOW(),1,12);

INSERT INTO transferencia
(id_cuenta_origen,id_cuenta_destino,monto,fecha_creacion,id_usuario_creador,id_estado)
VALUES (3,1,20000,NOW(),1,12);
```

## 1.5 Verificar inconsistencia

```sql
SELECT id_cuenta, saldo_actual
FROM cuenta_bancaria
WHERE id_cuenta IN (1,2,3);
```
En este punto, los saldos permanecen iguales (399999), lo que confirma que los triggers no están funcionando.


---


## 2. Contención del incidente

Se bloquean nuevas transacciones para evitar más inconsistencias.

```sql
REVOKE INSERT ON transferencia FROM PUBLIC;
```

---

## 3. Solución: Procedimiento almacenado con cursor

Este procedimiento recorre todas las transferencias aprobadas y aplica manualmente los cambios en los saldos.

```sql
CREATE OR REPLACE PROCEDURE reconstruir_saldos()
LANGUAGE plpgsql
AS $$
DECLARE
    reg RECORD;

    cursor_transferencias CURSOR FOR
    SELECT id_transferencia,
           id_cuenta_origen,
           id_cuenta_destino,
           monto
    FROM transferencia
    WHERE id_estado = 12;

BEGIN

    OPEN cursor_transferencias;

    LOOP
        FETCH cursor_transferencias INTO reg;
        EXIT WHEN NOT FOUND;

        UPDATE cuenta_bancaria
        SET saldo_actual = saldo_actual - reg.monto
        WHERE id_cuenta = reg.id_cuenta_origen;

        UPDATE cuenta_bancaria
        SET saldo_actual = saldo_actual + reg.monto
        WHERE id_cuenta = reg.id_cuenta_destino;

    END LOOP;

    CLOSE cursor_transferencias;

END;
$$;
```
---

## 4. Ejecución del procedimiento

```sql
CALL reconstruir_saldos();
```

---

## 5. Validación de resultados

```sql
SELECT id_cuenta, saldo_actual
FROM cuenta_bancaria
WHERE id_cuenta IN (1,2,3);
```

Resultado esperado

Cuenta: 
1 = 369999  |  2	= 419999  | 3 = 409999

Esto confirma que los saldos fueron reconstruidos correctamente.

---

## Conclusión

Se logró simular un fallo real en un sistema bancario, donde los triggers dejaron de ejecutarse. A través de un procedimiento almacenado con cursor, se reconstruyeron correctamente los saldos de las cuentas afectadas.

Este ejercicio demuestra la importancia de la integridad de los datos y cómo un DBA puede intervenir para recuperar la información en escenarios críticos.
