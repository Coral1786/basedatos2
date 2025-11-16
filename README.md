# basedatos2
## Semana 11

Las funciones agregadas (aggregate functions) son operaciones que realizan cálculos sobre un conjunto de filas y devuelven un único resultado.

En otras palabras, toman muchos valores y devuelven uno solo. Por ejemplo: sumar ventas (SUM()), contar clientes (COUNT()), o calcular el promedio de precios (AVG()).

## Semana 12
Aprendimos del uso de subconsultas IN y EXISTS con las funciones de Fecha, Cadena y Conversión

- Las funciones de fecha permiten filtrar o calcular periodos de tiempo dinámicos.
- Las funciones de cadena permiten formatear, unir o filtrar texto
- Las funciones de conversión transforman tipos de datos. Por ejemplo, convertir texto a número, fecha a texto, o decimal a entero.

## Semana 13
Aprendimos del uso de funciones Transact-SQL.

En Transact-SQL (T-SQL) —el lenguaje de los SQL Server— una función es un bloque de código almacenado en la base de datos que realiza una operación específica y devuelve un valor o conjunto de valores.

Pensemos en una función como un “mini-programa reutilizable” que ejecuta lógica SQL (como cálculos, conversiones o consultas) y devuelve un resultado sin necesidad de repetir el mismo código en cada consulta.

### Tipos de funciones en T-SQL
Existen dos grandes tipos:
1. Funciones del sistema (ya integradas)
Son las que vienen incluidas en SQL Server y están listas para usarse.
Ejemplos:
- De texto: UPPER(), LOWER(), LEN(), CONCAT()
- De fecha: GETDATE(), DATEPART(), YEAR(), DATENAME()
- De conversión: CAST(), CONVERT()
- De agregación: SUM(), AVG(), COUNT()

  Estas funciones no se crean, solo se utilizan directamente en consultas.

2. Funciones definidas por el usuario (UDF — User Defined Functions)
Son funciones creadas por el propio usuario o desarrollador para personalizar cálculos o consultas según las necesidades del sistema.

## Semana 14
Aprendimos del manejo de transacciones

El manejo de transacciones en SQL es uno de los pilares fundamentales para garantizar la integridad, consistencia y seguridad de los datos en una base de datos.

Una transacción es una unidad lógica de trabajo que agrupa una o varias instrucciones SQL (como INSERT, UPDATE, DELETE) y se ejecuta como si fuera una sola operación indivisible.

### ¿Cómo funciona una Transacción?

Una transacción sigue un ciclo básico:
- BEGIN TRANSACTION — Inicia la transacción.
- (Ejecutas tus operaciones SQL) — Insertas, actualizas o eliminas datos.
- COMMIT TRANSACTION — Confirma los cambios permanentemente.
- ROLLBACK TRANSACTION — Revierte todos los cambios si ocurre un error.

### Las 4 Propiedades de una Transacción: ACID



- A – Atomicidad	(Todo o nada):	La transacción se ejecuta completa o no se ejecuta en absoluto.
- C – Consistencia	(Estado válido): La BD pasa de un estado válido a otro, sin romper reglas de integridad.
- I – Aislamiento	(Independencia): Las transacciones no interfieren entre sí (se ejecutan “aisladas”).
- D – Durabilidad	(Persistencia):	Los cambios confirmados (COMMIT) permanecen aunque falle el sistema.
