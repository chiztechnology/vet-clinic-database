/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%mon';
SELECT * from animals WHERE date_of_birth between '2016-01-01' and '2019-12-31';
SELECT * from animals WHERE neutered = true and escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name !='Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;

BEGIN;
UPDATE animals set species = 'digimon' WHERE name  like '%mon';
UPDATE animals set species = 'pokemon' WHERE species is null;
COMMIT;

BEGIN;
DELETE from animals where id !=0;
ROLLBACK;

SELECT * FROM animals;

BEGIN;
DELETE from animals where date_of_birth > '2022-01-01';
SAVEPOINT delete_recent_animals;
UPDATE animals set weight_kg = (weight_kg * -1) WHERE id !=0;
ROLLBACK TO delete_recent_animals;
UPDATE animals set weight_kg = (weight_kg * -1) WHERE weight_kg < 0;
COMMIT;