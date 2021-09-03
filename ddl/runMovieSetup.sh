#!/bin/bash

echo 'This script will create and populate a local mysql db for use in'
echo 'demonstrating the IMDB database on Tigergraph'
echo ''

mysql --local-infile=1 -u root -p imdb < ~/githome/TG-jupyter-101/ddl/createMovieSchema.sql
mysql --local-infile=1 -u root -p imdb < ~/githome/TG-jupyter-101/ddl/printStats.sql
