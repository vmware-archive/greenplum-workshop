create or replace function show_routes () returns setof route as 
$$
   select f.origin AS origin_airport, f.dest AS dest_airport, f.carrier AS airline_name FROM  otp_r f group by 1,2,3 order by 1,2,3;
$$
language sql;
select show_routes() limit 20;
