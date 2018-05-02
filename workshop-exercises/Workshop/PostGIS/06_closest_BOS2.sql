SELECT al1.airport_code, al1.name, ST_Distance(al1.location, al2.location)/1000.0 as dist_km from d_airports al1, d_airports al2 WHERE al1.airport_code != al2.airport_code  AND ST_Distance(al1.location, al2.location) > 0 AND al2.airport_code = 'BOS' AND al1.name like '%irport%'
ORDER BY ST_Distance(al1.location, al2.location)
LIMIT 3;

