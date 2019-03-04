EXPLAIN ANALYZE
SELECT split_part(a.airline_desc, ':', 1) AS airline,
       to_char(sum(f.flights)::integer, 'FM999,999') AS total_flights,
       avg(depdelayminutes)::numeric(8,1) AS avg_dep_delay,
       avg(arrdelayminutes)::numeric(8,1) AS avg_arr_delay,
       avg(arrdelayminutes)::numeric(8,1)-avg(depdelayminutes)::numeric(8,1) AS delta_mins
FROM faa.otp_ccz5 f
  INNER JOIN faa.d_airlines a ON a.airlineid = f.airlineid
WHERE f.origin = 'BOS'
  AND FlightDate > '2009-12-31'::date
GROUP BY a.airline_desc
ORDER BY avg(depdelayminutes) DESC;
