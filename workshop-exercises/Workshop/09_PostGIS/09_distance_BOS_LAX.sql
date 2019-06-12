SELECT ST_Distance(loc1, loc2,true)/1000.0 As spheroid_dist, ST_Distance(loc1, loc2, false)/1000.0 As two_dim 
FROM (SELECT 
           get_loc('BOS') as loc1,
           get_loc('LAX') as loc2
	 ) As foobar  ;
