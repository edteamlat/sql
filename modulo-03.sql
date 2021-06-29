-- Crear tabla de personas
-- ID, primer nombre, apellido, edad, fecha nacimiento, disponible
CREATE TABLE persons (
    id UUID,
    first_name VARCHAR(60),
    last_name VARCHAR(60),
    age SMALLINT,
    birthday DATE,
    available BOOL
);

-- Crea la tabla de trabajos
-- ID, ID persona, fecha inicial, fecha final, actual.
CREATE TABLE jobs (
    id UUID,
    persons_id UUID,
    begins_at DATE,
    ends_at DATE,
    currently bool
);

-- Borrar la edad de la tabla personas
ALTER TABLE persons DROP COLUMN age;

-- Agrega el nombre del trabajo a la tabla de trabajos
ALTER TABLE jobs ADD COLUMN job_name VARCHAR(50);

-- Crea tabla que vamos a borrar
CREATE TABLE para_borrar (
    id serial,
    howto varchar(50)
);

-- Borrar tabla innecesaria
DROP TABLE para_borrar;

insert into persons values (gen_random_uuid(), 'Pedro', 'Perez', '1999-01-02', true);
select * from persons;

insert into persons values ('ebead154-2bcb-4808-b4cd-833ea39b58cc', 'Pedro', 'Perez', '2005-04-06', false);