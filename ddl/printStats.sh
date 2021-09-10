#!/bin/bash

echo 'This script will display current stats for the demo datasets, which currently include:'
echo '    - Friends'
echo '    - IMDB'
echo '    - LDBC'
echo ''

mysql -v -u root -p < ~/githome/TG-jupyter-101/ddl/printStats.sql
