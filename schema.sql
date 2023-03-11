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
    id_species INT references species(id);
    id_vet INT references vets(id);
);

CREATE TABLE visits(
    id_animal INT references animals(id);
    id_vet INT references vets(id);
);

