-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Listing the description of the crimes scencs took place on july 28
select description  from crime_scene_reports where day = 28 and month = 7 and street = 'Humphrey Street';

-- Since the description says each of interview transcripts mentions the bakery, chechking the interviews table transcript and look into the ones mentioning the bakery
-- Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.
-- I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.
-- As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.


-- The duck was stolen at 10:15

-- Checking Parking log for vehicles leaving around that time:
select license_plate from bakery_security_logs where month = 7 and day = 28 and hour = 10 and minute between 15 and 25 and activity = 'exit';

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
select name from people where license_plate in (select license_plate from bakery_security_logs where month = 7 and day = 28 and hour = 10 and minute between 15 and 25 and activity = 'exit');
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
select caller from phone_calls where month = 7 and day = 28 and duration < 60;
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

select name from people where phone_number in (select caller from phone_calls where month = 7 and day = 28 and duration < 60);
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
select origin_airport_id, destination_airport_id from flights where origin_airport_id = (select id from airports where city = 'Fiftyville') and month = 7 and day = 29 order by hour, minute limit 1;
-- +-------------------+------------------------+
-- | origin_airport_id | destination_airport_id |
-- +-------------------+------------------------+
-- | 8                 | 4                      |
-- +-------------------+------------------------+

-- Checking whhere the flight was headed to
select city from airports where id = 4;
-- +---------------+
-- |     city      |
-- +---------------+
-- | New York City |
-- +---------------+

                    -- THIEF WENT TO NEW YORK CITY.



-- Checking names of the passengers on the flight to see if any passenger was on the call during that time:
select people.name 
