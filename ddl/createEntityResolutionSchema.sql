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

CREATE DATABASE IF NOT EXISTS mdm;
USE mdm;

DROP TABLE IF EXISTS entity;
CREATE TABLE entity (
     id          INT,
     first_name          VARCHAR(25),
     last_name           VARCHAR(25),
     email               VARCHAR(50),
     gender              VARCHAR(10),
     ip_address          VARCHAR(25),
     middle_name         VARCHAR(25),
     phone               VARCHAR(25),
     dob                 DATE,
     device               VARCHAR(25),
     address               VARCHAR(40),
     city               VARCHAR(25),
     zipcode          INT
);

DROP TABLE IF EXISTS video;
CREATE TABLE video (
     ID              INT,
     runtime         INT,
     title           VARCHAR(80),
     release_date    DATE
);

DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
     genres           VARCHAR(25),
     videoId         INT
);

DROP TABLE IF EXISTS keyword;
CREATE TABLE keyword (
     keyword           VARCHAR(25),
     videoId         INT
);

DROP TABLE IF EXISTS play;
CREATE TABLE play (
     id                INT,
     accountId         INT,
     videoId         INT,
     play_date         DATE,
     play_duration         INT
);

## Load from csv
LOAD DATA LOCAL INFILE '../data/mdm/entity.csv' INTO TABLE entity FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (id,first_name,last_name,email,gender,ip_address,middle_name,phone,dob,device,address,city,zipcode);
LOAD DATA LOCAL INFILE '../data/mdm/video.csv' INTO TABLE video FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (ID,runtime,title,release_date);
LOAD DATA LOCAL INFILE '../data/mdm/video_genre.csv' INTO TABLE genres FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (genres,videoId);
LOAD DATA LOCAL INFILE '../data/mdm/video_keyword.csv' INTO TABLE keyword FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (keyword,videoId);
LOAD DATA LOCAL INFILE '../data/mdm/video_play.csv' INTO TABLE play FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (id,accountId,videoId,play_date,play_duration);


