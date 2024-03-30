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
select id, origin_airport_id, destination_airport_id from flights where origin_airport_id = (select id from airports where city = 'Fiftyville') and month = 7 and day = 29 order by hour, minute limit 1;
-- +----+-------------------+------------------------+
-- | id | origin_airport_id | destination_airport_id |
-- +----+-------------------+------------------------+
-- | 36 | 8                 | 4                      |
-- +----+-------------------+------------------------+

-- Checking whhere the flight was headed to
select city from airports where id = 4;
-- +---------------+
-- |     city      |
-- +---------------+
-- | New York City |
-- +---------------+

                    -- THIEF WENT TO NEW YORK CITY ON FLIGHT ID 36



-- Checking names of the passengers on the flight 36 and cross matching
select people.name from people inner join passengers on people.passport_number = passengers.passport_number inner join flights on flights.id = passengers.flight_id where flights.id = 36;


select name from (select people.name, people.license_plate from people inner join passengers on people.passport_number = passengers.passport_number inner join
flights on flights.id = passengers.flight_id where flights.id = 36) where name in (select name from people where phone_number in (select caller from phone_calls where month = 7 and day = 28 and duration < 60)) and license_plate in (select license_plate from bakery_security_logs where month = 7 and day = 28 and hour = 10 and minute between 15 and 25 and activity = 'exit');
-- These people were on the flight who were also seen in the parking lot and were on call
-- +--------+---------------+
-- |  name  | license_plate |
-- +--------+---------------+
-- | Sofia  | G412CB7       |
-- | Bruce  | 94KL13X       |
-- | Kelsey | 0NTHK55       |
-- +--------+---------------+


-- Now checking who made a widthdrawl

select account_number from atm_transactions where month = 7 and day = 28 and atm_location = 'Leggett Street' and transaction_type= "withdraw";
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

select people.name from bank_accounts join people on people.id=bank_accounts.person_id where name in (
select name from (select people.name, people.license_plate from people inner join passengers on people.passport_number = passengers.passport_number inner join
flights on flights.id = passengers.flight_id where flights.id = 36) where name in (select name from people where phone_number in (select caller from phone_calls where month = 7 and day = 28 and duration < 60)) and license_plate in (select license_plate from bakery_security_logs where month = 7 and day = 28 and hour = 10 and minute between 15 and 25 and activity = 'exit')
);

    -- - BRUCE IS THE THIEF, SINCE HE WAS SEEN IN PARKING, CALLING LESS THAN A MIINUTE AND ON THE FIRST FLIGHT NEXT MORNING


-- Now finding who helped bruce by checking who he was talking to

select caller, receiver from phone_calls where month = 7 and day = 28 and duration < 60;
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

select phone_number from people where name = 'Bruce';
-- +----------------+
-- |  phone_number  |
-- +----------------+
-- | (367) 555-5533 |
-- +----------------+


-- Now checking who bruce was talking to
select receiver from phone_calls where month = 7 and day = 28 and duration < 60 and caller = (select phone_number from people where name = 'Bruce');
-- +----------------+
-- |    receiver    |
-- +----------------+
-- | (375) 555-8161 |
-- +----------------+

-- Now checking who this number belongs to

select name from people where phone_number = (select receiver from phone_calls where month = 7 and day = 28 and duration < 60 and caller = (select phone_number from people where name = 'Bruce'));
-- +-------+
-- | name  |
-- +-------+
-- | Robin |
-- +-------+

                -- ROBIN HELPED BRUCE
