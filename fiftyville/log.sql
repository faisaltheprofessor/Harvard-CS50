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

-- +-----+------+-------+-----+------+--------+----------+---------------+
-- | id  | year | month | day | hour | minute | activity | license_plate |
-- +-----+------+-------+-----+------+--------+----------+---------------+
-- | 260 | 2023 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |
-- | 261 | 2023 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
-- | 262 | 2023 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       |
-- | 263 | 2023 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
-- | 264 | 2023 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
-- | 265 | 2023 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
-- | 266 | 2023 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
-- | 267 | 2023 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
-- | 268 | 2023 | 7     | 28  | 10   | 35     | exit     | 1106N58       |
-- +-----+------+-------+-----+------+--------+----------+---------------+

-- Gettings names of the people in the parking lot during that time
select name from people where license_plate in (select license_plate from bakery_security_logs where month = 7 and day = 28 and hour = 10 and activity = 'exit');
-- +---------+
-- |  name   |
-- +---------+
-- | Vanessa |
-- | Barry   |
-- | Iman    |
-- | Sofia   |
-- | Taylor  |
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


-- Since the theif was seen at the ATM, checking ATM transctions:

select account_number from atm_transactions where month = 7 and day = 28 and atm_location = 'Leggett Street' and transaction_type = 'withdraw';
-- +-----+----------------+------+-------+-----+----------------+------------------+--------+
-- | id  | account_number | year | month | day |  atm_location  | transaction_type | amount |
-- +-----+----------------+------+-------+-----+----------------+------------------+--------+
-- | 246 | 28500762       | 2023 | 7     | 28  | Leggett Street | withdraw         | 48     |
-- | 264 | 28296815       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
-- | 266 | 76054385       | 2023 | 7     | 28  | Leggett Street | withdraw         | 60     |
-- | 267 | 49610011       | 2023 | 7     | 28  | Leggett Street | withdraw         | 50     |
-- | 269 | 16153065       | 2023 | 7     | 28  | Leggett Street | withdraw         | 80     |
-- | 288 | 25506511       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
-- | 313 | 81061156       | 2023 | 7     | 28  | Leggett Street | withdraw         | 30     |
-- | 336 | 26013199       | 2023 | 7     | 28  | Leggett Street | withdraw         | 35     |
-- +-----+----------------+------+-------+-----+----------------+------------------+--------+



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




