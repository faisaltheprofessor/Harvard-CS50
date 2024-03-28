-- In 10.sql, write a SQL query to list the names of all people who have directed a movie that received a rating of at least 9.0.
-- Your query should output a table with a single column for the name of each person.
-- If a person directed more than one movie that received a rating of at least 9.0, they should only appear in your results once.


SELECT DISTINCT(name) FROM movies  JOIN ratings ON ratings.movie_id = movies.id  JOIN directors ON directors.movie_id = movies.id  JOIN stars ON stars.movie_id = movies.id  JOIN people ON stars.person_id = people.id WHERE rating >= 9;
