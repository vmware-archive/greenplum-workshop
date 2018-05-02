select month, unrate, mv5::numeric(6,2), mv12::numeric(6,2) from demo.unemp limit 10;

select avg(unrate), stddev (unrate), stddev(mv5), stddev(mv12) from demo.unemp;

