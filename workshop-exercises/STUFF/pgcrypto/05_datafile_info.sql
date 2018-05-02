create or replace function get_file_info(schemaname text, tablename text)
returns text 
as
$$
declare 
  dbdir text;
  tabfile text;
  schemaoid oid;
begin
  dbdir := oid from pg_database where datname = current_database();
  schemaoid := oid from pg_namespace where nspname = schemaname;
  tabfile := relfilenode from pg_class where relname = tablename  AND relnamespace = schemaoid;

return '/gpdata/segments/gpseg0/base/'||dbdir||'/'||tabfile;
end;
$$
language plpgsql;

