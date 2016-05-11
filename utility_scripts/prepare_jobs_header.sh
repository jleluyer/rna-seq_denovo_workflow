#!/bin/bash



#change information in job headers

# usage prepare_jobs_header.sh userID userEmail

ID=$1
email=$2
PWD=$(pwd)

cd $PWD

for i in $(ls 00_scripts/*sh); do sed -i -e "s/userID/$ID/g" -e "s/userEmail/$email/g" $i

done
