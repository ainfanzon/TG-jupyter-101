#!/bin/bash

echo 'This script will create and populate a local mysql db for use in'
echo 'demonstrating a simple friends association on Tigergraph'
echo ''

working_dir=`pwd`
data_dir="${working_dir}/../data/ldbc_social/"

echo ''
echo "Current working directory is: ${data_dir}"
echo ''

mysql --local-infile=1 -uroot -p < ${working_dir}/createLDBCSchema.sql

echo ''
echo 'Mysql setup complete..'


##  -e "set @workDir='${working_dir}'"