-- Select all columns and rows from the movies table
SELECT * 
FROM movies;

-- Select only the title and id of the first 10 rows
SELECT title, id 
FROM movies
LIMIT 10;

-- Find the movie with the id of 485
SELECT title
FROM movies
WHERE id = 485;

-- Find the id (only that column) of the movie Made in America (1993)
SELECT id
FROM movies
WHERE title LIKE 'Made in America%';

-- Find the first 10 sorted alphabetically
SELECT *
FROM movies
WHERE title LIKE 'A%'
ORDER BY title ASC
LIMIT 10;

-- Find all movies from 2002
SELECT *
FROM movies
WHERE title LIKE SUBSTRING('%\(2002\)%', 1);

-- Find out what year the Godfather came out
SELECT title
FROM movies
WHERE title LIKE 'Godfather%'
ORDER BY title ASC
LIMIT 1;

-- Without using joins find all the comedies
SELECT *
FROM movies
WHERE genres LIKE '%comedy%';

-- Find all comedies in the year 2000
SELECT *
FROM movies
WHERE genres LIKE '%comedy%' AND title LIKE SUBSTRING('%\(2000\)%', 1);

-- Find any movies that are about death and are a comedy
SELECT *
FROM movies
WHERE title LIKE '%death%' AND genres LIKE '%comedy%';

-- Find any movies from either 2001 or 2002 with a title containing super
SELECT *
FROM movies
WHERE title LIKE '%super%' AND title LIKE '%\(2001\)%' OR title LIKE '%super%' AND title LIKE '%\(2002\)%';
-- Create a new table called actors (We are going to pretend the actor can only play in one movie). The table should include name, character name, foreign key to movies and date of birth at least plus an id field.
;

-- Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements
INSERT INTO actors (actor,character_name,dob,movie_id)
	VALUES( 'Will Smith', 'Agent J', '1968-09-25', '1580'),
		('Tommy Lee Jones', 'Agent K', '1946-09-15', '1580'),
		('Kurt Russel', 'R.J. MacReady', '1951-03-15', '2288'),
		('Wilford Brimley', 'Blair', '1934-09-27', '2288'),
		('Keith David', 'Childs', '1956-06-04', '2288'),
		('Sigourney Weaver', 'Ellen Ripley', '1949-10-08', '1200'),
		('Michael Biehn', 'Corporal Dwayne Hicks', '1956-07-31', '1200'),
		('Paul Reiser', 'Carter Burke', '1956-03-30', '1200'),
		('Bill Paxton', 'Private Hudson', '1955-05-17', '1200'),
		('Lance Henriksen', 'Bishop', '1940-05-05', '1200');
		
-- Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating
UPDATE movies 
SET mpaa = 'G'
WHERE id = 1;

UPDATE movies 
SET mpaa = 'PG'
WHERE id = 2;

UPDATE movies 
SET mpaa = 'PG13'
WHERE id = 3;

UPDATE movies 
SET mpaa = 'R'
WHERE id = 4;

UPDATE movies 
SET mpaa = 'PG'
WHERE id = 5;

/* With Joins */
-- Find all the ratings for the movie Godfather, show just the title and the rating
SELECT m.title, r.rating
FROM movies m
	LEFT JOIN ratings r
	ON m.id = r.movie_id
	WHERE m.id = 858;
-- Order the previous objective by newest to oldest
SELECT m.title, r.rating, DATE(r.timestamp) review_date
FROM movies m
	LEFT JOIN ratings r
	ON m.id = r.movie_id
	WHERE m.id = 858
ORDER BY review_date DESC;
-- Find the comedies from 2005 and get the title and imdbid from the links table
SELECT m.title, l.imdb_id
FROM movies m
	LEFT JOIN links l
	ON m.id = l.movie_id
	WHERE m.title LIKE '%\(2005\)%' AND m.genres LIKE '%comedy%';
	
-- Find all movies that have no ratings
SELECT m.title, r.rating
FROM movies m
	LEFT JOIN ratings r
	ON m.id = r.movie_id
	WHERE r.rating IS NULL;

/* Complete the following aggregation objectives: */
-- Get the average rating for a movie
SELECT m.title, AVG(r.rating) rating_av
FROM movies m
	LEFT JOIN ratings r
	ON m.id = r.movie_id
	WHERE m.id = 1234
GROUP BY m.title;
-- Get the total ratings for a movie
SELECT m.title, COUNT(r.rating) rating_total
FROM movies m
	LEFT JOIN ratings r
	ON m.id = r.movie_id
	WHERE m.id = 260
GROUP BY m.title;
-- Get the total movies for a genre
SELECT COUNT(genres LIKE '%action%') action_total
FROM movies;

-- Get the average rating for a user
SELECT user_id, AVG(rating) rating_avg
FROM ratings
WHERE user_id = 1
GROUP BY user_id;

-- Find the user with the most ratings
SELECT user_id, COUNT(rating) rating_count
FROM ratings
GROUP BY user_id DESC
ORDER BY rating_count DESC
LIMIT 1;

-- Find the user with the highest average rating
SELECT user_id, AVG(rating) rating_avg
FROM ratings
GROUP BY user_id 
ORDER BY rating_avg DESC
LIMIT 1;

-- Find the user with the highest average rating with more than 50 reviews
SELECT user_id, AVG(rating) rating_avg, COUNT(rating) rating_count
FROM ratings
GROUP BY user_id 
HAVING rating_count > 50
ORDER BY rating_avg DESC
LIMIT 1;

-- Find the movies with an average rating over 4
SELECT m.title, AVG(r.rating) rating_avg
FROM movies m 
	LEFT JOIN ratings r
	ON m.id = r.movie_id
	GROUP BY m.title
	HAVING rating_avg > 4
	ORDER BY rating_avg DESC;