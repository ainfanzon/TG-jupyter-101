#!/bin/bash

echo 'nuke the tg logs'
echo ''

mysql -v -u root -p < ~/githome/TG-jupyter-101/ddl/printIMDBStats.sql
mysql -v -u root -p < ~/githome/TG-jupyter-101/ddl/printRecommendationStats.sql
