# BancoCore_DB

### Autor: Juan Esteban Correa Cano . Base De Datos II 2026-1

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

| Módulo              |
|---------------------|
| Clientes            |
| Usuarios            |
| Cuentas bancarias   |
| Préstamos           |
| Transferencias      |
| Bitácora            |


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

| Tabla              | Descripción                         |
|--------------------|-------------------------------------|
| rol                | Catálogo de roles                   |
| cliente_person     | Clientes persona natural            |
| cliente_empresa    | Clientes empresa                    |
| usuario_sistema    | Usuarios del sistema                |
| cuenta_bancaria    | Cuentas asociadas a clientes        |
| prestamo           | Préstamos solicitados               |
| transferencia      | Transferencias entre cuentas        |
| bitacora_op        | Auditoría del sistema               |

---


## 4. Relaciones del Sistema

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

## 5. Generación de Datos

Para simular un entorno realista se generaron aproximadamente **1000 registros** utilizando:

- `generate_series()`
- `random()`
- `INSERT INTO ... SELECT`

Esto permitió realizar pruebas con un volumen de datos significativo.

---

## 6. Consultas Implementadas

### 6.1 Subconsultas

**Cuentas que han realizado transferencias**

```sql
SELECT numero_cuenta
FROM cuenta_bancaria
WHERE id_cuenta IN (
    SELECT id_cuenta_origen
    FROM transferencia
);
```

### 6.2 Filtro de Igualación
**Buscar cliente por número de identificación**

```sql
SELECT *
FROM cliente_person
WHERE numero_identificacion = '123456789';
);

```

### 6.3 JOIN
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


### 6.4 LEFT JOIN
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
### 6.5 RIGHT JOIN

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


## Script de Base de Datos

El archivo completo de creación de la base de datos se encuentra en:

📂 gestion_banco.sql



