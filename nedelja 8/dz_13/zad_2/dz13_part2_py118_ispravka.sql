-- 1.	Napisati upit koji će prikazati naziv aerodroma, broj terminala i
-- ukupan broj ruta sa aerodroma koji ima više od dva terminala. 
-- Rezultat urediti opadajuće po broju ruta i rastuće po broju terminala.

SELECT  airport.AirportName, airport.NumTerminals,count(route.RouteID)
FROM airport,route
WHERE (route.FromAirport=airport.AirportID or route.ToAirport=airport.AirportID)
GROUP BY airport.AirportID
HAVING airport.NumTerminals>2;

-- 2.	Napisati upit koji prikazuje broj letova koji lete na najdužoj ruti. 

SELECT flightdep.FlightID,count(flightdep.FlightID)
FROM flightdep
WHERE flightdep.FlightID=
						(SELECT flight.flightID
						FROM flight
						WHERE flight.RouteID=
											(SELECT route.RouteID
											FROM route 
											WHERE route.Distance=
																(SELECT MAX(route.Distance) 
																FROM route)));

-- 3.	Naći nazive svih tipova aviona, kao i ukupan broj tih aviona,
-- koje koristi avio-kompanija,  koristeći LEFT JOIN. 
-- Rezultate urediti opadajući po broju aviona.

SELECT aircraft.AircraftTypeID,aircrafttype.AircraftName, count(aircrafttype.AircraftTypeID) AS number_of_aircrafts
FROM aircraft
LEFT JOIN aircrafttype
ON aircraft.AircraftTypeID = aircrafttype.AircraftTypeID
GROUP BY aircrafttype.AircraftName
ORDER BY number_of_aircrafts DESC;

-- 4.	Naći nazive svih tipova aviona, kao i ukupan broj tih aviona, 
-- koje koristi avio-kompanija, koristeći RIGHT JOIN. 
-- Rezultate urediti opadajući po broju aviona.

SELECT aircraft.AircraftTypeID,aircrafttype.AircraftName, count(aircrafttype.AircraftTypeID) AS number_of_aircrafts
FROM aircrafttype
RIGHT JOIN aircraft
ON aircraft.AircraftTypeID = aircrafttype.AircraftTypeID
GROUP BY aircrafttype.AircraftName
ORDER BY number_of_aircrafts DESC;

-- 5.	Napisati upit koji će prikazati redni broj dana u nedelji
-- i broj letova u tom danu, pod uslovom da je broj letova veći od proseka.
SELECT * 
FROM (
				SELECT flightdep.DepDay,count(flight.FlightID) as number_of_flights
				FROM flightdep
				JOIN flight
				ON flight.FlightID=flightdep.FlightID 
				GROUP BY DepDay
				) as tabela
WHERE number_of_flights>(SELECT (AVG(number_of_flights)) 
						FROM (
								SELECT flightdep.DepDay,count(flight.FlightID) as number_of_flights
								FROM flightdep
								JOIN flight
								ON flight.FlightID=flightdep.FlightID 
								GROUP BY DepDay
								) as tabela2
						);

-- 6.	Napisati upite kojima se kreiraju liste ID-a svih letova od i ka aerodromu „Heathrow“, uređene opadajuće. 

SELECT flight.FlightID
FROM flight
JOIN route
ON           flight.RouteID=route.RouteID 
		and (route.FromAirport=(SELECT airport.AirportID FROM airport WHERE airport.AirportName LIKE "%Heathrow%") 
	    or  (route.ToAirport=(SELECT airport.AirportID FROM airport WHERE airport.AirportName LIKE "%Heathrow%")))
ORDER BY FlightID DESC;
