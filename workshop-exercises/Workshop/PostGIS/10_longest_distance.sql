/*
 For each airport in a given state, show me the destination airport that
 is the furthest in terms of distance.
*/

-- \set this_state '''Louisiana'''
\set this_state '''Texas'''

select c.oc as "Origin",
       c.dc as "Destination",
       round(c.max::numeric, 0) as "Distance (Miles)"
from (
    select b.orig_city as oc, b.destcityname as dc,
           first_value (st_distance(b.orig_loc, d.location) * 0.00062137) -- convert meters to miles
                 over (partition by b.origin
                       order by st_distance(b.orig_loc, d.location) desc
                       ) as max,
           row_number ()
                 over (partition by b.origin
                       order by st_distance(b.orig_loc, d.location) desc
                       ) as rn
    from d_airports d
       join (
            select distinct o.origin, o.dest, a.orig_loc, a.orig_city, o.destcityname
            from otp o,
                 (SELECT a.airport_code as orig_code
                         ,a.location as orig_loc
                         ,a.city as orig_city
                   FROM d_airports a
                         JOIN gis_airports ga ON a.airport_code = ga.locationid
                         JOIN gis_state gs ON ga.statename = gs.state
                   WHERE ST_CONTAINS(gs.geom, ga.geom)
                     AND gs.state = :this_state
                   ORDER BY ga.city, a.airport_code) a
            where o.origin  = a.orig_code
            ) b
          on d.airport_code = b.dest
     ) c
where c.rn = 1
order by c.oc
;

