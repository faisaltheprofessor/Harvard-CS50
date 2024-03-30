-- Keep a log of any SQL queries you execute as you solve the mystery.
-- I used Tableplus to beautify SQL Syntax

-- Listing the description of the crimes scencs took place on july 28

SELECT
	description
FROM
	crime_scene_reports
WHERE
	day = 28
	AND month = 7
	AND street = 'Humphrey Street';

-- Since the description says each of interview transcripts mentions the bakery, chechking the interviews table transcript and look into the ones mentioning the bakery
-- Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.
-- I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.
-- As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.
-- The duck was stolen at 10:15
-- Checking Parking log for vehicles leaving around that time:

SELECT
	license_plate
FROM
	bakery_security_logs
WHERE
	month = 7
	AND day = 28
	AND hour = 10
	AND minute BETWEEN 15 AND 25
	AND activity = 'exit';

-- +---------------+
-- | license_plate |
-- +---------------+
-- | 5P2BI95       |
-- | 94KL13X       |
-- | 6P58WS2       |
-- | 4328GD8       |
-- | G412CB7       |
-- | L93JTIZ       |
-- | 322W7JE       |
-- | 0NTHK55       |
-- +---------------+

-- Gettings names of the people in the parking lot during that time

SELECT
	name
FROM
	people
WHERE
	license_plate in(
		SELECT
			license_plate FROM bakery_security_logs
		WHERE
			month = 7
			AND day = 28
			AND hour = 10
			AND minute BETWEEN 15 AND 25
			AND activity = 'exit');

-- +---------+
-- |  name   |
-- +---------+
-- | Vanessa |
-- | Barry   |
-- | Iman    |
-- | Sofia   |
-- | Luca    |
-- | Diana   |
-- | Kelsey  |
-- | Bruce   |
-- +---------+
-- Checking phone calls less thatn 60 seconds

SELECT
	caller
FROM
	phone_calls
WHERE
	month = 7
	AND day = 28
	AND duration < 60;

-- +----------------+
-- |     caller     |
-- +----------------+
-- | (130) 555-0289 |
-- | (499) 555-9472 |
-- | (367) 555-5533 |
-- | (499) 555-9472 |
-- | (286) 555-6063 |
-- | (770) 555-1861 |
-- | (031) 555-6622 |
-- | (826) 555-1652 |
-- | (338) 555-6650 |
-- +----------------+
-- getting names for these phone numbers:'

SELECT
	name
FROM
	people
WHERE
	phone_number in(
		SELECT
			caller FROM phone_calls
		WHERE
			month = 7
			AND day = 28
			AND duration < 60);

-- +---------+
-- |  name   |
-- +---------+
-- | Kenny   |
-- | Sofia   |
-- | Benista |
-- | Taylor  |
-- | Diana   |
-- | Kelsey  |
-- | Bruce   |
-- | Carina  |
-- +---------+
--  I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow (getting the flights to fiftyville on july 29)
-- Getting first flight leaving on july 29th

SELECT
	id,
	origin_airport_id,
	destination_airport_id
FROM
	flights
WHERE
	origin_airport_id = (
		SELECT
			id
		FROM
			airports
		WHERE
			city = 'Fiftyville')
		AND month = 7
		AND day = 29
	ORDER BY
		hour,
		minute
	LIMIT 1;

-- +----+-------------------+------------------------+
-- | id | origin_airport_id | destination_airport_id |
-- +----+-------------------+------------------------+
-- | 36 | 8                 | 4                      |
-- +----+-------------------+------------------------+
-- Checking whhere the flight was headed to

SELECT
	city
FROM
	airports
WHERE
	id = 4;

-- +---------------+
-- |     city      |
-- +---------------+
-- | New York City |
-- +---------------+
-- THIEF WENT TO NEW YORK CITY ON FLIGHT ID 36
-- Checking names of the passengers on the flight 36 and cross matching

SELECT
	people.name
FROM
	people
	INNER JOIN passengers ON people.passport_number = passengers.passport_number
	INNER JOIN flights ON flights.id = passengers.flight_id
WHERE
	flights.id = 36;

SELECT
	name
FROM (
	SELECT
		people.name,
		people.license_plate
	FROM
		people
		INNER JOIN passengers ON people.passport_number = passengers.passport_number
		INNER JOIN flights ON flights.id = passengers.flight_id
	WHERE
		flights.id = 36)
