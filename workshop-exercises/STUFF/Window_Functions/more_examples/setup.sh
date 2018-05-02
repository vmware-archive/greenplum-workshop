#!/bin/bash

PGDATABASE=gpuser
PGSCHEMA=window_demo

# Check if the demo schema is available. It not, create it.

schema=$(psql -At -d $PGDATABASE -c "select nspname from pg_catalog.pg_namespace where nspname = '$PGSCHEMA'")

if [ x$PGSCHEMA != x$schema ] ; then
    psql -d $PGDATABASE -c "create schema $PGSCHEMA" -o /dev/null
fi

echo "set search_path to $PGSCHEMA ;" > 00_init.sql
