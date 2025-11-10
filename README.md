# basedatos2
## Semana 11

Las funciones agregadas (aggregate functions) son operaciones que realizan cálculos sobre un conjunto de filas y devuelven un único resultado.

En otras palabras, toman muchos valores y devuelven uno solo. Por ejemplo: sumar ventas (SUM()), contar clientes (COUNT()), o calcular el promedio de precios (AVG()).

## Semana 12
Aprendimos del uso de subconsultas IN y EXISTS con las funciones de Fecha, Cadena y Conversión

## Semana 13
Aprendimos del uso de funciones Transact-SQL.

En Transact-SQL (T-SQL) —el lenguaje de los SQL Server— una función es un bloque de código almacenado en la base de datos que realiza una operación específica y devuelve un valor o conjunto de valores.

Pensemos en una función como un “mini-programa reutilizable” que ejecuta lógica SQL (como cálculos, conversiones o consultas) y devuelve un resultado sin necesidad de repetir el mismo código en cada consulta.

Tipos de funciones en T-SQL

Existen dos grandes tipos:

1. Funciones del sistema (ya integradas)

Son las que vienen incluidas en SQL Server y están listas para usarse.
Ejemplos:

De texto: UPPER(), LOWER(), LEN(), CONCAT()

De fecha: GETDATE(), DATEPART(), YEAR(), DATENAME()

De conversión: CAST(), CONVERT()

De agregación: SUM(), AVG(), COUNT()

Estas funciones no se crean, solo se utilizan directamente en consultas.

2. Funciones definidas por el usuario (UDF — User Defined Functions)

Son funciones creadas por el propio usuario o desarrollador para personalizar cálculos o consultas según las necesidades del sistema.
