/* Database schema to keep the structure of entire database. */

create schema vet_clinic;

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species varchar(100);

BEGIN;
ALTER TABLE animals ALTER COLUMN species type unknown;
ROLLBACK;

CREATE TABLE owners(
    id SERIAL PRIMARY KEY,
    full_name varchar(100),
    age int
);

CREATE TABLE species(
    id SERIAL PRIMARY KEY,
    name varchar(100)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT references species(id);
ALTER TABLE animals ADD COLUMN owner_id INT references owners(id);

CREATE TABLE vets(
    id SERIAL PRIMARY KEY,
    name varchar(100),
    age int,
    date_of_graduation date
);

-- join tables
CREATE TABLE specializations(
    id_species INT,
    id_vet INT
);

CREATE TABLE visits(
    animals_id INT,
    vets_id INT,
    date_of_the_visit date
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_the_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

-- create index on email to make the select query goes faster
CREATE INDEX email_asc ON owners(email ASC);

-- create index on animals id
 CREATE INDEX animals_id_asc ON visits(animals_id ASC);