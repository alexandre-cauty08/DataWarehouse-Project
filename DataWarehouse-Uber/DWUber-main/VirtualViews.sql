drop view ride_date;
drop view search_date;

drop view search_time;
drop view order_time;
drop view dep_time;
drop view arr_time;

drop view search_district;
drop view dep_district;
drop view arr_district;



CREATE view ride_date AS SELECT * FROM dateC;
CREATE view search_date AS SELECT * FROM dateC;

CREATE view search_time AS SELECT * FROM timeOfDay;
CREATE view order_time AS SELECT * FROM timeOfDay;
CREATE view dep_time AS SELECT * FROM timeOfDay;
CREATE view arr_time AS SELECT * FROM timeOfDay;


CREATE view search_district AS SELECT * FROM district;
CREATE view dep_district AS SELECT * FROM district;
CREATE view arr_district AS SELECT * FROM district;

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
