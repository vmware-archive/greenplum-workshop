set search_path=information_schema, pg_catalog, gp_toolkit;
SELECT table_catalog, table_schema, table_name, table_type FROM information_schema.tables ORDER BY table_name;
SELECT table_catalog, table_schema, table_name, table_type FROM information_schema.tables where table_schema = 'faa' ORDER BY table_name;

