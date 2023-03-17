-- Use the albums_db database.

use albums_db;
select database();

-- What is the primary key for the albums table?

show tables;

select id 
from albums;

-- What does the column named 'name' represent?

select *
from albums;
-- name of the album 


-- What do you think the sales column represents?
-- dollars or copies?
-- millions? billions? thousands?
-- probably millions of copies


-- Find the name of all albums by Pink Floyd.

select artist, name
from albums
where artist = 'Pink Floyd'
;

-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
select release_date
from albums
where name = 'Sgt. Pepper\'s Lonely Hearts Club Band' -- with escape character backslash
;

select release_date, name
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band" -- with double quotes 
;

select release_date, name
from albums
where name = 'Sgt. Pepper''s Lonely Hearts Club Band' -- can escape with another single quote
;


-- What is the genre for the album Nevermind?

select genre
from albums
where name = 'Nevermind'
;


-- Which albums were released in the 1990s?
select name, release_date
from albums
where release_date between 1990 and 1999 
;

-- Which albums had less than 20 million certified sales?
select name, sales
from albums
where sales < 20
;



-- 1. Use the albums_db database.
show databases;
use albums_db;
select database ();
show tables;
select * 
from albums;

-- 2. What is the primary key for the albums table?
-- id

-- 3. What does the column named 'name' represent?
-- The name of album

-- 4.  What do you think the sales column represents?
-- probably number of copies the album sold (in millions)

-- 5. Find the name of all albums by Pink Floyd.
/* select distinct artist, name 
from albums
where artist = "Pink Floyd";
*/
-- The Dark Side of the Moon, The Wall

-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
/*
select name, release_date
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band";
*/
-- 1967

-- 7. What is the genre for the album Nevermind?
/*
select name, genre
from albums
where name = "Nevermind";
*/
-- Grunge, Alternative rock

-- 8. Which albums were released in the 1990s?
/*
select name, release_date
from albums
where release_date between 1990 and 1999;
*/
-- The Bodyguard,Jagged Little Pill, Come On Over,  Falling into You, Let's Talk About Love, Dangerous, The Immaculate Collection,
-- Titanic: Music from the Motion Picture, Metallica, Nevermind, Supernatural

-- 9. Which albums had less than 20 million certified sales?
/*
select name, sales
from albums 
where sales < 20.0;
*/
-- Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love,
-- Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms, Titanic: Music from the Motion Picture,
-- Nevermind, The Wall


SELECT name FROM albums WHERE sales < 20 ;

/*
'Grease: The Original Soundtrack from the Motion Picture'
'Bad'
'Sgt. Pepper\'s Lonely Hearts Club Band'
'Dirty Dancing'
'Let\'s Talk About Love'
'Dangerous'
'The Immaculate Collection'
'Abbey Road'
'Born in the U.S.A.'
'Brothers in Arms'
'Titanic: Music from the Motion Picture'
'Nevermind'
*/