\echo FACTED FIELD SEARCH
\echo Search count grouped by from and to for documents matching 'Phillips Petroleum'
\echo -------------------------------------
select * from gptext.faceted_field_search('gpuser.public.enron', 'content:2w(Phillips Petroleum) AND date:["2000-01-01T00:00:00Z" TO "2001-01-01T00:00:00Z"]', NULL, '{from, to}', 4, 0) limit 10;

\echo FACTED QUERY SEARCH
\echo Search count grouped by year 2000 and to:"Christine Stokes" for documents matching 'Phillips Petroleum'
\echo -------------------------------------
select * from gptext.faceted_query_search('gpuser.public.enron', 'content:2w(Phillips Petroleum)', NULL, array['date:["2000-01-01T00:00:00Z" TO "2001-01-01T00:00:00Z"]', 'to:"Christine Stokes"']) limit 10;

\echo FACTED RANGE SEARCH
\echo Search count grouped by each year from year 2000 to year 2005 for documents matching 'Phillips Petroleum'
\echo ------------------------------------
select * from gptext.faceted_range_search('gpuser.public.enron', 'content:2w(Phillips Petroleum)', NULL, 'date', '2000-01-01T00:00:00Z', '2005-01-01T00:00:00Z', '+1YEAR') limit 10;

\echo SEARCH COUNT
\echo -------------------------------------
select gptext.search_count('gpuser.public.enron', 'content:2w(Phillips Petroleum) AND to:"Christine Stokes" AND date:["2000-01-01T00:00:00Z" TO "2001-01-01T00:00:00Z"]');
