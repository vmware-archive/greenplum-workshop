#!/bin/bash

DB=gpuser

psql $DB -e -c "drop table if exists enron"
psql $DB -f 02_enron.sql
psql $DB -e -c "select gptext.create_index('public', 'enron', 'id', 'content')"
psql $DB -e -c "select gptext.enable_terms('gpuser.public.enron', 'content')"
psql $DB -e -c "select * from gptext.index(table(select * from public.enron), 'gpuser.public.enron')"
psql $DB -e -c "select gptext.commit_index('gpuser.public.enron')";
