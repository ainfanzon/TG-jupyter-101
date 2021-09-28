## print stats for all the tables
##

SELECT NOW();

SELECT '';
SELECT 'Statistics for recommendations db' as '';

USE recommendations;

SELECT 'friendships:' as '';
SELECT count(*) from friendships;
SELECT 'people:' as '';
SELECT count(*) from people;
SELECT 'nameBasics:' as '';
SELECT count(*) from nameBasics;
SELECT 'ratings:' as '';
SELECT count(*) from ratings;
SELECT 'titles:' as '';
SELECT count(*) from titles;
SELECT 'tags:' as '';
SELECT count(*) from tags;
SELECT 'links:' as '';
SELECT count(*) from links;


##select count(distinct nameId) from people;