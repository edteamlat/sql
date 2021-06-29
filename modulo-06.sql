-- AGRUPACIONES
-- Creamos unas tablas para el ejercicio de agrupaciones

-- Productos
CREATE TABLE products (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    product_name VARCHAR(30) NOT NULL,
    price NUMERIC (10,2) NOT NULL,
    CONSTRAINT products_id_pk PRIMARY KEY (id),
    CONSTRAINT products_product_name_uk UNIQUE (product_name)
);

-- Encabezado de facturación
CREATE TABLE invoices (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    invoice_date DATE DEFAULT NOW() NOT NULL,
    person_id UUID NOT NULL,
    CONSTRAINT invoices_id_pk PRIMARY KEY (id),
    CONSTRAINT invoices_person_id_fk FOREIGN KEY (person_id)
        REFERENCES persons (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

-- Detalle de facturación
CREATE TABLE invoice_items (
    id UUID DEFAULT gen_random_uuid() NOT NULL ,
    invoice_id UUID NOT NULL,
    product_id UUID NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    quantity INT DEFAULT 1 NOT NULL,
    CONSTRAINT invoice_items_id_pk PRIMARY KEY (id),
    CONSTRAINT invoice_items_invoice_id_fk FOREIGN KEY (invoice_id)
        REFERENCES invoices (id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT invoice_items_product_id_fk FOREIGN KEY (product_id)
        REFERENCES products (id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

-- INSERTAMOS DATOS EN PRODUCTOS
INSERT INTO products
VALUES (DEFAULT, 'ARROZ', 12.31),
       (DEFAULT, 'PAPA', 1.44),
       (DEFAULT, 'CARNE', 20);

-- INSERTAMOS DATOS EN FACTURACIÓN
INSERT INTO invoices (person_id) VALUES ('7eb6ce61-a64c-466d-90d2-befcd99635c9') RETURNING id, invoice_date;
INSERT INTO invoice_items
VALUES (DEFAULT, 'f05e038a-43ed-401e-a139-f5203defc052', 'cb523fef-0a00-4792-8991-5561ab49e386', 14.11, 2),
       (DEFAULT, 'f05e038a-43ed-401e-a139-f5203defc052', 'e5e1617f-31da-405f-a3b1-c151f6ac6cc1', 1.44, 1),
       (DEFAULT, 'f05e038a-43ed-401e-a139-f5203defc052', 'a605bce3-4b4f-4c21-800c-1fbd1d824924', 21, 3);

INSERT INTO invoices (person_id) VALUES ('17188cd6-9212-4f96-9677-91b581ba4dec') RETURNING id;
INSERT INTO invoice_items
VALUES (DEFAULT, '251af7c9-5b2d-42a6-96ec-60a5dc148750', 'e5e1617f-31da-405f-a3b1-c151f6ac6cc1', 1.44, 3),
       (DEFAULT, '251af7c9-5b2d-42a6-96ec-60a5dc148750', 'a605bce3-4b4f-4c21-800c-1fbd1d824924', 21, 12);

INSERT INTO invoices (person_id) VALUES ('7eb6ce61-a64c-466d-90d2-befcd99635c9') RETURNING id;
INSERT INTO invoice_items
VALUES (DEFAULT, '5aafb598-8eb7-48e1-936b-85178f804091', 'cb523fef-0a00-4792-8991-5561ab49e386', 14.11, 1),
       (DEFAULT, '5aafb598-8eb7-48e1-936b-85178f804091', 'e5e1617f-31da-405f-a3b1-c151f6ac6cc1', 1.44, 5);

INSERT INTO invoices (person_id) VALUES ('849e8926-21bf-4b61-a1dd-ed0a636320d2') RETURNING id;
INSERT INTO invoice_items
VALUES (DEFAULT, 'b06e49d6-1757-4d28-bdca-4fe172fa6f5a', 'e5e1617f-31da-405f-a3b1-c151f6ac6cc1', 2, 5);

INSERT INTO invoices (person_id) VALUES ('b6b5cf9c-44e8-4c2c-8b78-f025e7aca9fe') RETURNING id;
INSERT INTO invoice_items
VALUES (DEFAULT, '88abe700-fb80-4264-bef0-5f68286cf214', 'cb523fef-0a00-4792-8991-5561ab49e386', 14.11, 1),
       (DEFAULT, '88abe700-fb80-4264-bef0-5f68286cf214', 'e5e1617f-31da-405f-a3b1-c151f6ac6cc1', 1.44, 12);

-- CONSULTA DE AGRUPACIONES

-- 1 DISTINCT consulta la información distinguiendo la proyección
SELECT DISTINCT last_name FROM persons;

-- 2 GROUP BY
-- Debe contener los campos proyectados a excepción de las funciones
SELECT last_name
FROM persons
GROUP BY last_name;

SELECT first_name, last_name
FROM persons
GROUP BY first_name, last_name;

-- Consultando información con funciones
SELECT * FROM persons;

SELECT first_name, COUNT(*) AS cantidad
FROM persons
GROUP BY first_name;

SELECT COUNT(*)
FROM persons;

SELECT first_name, COUNT(1) AS cantidad
FROM persons
GROUP BY first_name;

SELECT first_name, COUNT(last_name) AS cantidad
FROM persons
GROUP BY first_name;

SELECT first_name, COUNT(updated_at) AS cantidad
FROM persons
GROUP BY first_name;

-- Preguntas que resolvemos con SQL:

-- Cuánto es el total de venta de la primer factura?
SELECT * FROM invoices;

SELECT * FROM invoice_items WHERE invoice_id = 'f05e038a-43ed-401e-a139-f5203defc052';

SELECT SUM(price * quantity)
FROM invoice_items
WHERE invoice_id = 'f05e038a-43ed-401e-a139-f5203defc052';

-- Respuesta: 92.66

-- Cuánto es el total de venta de todas las facturas, agrupado por factura?
SELECT invoice_id, SUM(price * quantity)
FROM invoice_items
GROUP BY invoice_id
ORDER BY invoice_id;

-- Cuánto ha comprado en total el cliente Alexys Lozada?
SELECT * FROM persons;
-- b6b5cf9c-44e8-4c2c-8b78-f025e7aca9fe
SELECT SUM(price * quantity)
FROM invoice_items
WHERE invoice_id IN (SELECT id FROM invoices WHERE person_id = 'b6b5cf9c-44e8-4c2c-8b78-f025e7aca9fe');

-- Respuesta: 31.39

-- Cuánto ha comprado en total el cliente Daniel?
--  bba61699-aef6-4747-9b29-a4637ef3a85f
SELECT SUM(price * quantity)
FROM invoice_items
WHERE invoice_id IN (SELECT id FROM invoices WHERE person_id = 'bba61699-aef6-4747-9b29-a4637ef3a85f');

-- Respuesta: Nada

-- Leidy 5a04d0e6-c066-451b-a16e-7edfd6fb9039
SELECT SUM(price * quantity)
FROM invoice_items
WHERE invoice_id IN (SELECT id FROM invoices WHERE person_id = '5a04d0e6-c066-451b-a16e-7edfd6fb9039');

-- Respuesta nada

-- Jenny 17188cd6-9212-4f96-9677-91b581ba4dec
SELECT SUM(price * quantity)
FROM invoice_items
WHERE invoice_id IN (SELECT id FROM invoices WHERE person_id = '17188cd6-9212-4f96-9677-91b581ba4dec');

-- Cuál producto se ha vendido más/menos en cantidad?
-- Cuál producto se ha vendido más/menos en valor?
SELECT *
FROM invoice_items;

SELECT product_id, COUNT(*) AS registros, SUM(price * quantity) valor_venta, SUM(quantity) cantidad
FROM invoice_items
GROUP BY product_id
ORDER BY 4;

-- HAVING
-- Es como la clausula WHERE pero por grupos de registros:

-- Cuál cliente ha hecho más compras? Teniendo en cuenta que contamos una factura como una compra.
SELECT * FROM invoices;

SELECT person_id, COUNT(*) as cantidad
FROM invoices
GROUP BY person_id
ORDER BY 2 DESC;

-- Cuales personas han comprado 2 veces o más?
SELECT person_id, COUNT(*) as cantidad
FROM invoices
GROUP BY person_id
HAVING COUNT(*) >= 2;

SELECT person_id, COUNT(*) as cantidad
FROM invoices
GROUP BY person_id
HAVING COUNT(*) = 1;

-- LIMIT Y OFFSET
-- Permite limitar la cantidad de registros devueltos. Sirve para paginar las consultas.
SELECT * FROM invoice_items ORDER BY id;

-- Mostrar los primeros 3 productos
SELECT * FROM invoice_items ORDER BY id LIMIT 3;

-- 6fa 896 ad5
SELECT * FROM invoice_items ORDER BY id LIMIT 3 OFFSET 0; -- PÁGINA 1
SELECT * FROM invoice_items ORDER BY id LIMIT 3 OFFSET 3; -- PÁGINA 2
SELECT * FROM invoice_items ORDER BY id LIMIT 3 OFFSET 6; -- PÁGINA 3
SELECT * FROM invoice_items ORDER BY id LIMIT 3 OFFSET 9; -- PÁGINA 4

-- REGISTROS A LIMITAR, PÁGINA ?

-- Paginación
-- offset := página * límite - límite
-- offset := 1 * 5 - 5 = 0
-- offset := 2 * 5 - 5 = 5
-- offset := 3 * 5 - 5 = 10
