## creates schema for MOVIES (based on IMDB data) and loads sample data
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

SET @datadir := '/Users/roberthardaway/githome/TG-jupyter-101/data/';

CREATE DATABASE IF NOT EXISTS ldbc;
USE ldbc;

DROP TABLE IF EXISTS comments;
CREATE  TABLE comments (
     id               DOUBLE,
     creationDate     DATE,
     locationIP     VARCHAR(25),
     browserUsed    VARCHAR(20),
     content        VARCHAR(250),
     length          INT
);

## Load from csv
LOAD DATA LOCAL INFILE '../data/ldbc_social/comment_0_0.csv' INTO TABLE comments FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' IGNORE 1 ROWS (id,creationDate,locationIP,browserUsed,content,length);
