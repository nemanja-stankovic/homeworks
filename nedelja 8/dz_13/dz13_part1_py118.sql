-- 1.	U tabeli „class“ dodati novi zapis „Regular“. Zameniti u tabeli „pax“ sva pojavljivanja klase tipa „Silver“ i „Gold“ klasom koju ste dodali.
INSERT class(ClassID,ClassName) VALUES('5','Regular');
UPDATE pax
SET classID = 5
WHERE classID = 2 OR classID = 3;

-- 2.	Zameniti u tabeli (update-ovati) „aircraft“ sve letilice tipa „Boeing“ i sve letelice koje u nazivu sadrže slova „M“ ili „W“, letelicom koja u nazivu sadrži „330
UPDATE aircraft
SET aircraft.AircraftTypeID=(SELECT aircrafttype.AircraftTypeID FROM aircrafttype WHERE aircrafttype.AircraftName LIKE "%330%")
WHERE aircraft.AircraftID=(SELECT aircrafttype.AircraftTypeID FROM aircrafttype WHERE aircrafttype.AircraftName LIKE "%Boeing%");

-- 3.	Napisati upit koji će prikazati ID-jeve ruta i razdaljine (između aerodroma) svih ruta sa nadprosečnom razdaljinom, uređene opadajući po razdaljini.
SELECT RouteID, Distance
FROM route
WHERE route.Distance>(SELECT avg(route.Distance) FROM route)
ORDER BY route.Distance DESC;

-- 4.	Napisati upit kojim se kreira listu ID-a svih letova od i ka aerodromu „Heathrow“, uređene opadajuće. 
select RouteID
FROM route 
WHERE route.FromAirport=(SELECT airport.AirportID FROM airport WHERE airport.AirportName='Heathrow Airport')
	  OR route.ToAirport=(SELECT airport.AirportID FROM airport WHERE airport.AirportName='Heathrow Airport');

-- 5.	Napisati upit koji prikazuje listu svih ruta sa nadprosečnim rastojanjem.
SELECT *
FROM route
WHERE Distance>(SELECT AVG(route.Distance) FROM route);



