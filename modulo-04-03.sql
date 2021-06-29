-- 1. Actualizar información

-- UPDATE tabla 
-- SET campo1 = valor1, campo2 = valor2, ..., campoN = valorN 
-- WHERE campoM = valorM;
UPDATE persons
SET first_name = 'Jenny', last_name = 'González'
WHERE id = 'b73e2e3c-3e3c-4474-afbe-6e476fc3a4ea';

UPDATE persons
SET available = false;


-- 2. Borrar información

-- DELETE FROM tabla WHERE campoM = valorM;
DELETE FROM persons WHERE id IS NULL;
DELETE FROM persons WHERE id = 'ebead154-2bcb-4808-b4cd-833ea39b58cc';

-- TRUNCATE TABLE tabla;
TRUNCATE TABLE persons;
