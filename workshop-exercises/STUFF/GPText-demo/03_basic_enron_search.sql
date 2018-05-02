\echo BASIC SEARCH
\echo -------------------------------------
select * from gptext.search(table(select 1 scatter by 1), 'gpuser.public.enron', 'content:2w(Phillips Petroleum) AND date:["2000-01-01T00:00:00Z" TO "2001-01-01T00:00:00Z"]', NULL) limit 10;

\echo SEARCH JOINING WITH ORIGINAL TABLE
\echo -------------------------------------
select l.id, l.score, r."to" from gptext.search(table(select 1 scatter by 1), 'gpuser.public.enron', 'content:2w(Phillips Petroleum) AND to:"Christine Stokes" AND date:["2000-01-01T00:00:00Z" TO "2001-01-01T00:00:00Z"]', NULL) l, enron r where l.id=r.id::text;

\echo SEARCH WITH MULTIPLE FILTERS 
\echo -------------------------------------
select l.id, l.score, r."to" from gptext.search(table(select 1 scatter by 1), 'gpuser.public.enron', 'content:2w(Phillips Petroleum)', array['to:"Christine Stokes"', 'date:["2000-01-01T00:00:00Z" TO "2001-01-01T00:00:00Z"]'], NULL) l, enron r where l.id=r.id::text;

\echo SEARCH WITH SOLR OPTIONS 
\echo -------------------------------------
select l.id, l.score, r."to" from gptext.search(table(select 1 scatter by 1), 'gpuser.public.enron', 'content:2w(Phillips Petroleum)', array['to:"Christine Stokes"', 'date:["2000-01-01T00:00:00Z" TO "2001-01-01T00:00:00Z"]'], 'rows=1') l, enron r where l.id=r.id::text;

\echo SEARCH WITH HIGHLIGHTING 
\echo -------------------------------------
select l.id, l.score, r."to", gptext.highlight(content, 'content', hs) from gptext.search(table(select 1 scatter by 1), 'gpuser.public.enron', 'content:2w(Phillips Petroleum)', array['to:"Christine Stokes"', 'date:["2000-01-01T00:00:00Z" TO "2001-01-01T00:00:00Z"]'], 'hl=true&hl.fl=content&rows=1') l, enron r where l.id=r.id::text;

