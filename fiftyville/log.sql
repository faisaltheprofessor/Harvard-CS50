-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Listing the description of the crimes scencs took place on jly 28
select description, street  from crime_scene_reports where day = 28 and month = 7 and street = 'Humphrey Street';

-- Since the description says each of interview transcripts mentions the bakery, chechking the interviews table transcript and look into the ones mentioning the bakery

-- Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.
-- I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.
-- As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.


-- Since the theif was seen at the ATM, checking ATM transctions:

