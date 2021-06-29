-- SELECT
-- Puede recibir constantes, expresiones, funciones, campos de tablas.

-- Constantes
SELECT 'Hola mundo';
SELECT 8;

-- Expresiones
SELECT 2*2+2/2;

-- Cast
SELECT 8::numeric/23::numeric;

-- Cast no válido
SELECT 'Hola'::int;

-- Cast válido de String a Date
SELECT '2021-06-13'::date;


-- Funciones
SELECT now();
SELECT upper('Hola Mundo');
SELECT lower('Hola Mundo');

-- Campos de Tablas
SELECT * FROM students;
SELECT id, first_name, is_active
FROM students;

-- Uniendo lo anterior
SELECT id, upper(first_name), (2+4)::numeric/3::numeric, 'Estudiante'
FROM students;

-- Alias
SELECT id, upper(first_name) AS first_name,
       (2+4)::numeric/3::numeric AS expresion,
       'Estudiante' as tipo_persona
FROM students;

-- Le llamamos proyección a todos los campos que queremos que devuelva una consulta SQL
