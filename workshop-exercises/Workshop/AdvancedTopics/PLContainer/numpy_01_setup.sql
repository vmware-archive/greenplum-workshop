DROP TABLE IF EXISTS public.test_data;

CREATE TABLE public.test_data AS
SELECT 'a'::text AS name, generate_series(1,3000000)::float8 AS x, generate_series(1,3000000)/100.0::float8 AS y
DISTRIBUTED BY (name);
