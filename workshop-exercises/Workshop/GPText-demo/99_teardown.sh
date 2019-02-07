#!/bin/bash
DB=gpuser
psql $DB -e -c "drop table if exists public.enron"
psql $DB -e -c "select gptext.drop_index('gpuser.public.enron')"

