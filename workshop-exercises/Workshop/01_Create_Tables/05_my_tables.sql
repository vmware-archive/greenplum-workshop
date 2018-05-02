SELECT table_catalog as "Database",
       table_schema  as "Schema",
       table_name    as "Table",
       table_type    as "Type"
FROM information_schema.tables 
WHERE table_schema = 'faa';
