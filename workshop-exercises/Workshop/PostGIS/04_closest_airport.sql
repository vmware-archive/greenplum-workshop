drop type if exists nearby_airports;
create type nearby_airports as (airport_code text, distance float8);

create or replace function find_nearest (text,integer) returns setof nearby_airports as 
$$
   SELECT t2.name AS ap1, ST_Distance(t1.location, t2.location)/1000.00 AS mindist
FROM d_airports t1, d_airports t2 WHERE t1.airport_code = $1 AND t1.airport_code != t2.airport_code  AND length(t2.airport_code) != 0 
and t2.airport_code in (select distinct(dest) from otp_r)

ORDER BY ST_Distance(t1.location, t2.location)
LIMIT $2;
$$
language sql;

create or replace function find_nearest(text, float) returns setof nearby_airports as
$$
   SELECT t2.name AS ap1, ST_Distance(t1.location, t2.location)/1000.00 AS mindist
FROM d_airports t1, d_airports t2 WHERE t1.airport_code = $1 AND t1.airport_code != t2.airport_code AND length(t2.airport_code) != 0 AND ST_Distance(t1.location, t2.location) <= $2 * 1000.0
and t2.airport_code in (select distinct(dest) from otp_r)

ORDER BY ST_Distance(t1.location, t2.location)
$$
language sql;
