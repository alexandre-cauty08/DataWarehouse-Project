-- nombre de courses par villes et districtes
-- Permet de savoir les districtes et villes dans lesquels il y a le moins de commandes

SELECT dep_district.city , dep_district.districtName, count(ride.idDistrictDep) 
FROM ride , dep_district 
WHERE ride.idDistrictDep = dep_district.idDistrict 
GROUP BY CUBE(  dep_district.city, dep_district.districtName);

-- Nombre de courses en fonction du salaire moyen dans le district
-- Peut amener à la mise en place de primes dans ccertains quartiers
SELECT dep_district.averageSalary , dep_district.districtName, count(ride.idDistrictDep) 
FROM ride , dep_district 
WHERE ride.idDistrictDep = dep_district.idDistrict 
GROUP BY CUBE(  dep_district.averageSalary, dep_district.districtName);

-- Nombre de courses par jours

SELECT ride_date.dayOfWeek, COUNT(ride.idDate)
FROM  ride_date,ride
WHERE ride.idDate = ride_date.idDate
GROUP BY dayOfWeek;

-- Somme chiffre d'affaires de Uber par jours et par district
-- Savoir quels sont les districtes qui rapportent le plus

SELECT ride_date.dayOfWeek, dep_district.districtName, SUM(ride.price)
FROM ride_date,ride, dep_district
WHERE ride.idDate = ride_date.idDate
and dep_district.idDistrict = ride.idDistrictDep
GROUP BY CUBE(ride_date.dayOfWeek, dep_district.districtName);

-- Somme des chiffres d'affaires par district
-- Il faudra multiplier le resultat par O,25 pour obtenir la part d'Uber
SELECT dep_district.districtName,SUM(ride.price)
FROM dep_district,ride
WHERE ride.idDistrictDep = dep_district.idDistrict
GROUP BY ROLLUP(dep_district.districtName);  

-- Somme des recherches non abouties par jours
SELECT search_date.dayOfWeek, SUM(search.nbSearchUnsucc)
FROM search,search_date
WHERE search.idDateSearch = search_date.idDate
GROUP BY(search_date.dayOfWeek); 


 -- Nombre de courses non abouties par quartier et par villes

SELECT search_district.districtName, search_district.city, count(search.idDistrict) 
FROM search,search_district
WHERE search.idDistrict = search_district.idDistrict
GROUP BY CUBE (search_district.districtName, search_district.city);

 -- Nombre de chauffeurs libres par jours

SELECT search_date.dayOfWeek, SUM(search.nbOccDriver)
FROM search, search_date
WHERE search_date.idDate = search.idDateSearch
GROUP BY search_date.dayOfWeek;

 -- Temps d’attente moyen par heures par districtes 

SELECT search_district.districtName, search_time.hour, SUM(search.AverageWaiting)
FROM search,search_time,search_district
WHERE search_time.idTime = search.idDateSearch
AND search_district.idDistrict = search.idDistrict
GROUP BY (search_district.districtName, search_time.hour);



-- nb courses en fonction de la population par quartier ou par ville
SELECT dep_district.districtPopulation, dep_district.districtName, sum(ride.idDate)
FROM dep_district, ride
WHERE dep_district.idDistrict = ride.idDistrictDep
GROUP BY (dep_district.districtPopulation, dep_district.districtName);

-- nb chauffeurs par district en fonction de la population
-- Pour savoir le ration de chauffeurs en fonction de la population
SELECT order_time.hour ,dep_district.districtName, dep_district.districtPopulation, sum(search.nbDriver)
FROM order_time, dep_district, search
WHERE order_time.idTime = search.idTimeSearch
AND dep_district.idDistrict = search.idDistrict
GROUP BY (order_time.hour ,dep_district.districtName, dep_district.districtPopulation);