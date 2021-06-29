-- Insertar datos

-- 1. Insert into tabla (campo1, ..., campoN) VALUES (valor1, ..., valorN);
INSERT INTO persons (id, first_name, last_name, birthday, available)
VALUES (gen_random_uuid(), 'Alexys', 'Lozada', '1980-01-02', true);

INSERT INTO persons (first_name, birthday, last_name, available, id)
VALUES ( 'Alexys', '1980-01-02', 'Lozada', true, gen_random_uuid());

-- 2. Insert into tabla VALUES (valor1, valor2, ..., valorN);
INSERT INTO persons 
VALUES (gen_random_uuid(), 'Alexys', 'Lozada', '1980-01-02', true);


-- 3. Insert into tabla VALUES (default, valorN, valorM, ..., valorZ);
INSERT INTO persons 
VALUES (DEFAULT, 'Alexys', DEFAULT, DEFAULT, true);

-- 3.1 Valores por defecto.
CREATE TABLE students (
    id UUID DEFAULT gen_random_uuid(),
    first_name VARCHAR(50),
    is_active BOOL DEFAULT true,
    created_at TIMESTAMP DEFAULT now()
);

INSERT INTO students
VALUES (DEFAULT, 'Pedro', DEFAULT, DEFAULT);

INSERT INTO students (first_name)
VALUES ('JUAN');

-- 4. Insert into tabla VALUES (valorA1, ..., valorAn), (valorB1, ..., valorBN);
INSERT INTO students
VALUES 
(DEFAULT, 'Pedro', DEFAULT, DEFAULT),
(DEFAULT, 'Leidy', DEFAULT, DEFAULT),
(DEFAULT, 'Jenny', DEFAULT, DEFAULT),
(DEFAULT, 'Juan', DEFAULT, DEFAULT);

INSERT INTO students (first_name, created_at)
VALUES
('Juan', '2021-06-01'),
('Paola', '2021-06-01');


-- 5. Insert into tabla SELECT your-query;
INSERT INTO students (first_name, is_active)
SELECT f_name, active
FROM tmp_students;


-- 6. Datos nulos.
INSERT INTO students VALUES (NULL, NULL, NULL, NULL);

DROP TABLE students;

CREATE TABLE students (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    is_active BOOL NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP
);

INSERT INTO students
VALUES (DEFAULT, 'Alexys', TRUE, DEFAULT, DEFAULT);

-- No es posible, porque viola las restricciones de nulo.
INSERT INTO students VALUES (NULL, NULL, NULL, NULL);
