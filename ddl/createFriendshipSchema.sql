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

CREATE DATABASE IF NOT EXISTS friends;
USE friends;

DROP TABLE IF EXISTS people;
CREATE  TABLE people (
     nameId     VARCHAR(20),
     name     VARCHAR(40),
     gender     VARCHAR(25),
     age          INT,
     language           VARCHAR(100)
);

DROP TABLE IF EXISTS friendships;
CREATE  TABLE friendships (
     p1             VARCHAR(20),
     p2        VARCHAR(20),
     dateMet          DATE
);


## Load from csv
LOAD DATA LOCAL INFILE '../data/people.csv' INTO TABLE people FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (nameId,name,gender,age,language);
LOAD DATA LOCAL INFILE '../data/friendships.csv' INTO TABLE friendships FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (p1,p2,dateMet);





