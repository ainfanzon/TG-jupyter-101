#!/bin/bash

echo 'This script will create and populate a local mysql db for use in'
echo 'demonstrating a simple friends association on Tigergraph'
echo ''

working_dir=`pwd`

echo ''
echo "Current working directory is: ${working_dir}"

mysql --local-infile=1 -u root -p friends < ${working_dir}/../ddl/createFriendshipSchema.sql

echo ''
echo 'Mysql setup complete..'
