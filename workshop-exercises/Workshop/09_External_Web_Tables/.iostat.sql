-- x_iostat:
--
-- An example external web executable table that reads the current
-- iostat utilization stats.
--

DROP EXTERNAL WEB TABLE IF EXISTS public.x_iostat CASCADE;

CREATE EXTERNAL WEB TABLE public.x_iostat
   (   device               VARCHAR
     , tps                  NUMERIC
     , blk_reads_per_sec    NUMERIC
     , blk_writes_per_sec   NUMERIC
     , blk_read             NUMERIC
     , blk_write            NUMERIC
   )
     EXECUTE 'iostat -p sda 1 5 | grep sda | sed -r "s/ +/,/g"' ON ALL
     FORMAT 'CSV'
;
