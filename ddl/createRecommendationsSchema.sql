## creates schema for FRIENDS (based on IMDB data) and loads sample data
##
## NOTE: script will DROP existing tables before creating new ones
##
## NOTE2: loading data from local csv is turned OFF by defult on mysql on mac
##
##   server side
##      SHOW GLOBAL VARIABLES LIKE 'local_infile';
##      SET GLOBAL local_infile=1;
##   client side
##      mysql --local-infile=1
##

SET @@GLOBAL.local_infile = 1;

CREATE DATABASE IF NOT EXISTS recommendations;
USE recommendations;

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
     userId          INT,
     movieId          INT,
     rating          DECIMAL(3,1),
     tmstamp          DOUBLE
);

DROP TABLE IF EXISTS nameBasics;
CREATE TABLE nameBasics (
     nconst          VARCHAR(20),
     primaryName     VARCHAR(60),
     birthYear          INT,
     deathYear          INT,
     primaryProfession          VARCHAR(50),
     knownForTitles           VARCHAR(300)
);

DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
     tconst                 INT,
     titleType              VARCHAR(40),
     primaryTitle           VARCHAR(100),
     originalTitle          VARCHAR(100),
     isAdult                INT,
     startYear                INT,
     endYear                INT,
     runtimeMinutes                INT,
     genres                 VARCHAR(300)
);

DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
     movieId          INT,
     title           VARCHAR(70),
     genres          VARCHAR(200)
);

DROP TABLE IF EXISTS friendships;
CREATE  TABLE friendships (
     person             INT,
     friend             INT,
     dateMet          DATE
);

DROP TABLE IF EXISTS people;
CREATE  TABLE people (
     nameId     VARCHAR(20),
     firstName     VARCHAR(40),
     lastName     VARCHAR(40),
     gender     VARCHAR(25),
     age          INT,
     language           VARCHAR(100)
);

DROP TABLE IF EXISTS links;
CREATE  TABLE links (
     movieId             INT,
     imdbId             INT,
     tmdbId          INT
);

DROP TABLE IF EXISTS tags;
CREATE  TABLE tags (
     userId             INT,
     movieId            INT,
     tag                VARCHAR(100),
     tmstamp            DATE
);

## Load from csv
LOAD DATA LOCAL INFILE '../data/recommendations/rating.csv' INTO TABLE ratings FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (userId,movieId,rating,tmstamp);
LOAD DATA LOCAL INFILE '../data/recommendations/name.basics.tsv' INTO TABLE nameBasics FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 ROWS (nconst,primaryName,birthYear,deathYear,primaryProfession,knownForTitles);
LOAD DATA LOCAL INFILE '../data/recommendations/title.basics.tsv' INTO TABLE titles FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 ROWS (tconst,titleType,primaryTitle,originalTitle,isAdult,startYear,endYear,runtimeMinutes,genres);
LOAD DATA LOCAL INFILE '../data/recommendations/movie.csv' INTO TABLE movies FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (movieId,title,genres);
LOAD DATA LOCAL INFILE '../data/recommendations/friendships.csv' INTO TABLE friendships FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (person,friend,dateMet);
LOAD DATA LOCAL INFILE '../data/recommendations/people.csv' INTO TABLE people FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (nameId,firstName,lastName,gender,age,language);
LOAD DATA LOCAL INFILE '../data/recommendations/link.csv' INTO TABLE links FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (movieId,imdbId,tmdbId);
LOAD DATA LOCAL INFILE '../data/recommendations/tag.csv' INTO TABLE tags FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (userId,movieId,tag,tmstamp);


