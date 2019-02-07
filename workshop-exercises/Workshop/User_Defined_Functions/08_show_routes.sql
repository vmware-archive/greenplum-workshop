create or replace function show_routes (int /* limit */ ) returns setof route as 
$$
   SELECT f.origin AS origin_airport, f.dest AS dest_airport, f.carrier AS airline_name
   FROM  otp_r f
   GROUP by 1,2,3
   ORDER BY 1,2,3
   LIMIT $1;
$$
language sql;
select show_routes(20);
