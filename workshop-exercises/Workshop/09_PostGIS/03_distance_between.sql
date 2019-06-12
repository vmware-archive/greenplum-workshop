create or replace function distance_between(text, text) returns float as
$$
SELECT  ST_Distance(loc1, loc2, true)/1000.0 As sphere_dist 
   FROM (SELECT 
           get_loc($1) as loc1,
           get_loc($2) as loc2
	) as a  ;
$$
LANGUAGE SQL;