WHERE
	name in(
		SELECT
			name FROM people
		WHERE
			phone_number in(
				SELECT
					caller FROM phone_calls
				WHERE
					month = 7
					AND day = 28
					AND duration < 60))
	AND license_plate in(
		SELECT
			license_plate FROM bakery_security_logs
		WHERE
			month = 7
			AND day = 28
			AND hour = 10
			AND minute BETWEEN 15 AND 25
			AND activity = 'exit');

-- These people were on the flight who were also seen in the parking lot and were on call
-- +--------+---------------+
-- |  name  | license_plate |
-- +--------+---------------+
-- | Sofia  | G412CB7       |
-- | Bruce  | 94KL13X       |
-- | Kelsey | 0NTHK55       |
-- +--------+---------------+
-- Now checking who made a widthdrawl

SELECT
	account_number
FROM
	atm_transactions
WHERE
	month = 7
	AND day = 28
	AND atm_location = 'Leggett Street'
	AND transaction_type = "withdraw";

-- +----------------+
-- | account_number |
-- +----------------+
-- | 28500762       |
-- | 28296815       |
-- | 76054385       |
-- | 49610011       |
-- | 16153065       |
-- | 25506511       |
-- | 81061156       |
-- | 26013199       |
-- +----------------+

SELECT
	people.name
FROM
	bank_accounts
	JOIN people ON people.id = bank_accounts.person_id
WHERE
	name in(
		SELECT
			name FROM (
				SELECT
					people.name, people.license_plate FROM people
					INNER JOIN passengers ON people.passport_number = passengers.passport_number
					INNER JOIN flights ON flights.id = passengers.flight_id
				WHERE
					flights.id = 36)
			WHERE
				name in(
					SELECT
						name FROM people
					WHERE
						phone_number in(
							SELECT
								caller FROM phone_calls
							WHERE
								month = 7
								AND day = 28
								AND duration < 60))
						AND license_plate in(
							SELECT
								license_plate FROM bakery_security_logs
							WHERE
								month = 7
								AND day = 28
								AND hour = 10
								AND minute BETWEEN 15 AND 25
								AND activity = 'exit'));

-- - BRUCE IS THE THIEF, SINCE HE WAS SEEN IN PARKING, CALLING LESS THAN A MIINUTE AND ON THE FIRST FLIGHT NEXT MORNING
-- Now finding who helped bruce by checking who he was talking to

SELECT
	caller, receiver
FROM
	phone_calls
WHERE
	month = 7
	AND day = 28
	AND duration < 60;

-- +----------------+----------------+
-- |     caller     |    receiver    |
-- +----------------+----------------+
-- | (130) 555-0289 | (996) 555-8899 |
-- | (499) 555-9472 | (892) 555-8872 |
-- | (367) 555-5533 | (375) 555-8161 |
-- | (499) 555-9472 | (717) 555-1342 |
-- | (286) 555-6063 | (676) 555-6554 |
-- | (770) 555-1861 | (725) 555-3243 |
-- | (031) 555-6622 | (910) 555-3251 |
-- | (826) 555-1652 | (066) 555-9701 |
-- | (338) 555-6650 | (704) 555-2131 |
-- +----------------+----------------+

SELECT
	phone_number
FROM
	people
WHERE
	name = 'Bruce';

-- +----------------+
-- |  phone_number  |
-- +----------------+
-- | (367) 555-5533 |
-- +----------------+
-- Now checking who bruce was talking to

SELECT
	receiver
FROM
	phone_calls
WHERE
	month = 7
	AND day = 28
	AND duration < 60
	AND caller = (
		SELECT
			phone_number
		FROM
			people
		WHERE
			name = 'Bruce');

-- +----------------+
-- |    receiver    |
-- +----------------+
-- | (375) 555-8161 |
-- +----------------+
-- Now checking who this number belongs to

SELECT
	name
FROM
	people
WHERE
	phone_number = (
		SELECT
			receiver
		FROM
			phone_calls
		WHERE
			month = 7
			AND day = 28
			AND duration < 60
			AND caller = (
				SELECT
					phone_number
				FROM
					people
				WHERE
					name = 'Bruce'));

-- +-------+
-- | name  |
-- +-------+
-- | Robin |
-- +-------+
-- ROBIN HELPED BRUCE
