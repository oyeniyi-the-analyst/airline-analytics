DROP TABLE IF EXISTS airline_data_tb;

CREATE TABLE airline_data_tb (
    passenger_id TEXT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    age SMALLINT CHECK (age >= 0 AND age <= 120),
    nationality VARCHAR(100),
    airport_name VARCHAR(150) NOT NULL,
    airport_country_code CHAR(3) NOT NULL,
    country_name VARCHAR(100) NOT NULL,
    airport_continent VARCHAR(50) NOT NULL,
    continents VARCHAR(50),
    departure_date DATE NOT NULL,
    arrival_airport VARCHAR(150) NOT NULL,
    pilot_name VARCHAR(100),
    flight_status VARCHAR(20) NOT NULL
        CHECK (flight_status IN ('On Time','Delayed','Cancelled'))
);

COPY airline_data_tb
FROM 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PERSONAL PROJECT/Airline_Dataset_v2.csv'
DELIMITER ','
CSV HEADER;

ALTER TABLE airline_data_tb
ALTER COLUMN passenger_id TYPE TEXT;

SELECT COUNT(*)
FROM airline_data_tb;

-- Count of Passengers by Gender
SELECT gender, COUNT(*) AS passenger_count
FROM airline_data_tb
GROUP BY gender
ORDER BY passenger_count DESC;

-- Purpose: Helps management understand passenger demographics by gender.

-- Average Age of Passengers by Nationality
SELECT nationality, AVG(age::NUMERIC) AS average_age
FROM airline_data_tb
GROUP BY nationality
ORDER BY average_age DESC;

-- Purpose: Shows which countries have older or younger travelers.


-- Flights by Airport (Departure Airport)
SELECT airport_name, COUNT(*) AS total_departures
FROM airline_data_tb
GROUP BY airport_name
ORDER BY total_departures DESC
LIMIT 10;

-- Purpose: Identifies top 10 busiest airports in your dataset.

-- Flight Status Summary
SELECT flight_status, COUNT(*) AS flight_count
FROM airline_data_tb
GROUP BY flight_status
ORDER BY flight_count DESC;

-- Purpose: Management can see on-time vs delayed vs canceled flights.

-- Passengers by Continent Routes
SELECT continents, COUNT(*) AS passenger_count
FROM airline_data_tb
GROUP BY continents
ORDER BY passenger_count DESC;

-- Purpose: Shows which continent-to-continent routes are most popular.
-- Useful for strategic planning or route optimization.


-- Top Pilots by Number of Flights
SELECT pilot_name, COUNT(*) AS flights_handled
FROM airline_data_tb
GROUP BY pilot_name
ORDER BY flights_handled DESC
LIMIT 5;

