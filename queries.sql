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

SELECT COUNT(*) from animals;
SELECT COUNT(*) from animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) from animals;
SELECT sum(escape_attempts) as total_escape from animals group by (neutered);
SELECT species, MIN(weight_kg) as Minimum_Weight , MAX(weight_kg) as Maximum_Weight from animals GROUP BY(species);
SELECT AVG(escape_attempts) from animals WHERE date_of_birth BETWEEN '1990-01-01' and '2000-12-31' GROUP BY(species);

UPDATE animals set species_id = 2 WHERE name like '%mon';
UPDATE animals set species_id = 1 WHERE species_id is null;

UPDATE animals set owner_id = 1 where id = 1;
UPDATE animals set owner_id = 2 where id = 2 or id = 3;
UPDATE animals set owner_id = 3 where id = 4 or id = 6;
UPDATE animals set owner_id = 4 where id = 5 or id = 7 or id = 10;
UPDATE animals set owner_id = 5  where id = 9 or id = 8;

SELECT animals.name from animals
INNER JOIN owners on owners.id = animals.owner_id
where owners.full_name = 'Melody Pond';

SELECT animals.* from animals
INNER JOIN species on species.id = animals.species_id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name from animals
RIGHT JOIN owners on owners.id = animals.owner_id;

SELECT COUNT(animals.*), species.name from animals
INNER JOIN species on species.id = animals.species_id
GROUP BY species.name;

SELECT an.name from animals as an
INNER JOIN species as sp on sp.id = an.species_id
INNER JOIN owners as ow on ow.id = an.owner_id

WHERE ow.full_name = 'Jennifer Orwell' and sp.name ='Digimon';

SELECT a.* from animals as a
INNER JOIN owners as ow on ow.id = a.owner_id
WHERE ow.full_name = 'Dean Winchester' and a.escape_attempts = 0;


SELECT animals.name FROM visits 
JOIN animals ON animals_id = animals.id 
WHERE vets_id = 1 
ORDER BY date_of_the_visit DESC LIMIT 1;

SELECT animals.name FROM visits 
JOIN animals ON animals_id = animals.id 
WHERE vets_id = 2;

SELECT vets.name, species.name FROM vets 
LEFT JOIN specializations ON vets_id = vets.id 
LEFT JOIN species ON species_id = species.id;

SELECT animals.name FROM animals 
JOIN visits ON animals.id = animals_id 
WHERE vets_id = 3 AND date_of_the_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name FROM animals 
JOIN visits ON animals.id = animals_id 
GROUP BY animals.name ORDER BY COUNT(*) DESC LIMIT 1;

SELECT animals.name FROM animals 
JOIN visits ON animals.id = animals_id 
WHERE vets_id = 2 ORDER BY date_of_the_visit LIMIT 1;

SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.weight_kg, date_of_the_visit, vets.name as vets_name, vets.age as vets_age, vets.date_of_graduation FROM animals 
JOIN visits ON animals.id = animals_id JOIN vets ON vets_id = vets.id 
ORDER BY date_of_the_visit DESC LIMIT 1;

SELECT COUNT(*) FROM visits JOIN specializations ON visits.vets_id = specializations.vets_id 
JOIN animals ON animals.species_id = specializations.vets_id WHERE ;

SELECT vets.name,species.name FROM vets 
JOIN specializations ON vets.id!=specializations.vets_id 
JOIN species ON species.id !=specializations.species_id 
WHERE vets.name='Maisy Smith' LIMIT 1;
