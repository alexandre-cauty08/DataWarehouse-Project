drop table search;
drop table ride;
drop table userUber;
drop table dateC;
drop table driver;
drop table timeOfDay;
drop table district;




create table userUber
(
    id integer primary key,
    firstName varchar2(50),
    LastName varchar2(50),
    age integer
);

create table dateC
(
    idDate integer primary key,
    dateCourante date,
    dayOfWeek varchar2(50),
    monthC varchar2(50),
    yearC varchar2(50),
    holiday integer,
    weekdayC integer
);

create table driver
(
    idDriver integer primary key,
    firstName varchar2(50),
    lastName varchar2(50)
);

create table timeOfDay
(
    idTime integer primary key,
    timeD varchar2(50),
    hour integer,
    minute integer,
    sec integer,
    AMPM varchar2(2)
);

 create table district
 (
    idDistrict integer primary key,
    codePostal integer,
    city varchar2(50),
    districtName varchar2(50),
    averageSalary integer,
    districtPopulation integer 
 );

create table ride
(
    idUser integer ,
    idDistrictDep integer ,
    idDistrictArr integer  ,
    idDate integer  ,
    idDriver integer  ,
    idOrderTime integer  ,
    idDepTime integer  ,
    idArrTime integer  ,
    price float,
    note integer,
    distance float,
    waintingTime integer,
    travelTime integer
);

create table search
(
    idDateSearch integer ,
    idTimeSearch integer ,
    idDistrict integer ,
    nbSearch integer,
    nbSearchSucc integer,
    nbSearchUnsucc integer,
    UnsuccNbSearch float(3), -- ratio de recherches non abouties par rapport au nombre de recherche
    SuccNbSearch float(3), -- ratio de recherches abouties par rapport au nombre de recherche
    nbDriver integer,
    nbFreeDriver integer,
    nbOccDriver integer,
    freeNbDriver float(3), -- ration chauffeurs libres/ nombvre de chauffeur
    OccNbDriver float(3), -- ration chauffeurs occupés/ nombvre de chauffeur
    AverageWaiting integer -- en minutes
);



alter table ride add foreign key(idUser) references userUber(id);
alter table ride add foreign key(idDistrictDep) references district(idDistrict);
alter table ride add foreign key(idDistrictArr) references district(idDistrict);
alter table ride add foreign key(idDate) references dateC(idDate);
alter table ride add foreign key(idDriver) references driver(idDriver);
alter table ride add foreign key(idOrderTime) references timeOfDay(idTime);
alter table ride add foreign key(idDepTime) references timeOfDay(idTime);
alter table ride add foreign key(idArrTime) references timeOfDay(idTime);


alter table search add foreign key(idDateSearch) references dateC(idDate);
alter table search add foreign key(idTimeSearch) references timeOfDay(idTime);
alter table search add foreign key(idDistrict) references district(idDistrict);


-- Destruction et création des vues virtuelles

drop view ride_date;
drop view search_date;

drop view search_time;
drop view order_time;
drop view dep_time;
drop view arr_time;

drop view search_district;
drop view dep_district;
drop view arr_district;



create view ride_date as select * from dateC;
create view search_date as select * from dateC;

create view search_time as select * from timeOfDay;
create view order_time as select * from timeOfDay;
create view dep_time as select * from timeOfDay;
create view arr_time as select * from timeOfDay;


create view search_district as select * from district;
create view dep_district as select * from district;
create view arr_district as select * from district;


drop view courses_View;
drop view RideView;
drop view Prix_View;

drop view driver_View;
drop view free_driver_View;
drop view WaitingAVG_View;

CREATE MATERIALIZED VIEW
courses_View (idDate, idDistrictDep, nb_Courses )
AS
SELECT idDate,idDistrictDep,count(idDate)
FROM ride
GROUP BY idDate, idDistrictDep;

CREATE MATERIALIZED VIEW
RideView (idDate, idDistrictDep, CA_district )
AS
SELECT idDate,idDistrictDep,SUM(price)
FROM ride
GROUP BY idDate, idDistrictDep;


CREATE MATERIALIZED VIEW
Prix_View ( idDistrictDep, PrixMoyen )
AS
SELECT idDistrictDep, idDate,SUM(price)
FROM ride
GROUP BY  idDistrictDep, idDate;

CREATE MATERIALIZED VIEW
driver_View ( idDateSearch, idDistrict, NbChauffeurs )
AS
SELECT idDateSearch, idDistrict,SUM(nbDriver)
FROM search
GROUP BY  idDateSearch, idDistrict;

CREATE MATERIALIZED VIEW
free_driver_View ( idDateSearch, idDistrict, NbChauffeursLibres )
AS
SELECT idDateSearch, idDistrict,SUM(nbFreeDriver)
FROM search
GROUP BY  idDateSearch, idDistrict;

CREATE MATERIALIZED VIEW
WaitingAVG_View ( idDateSearch, idDistrict, TempsAttenteMoyen )
AS
SELECT idDateSearch, idDistrict,AVG(AverageWaiting)
FROM search
GROUP BY  idDateSearch, idDistrict;