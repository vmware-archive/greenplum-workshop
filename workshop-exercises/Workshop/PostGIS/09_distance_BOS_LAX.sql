SELECT ST_Distance(gg1, gg2,true)/1000.0 As spheroid_dist, ST_Distance(gg1, gg2, false)/1000.0 As two_dim 
   FROM (SELECT 
           get_loc('BOS') as gg1,
           get_loc('LAX') as gg2
	) As foobar  ;

