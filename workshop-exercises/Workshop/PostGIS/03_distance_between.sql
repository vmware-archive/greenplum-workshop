create or replace function distance_between(text, text) returns float as
$$
SELECT  ST_Distance(gg1, gg2, true)/1000.00 As sphere_dist 
   FROM (SELECT 
           get_loc($1) as gg1,
           get_loc($2) as gg2
	) As foobar  ;
$$
language SQL;

