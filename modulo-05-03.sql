-- FILTROS
-- WHERE campo operador valor, ejemplo: WHERE first_name = 'Alexys'
SELECT * FROM persons WHERE first_name = 'Alexys';

-- Funciones
SELECT * FROM persons WHERE first_name = 'ALEXYS';
SELECT * FROM persons WHERE upper(first_name) = 'ALEXYS';

-- Operadores de comparación
-- =
-- >
-- <
-- >=
-- <=
-- <>
SELECT * FROM persons WHERE upper(first_name) > 'ALEXYS';
SELECT * FROM persons WHERE upper(first_name) < 'ALEXYS';
SELECT * FROM persons WHERE upper(first_name) >= 'ALEXYS';
SELECT * FROM persons WHERE upper(first_name) <= 'ALEXYS';
SELECT * FROM persons WHERE upper(first_name) <> 'ALEXYS';

-- AND & OR
SELECT * FROM persons WHERE upper(first_name) = 'ALEXYS' AND last_name <> '';
SELECT * FROM persons WHERE upper(first_name) = 'ALEXYS' OR first_name = 'Daniel';

-- LIKE normal
SELECT * FROM persons WHERE upper(first_name) LIKE 'ALEXYS';

-- LIKE un sólo caracter `_`
SELECT * FROM persons WHERE upper(first_name) LIKE 'ALEX_S';

-- LIKE varios caracteres `%`
SELECT * FROM persons WHERE upper(first_name) LIKE 'ALE%';

-- ILIKE
SELECT * FROM persons WHERE first_name ILIKE 'aLe%';

-- BETWEEN
SELECT * FROM persons WHERE birthday BETWEEN '1980-01-01' AND '2020-12-31';

-- IN VALORES
SELECT *
FROM jobs
WHERE persons_id IN ('7eb6ce61-a64c-466d-90d2-befcd99635c9','17188cd6-9212-4f96-9677-91b581ba4dec', '17188cd6-9212-4f96-9677-91b581ba4dab');

-- IN SELECT
SELECT *
FROM jobs
WHERE persons_id IN (SELECT id FROM persons);

SELECT * FROM persons
WHERE id IN (SELECT persons_id FROM jobs);

-- IS NULL
SELECT * FROM persons WHERE updated_at IS NULL;

-- NOT
SELECT * FROM persons WHERE updated_at IS NOT NULL;

SELECT * FROM persons
WHERE id NOT IN (SELECT persons_id FROM jobs);
