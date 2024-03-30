-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Listing the description of the crimes scencs took place on july 28
select description  from crime_scene_reports where day = 28 and month = 7 and street = 'Humphrey Street';

-- Since the description says each of interview transcripts mentions the bakery, chechking the interviews table transcript and look into the ones mentioning the bakery
-- Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.
-- I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.
-- As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.


-- The duck was stolen at 10:15

-- Checking Parking log for vehicles leaving around that time:
select license_plate from bakery_security_logs where month = 7 and day = 28 and hour = 10 and activity = 'exit';

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


-- Since the theif was seen at the ATM, checking ATM transctions:

select  account_number  from atm_transactions where month = 7 and day = 28 and atm_location = 'Leggett Street' and transaction_type = 'withdraw';
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



-- Checking phone calls less thatn 60 seconds
select caller from phone_calls where month = 7 and day = 28 and duration < 60;


-- Find the Names of the people associated with the Same License Plate
SELECT p.name from people p
JOIN bakery_security_logs ON p.license_plate = bakery_security_logs.license_plate
WHERE bakery_security_logs.day = 28 AND bakery_security_logs.month = 7
AND bakery_security_logs.hour = 10
AND bakery_security_logs.minute BETWEEN 15 AND 25;


