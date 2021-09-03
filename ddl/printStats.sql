## print stats for all the tables
##

USE IMDB;

select count(*) from title_basics;
select count(*) from name_basics;
select count(*) from title_ratings;
select count(*) from title_principals;

