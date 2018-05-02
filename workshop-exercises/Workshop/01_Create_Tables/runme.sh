#!/bin/bash -l

set -o nounset
set -o errexit

PSQL="psql -d gpuser -f "
for x in 0[0-9]_*.sql
do 
   $PSQL $x
   read -p "Press enter to continue"
done
