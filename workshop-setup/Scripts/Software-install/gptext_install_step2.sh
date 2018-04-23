#!/bin/bash
source /usr/local/greenplum-text/greenplum-text_path.sh

# Make sure you run gptext_install_step1.sh first

DB=gpuser

# Check if zookeeper is running
zkManager state > /dev/null 2>&1
if [[ $? != 0 ]]; then
    echo "ZooKeeper does not appear to be running."
    echo "Let's try and start it:  zkManager start"
    zkManager start
    [[ $? != 0 ]] && { echo "Problems starting zkManager" ; exit 1; }
fi

# Installing GPText schema in the gpuser database
# Make sure it has been created first.

psql -l | grep $DB > /dev/null 2>&1
if [[ $? != 0 ]]; then
    echo "$DB database is not listed in 'psql -l' output"
    echo "Create the db before proceeding"
    exit 1
fi

gptext-installsql gpadmin
gptext-installsql $DB
gptext-start

psql $DB -e -c "grant usage on schema gptext to $DB"
psql $DB -e -c "grant SELECT on gptext.gptext_envs to $DB"

echo "Did everything start OK?"

