#!/bin/bash

DB=gpuser

psql $DB -ec "drop table if exists enron"
psql $DB -f 02_enron.sql
psql $DB -ec "select gptext.create_index('public', 'enron', 'id', 'content')"
psql $DB -ec "select gptext.enable_terms('gpuser.public.enron', 'content')"
psql $DB -ec "select * from gptext.index(table(select * from public.enron), 'gpuser.public.enron')"
psql $DB -ec "select gptext.commit_index('gpuser.public.enron')";
