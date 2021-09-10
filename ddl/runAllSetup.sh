#!/bin/bash

echo 'This script will create and populate a local mysql db for use in'
echo 'demonstrating a simple friends association on Tigergraph'
echo ''
echo 'For syntax help:'
echo ' ./runAllSetup.sh -help'
echo ''

if [ $# -eq 1 ]
  then
    echo "Help for mysql setup...."
    echo ''
    echo 'Assumes mysql is installed locally:'
    echo '   try typing: mysql -uroot -p'
    echo '   to see if it is installed'
    echo ''
    exit 0
fi

working_dir=`pwd`
data_dir="${working_dir}/../data/ldbc_social/"

echo ''
echo "Current working directory is: ${data_dir}"
echo ''

exit 0

mysql --local-infile=1 -uroot -p < ${working_dir}/createLDBCSchema.sql
mysql --local-infile=1 -uroot -p < ${working_dir}/createFriendshipSchema.sql
mysql --local-infile=1 -uroot -p < ${working_dir}/createIMDBSchema.sql

echo ''
echo 'Mysql setup complete..'
echo ''

