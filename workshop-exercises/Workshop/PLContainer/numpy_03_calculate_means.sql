select avg(y) from public.test_data;
select public.arith_mean(array_agg(y)) from public.test_data;
select public.geom_mean(array_agg(y)) from public.test_data;
select public.harmonic_mean(array_agg(y)) from public.test_data;

