#!/bin/bash -l

set -o nounset
set -o errexit

bash ./04_get_hostname.sh

PSQL="psql -d gpuser -f "
for x in 0[0-9]_*.sql
do 
   $PSQL $x
   read -p "Press enter to continue"
done
