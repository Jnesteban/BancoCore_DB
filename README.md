# BancoCore_DB

# Sistema de Gestión de Información Bancaria (PostgreSQL)

## Bases de Datos II  
### Proyecto Académico

---

## Nota

> Este README fue redactado con apoyo de Inteligencia Artificial para mejorar la claridad, organización y presentación académica del proyecto.

---

## 1. Descripción del Proyecto

Diseño e implementación de una **base de datos relacional en PostgreSQL** para modelar el sistema de gestión de información de una entidad bancaria.

El sistema cubre los siguientes módulos:

| Módulo              | Descripción |
|---------------------|------------|
| Clientes            | Persona natural y empresa |
| Usuarios            | Gestión de acceso por roles |
| Cuentas bancarias   | Administración de cuentas activas |
| Préstamos           | Solicitud, aprobación y desembolso |
| Transferencias      | Movimientos entre cuentas |
| Bitácora            | Registro de auditoría de operaciones |

### Criterios de diseño

- Normalización (3FN)
- Integridad referencial
- Reglas de negocio bancarias
- Seguridad por rol

---

## 2. Entorno de Desarrollo

### Herramientas utilizadas

- PostgreSQL  
- pgAdmin 4  
- SQL (DDL y DML)

### Creación de la base de datos

En **pgAdmin 4**:

1. Ir a `Databases`
2. Clic derecho → `Create` → `Database`
3. Configurar:
   - **Nombre:** `gestion_banco`
   - **Owner:** `postgres`
4. Guardar.

Las tablas fueron creadas manualmente mediante scripts SQL en el **Query Tool**.

---

## 3. Modelo de Datos

### Tablas del Sistema

| Tabla              | Descripción                         | Clave primaria |
|--------------------|-------------------------------------|----------------|
| rol                | Catálogo de roles                   | id_rol |
| cliente_person     | Clientes persona natural            | id_persona |
| cliente_empresa    | Clientes empresa                    | id_empresa |
| usuario_sistema    | Usuarios del sistema                | id_usuario |
| cuenta_bancaria    | Cuentas asociadas a clientes        | id_cuenta |
| prestamo           | Préstamos solicitados               | id_prestamo |
| transferencia      | Transferencias entre cuentas        | id_transferencia |
| bitacora_op        | Auditoría del sistema               | id_bitacora |

---

## 4. Reglas de Negocio Implementadas

- Número de identificación único por cliente.
- Número de cuenta único.
- No se permiten operaciones en cuentas bloqueadas o canceladas.
- Validación de saldo suficiente para transferencias.
- Flujo controlado de estados en préstamos:
  - `En estudio → Aprobado / Rechazado → Desembolsado`
- Registro obligatorio de operaciones en la bitácora.
- Restricciones de acceso según rol del usuario.

---

## 5. Relaciones del Sistema

### Relaciones principales (1:N)

- Cliente → Cuenta bancaria
- Cliente → Préstamo
- Cuenta bancaria → Transferencia
- Usuario → Bitácora

### Restricciones utilizadas

- `PRIMARY KEY`
- `FOREIGN KEY`
- `UNIQUE`
- `NOT NULL`

Estas garantizan la integridad referencial del sistema.

---

## 6. Generación de Datos

Para simular un entorno realista se generaron aproximadamente **1000 registros** utilizando:

- `generate_series()`
- `random()`
- `INSERT INTO ... SELECT`

Esto permitió realizar pruebas con un volumen de datos significativo.

---

## 7. Consultas Implementadas

### 7.1 Subconsultas

**Cuentas que han realizado transferencias**

```sql
SELECT numero_cuenta
FROM cuenta_bancaria
WHERE id_cuenta IN (
    SELECT id_cuenta_origen
    FROM transferencia
);
```

### 7.2 Filtro de Igualación
**Buscar cliente por número de identificación**

```sql
SELECT *
FROM cliente_person
WHERE numero_identificacion = '123456789';
);

```

### 7.3 JOIN
**Clientes con sus cuentas**

```sql
SELECT c.nombre_completo, 
       c.numero_identificacion, 
       cb.numero_cuenta, 
       cb.saldo_actual
FROM cliente_person c
JOIN cuenta_bancaria cb
ON c.id_persona = cb.id_persona;
);

```


### 7.4 LEFT JOIN
**Mostrar todos los clientes aunque no tengan cuenta**


```sql
SELECT c.nombre_completo, 
       c.numero_identificacion, 
       cb.numero_cuenta
FROM cliente_person c
LEFT JOIN cuenta_bancaria cb
ON c.id_persona = cb.id_persona;
);

```
### 7.5 RIGHT JOIN

**Mostrar todas las cuentas aunque no tengan cliente asociado**


```sql
SELECT c.nombre_completo, 
       cb.numero_cuenta, 
       cb.saldo_actual
FROM cliente_person c
RIGHT JOIN cuenta_bancaria cb
ON c.id_persona = cb.id_persona;
);

```




### Autor: Juan Esteban Correa Cano . Base De Datos II

