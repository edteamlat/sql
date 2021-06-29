-- Restricciones de llave primaria, llave única y llaves foraneas
DROP TABLE IF EXISTS persons;
DROP TABLE IF EXISTS jobs;

-- Crear la tabla personas
CREATE TABLE persons (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    birthday DATE NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP,
    CONSTRAINT persons_id_pk PRIMARY KEY (id),
    CONSTRAINT persons_first_name_last_name_uk UNIQUE (first_name, last_name)
);

-- Insertar datos a la tabla personas
INSERT INTO persons 
VALUES (DEFAULT, 'Alexys', 'Lozada', now(), DEFAULT, NULL);

-- Viola restricción de UK
INSERT INTO persons 
VALUES (DEFAULT, 'Alexys', 'González', now(), DEFAULT, NULL);

-- Viola Restricción de PK
INSERT INTO persons 
VALUES ('b6b5cf9c-44e8-4c2c-8b78-f025e7aca9fe', 'Pedro', 'Perez', now(), DEFAULT, NULL);


-- Crear la tabla empleos
CREATE TABLE jobs (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    persons_id UUID NOT NULL,
    job_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP,
    CONSTRAINT jobs_id_pk PRIMARY KEY (id),
    CONSTRAINT jobs_persons_id_fk FOREIGN KEY (persons_id)
        REFERENCES persons (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

-- Inserta datos en los empleos
INSERT INTO jobs
VALUES (DEFAULT, 'b6b5cf9c-44e8-4c2c-8b78-f025e7aca9fe', 'DEVELOPER', DEFAULT, DEFAULT);

INSERT INTO jobs
VALUES (DEFAULT, 'abc5cf9c-44e8-4c2c-8b78-f025e7aca9fe', 'DEVELOPER', DEFAULT, DEFAULT);

-- Intento de borrado de información de personas
DELETE FROM persons
WHERE id = 'b6b5cf9c-44e8-4c2c-8b78-f025e7aca9fe';

DELETE FROM persons
WHERE id = '44b61eb7-f2a2-4fe2-b84e-0a6d04d43a2f';
