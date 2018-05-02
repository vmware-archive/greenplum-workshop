/*********************************************************************************
 State transition function [sfunc] needs to be created before defining aggregate.

 Two components needed to be calculated in the state function: count and sum.
 The function accumulates count and sum as values are passed to it.
*********************************************************************************/

CREATE or REPLACE function float8_sfunc_for_avg(arr float8[], val float8)
RETURNS float8[] AS
$$
BEGIN
   --   create count and sum, place the two values into an array
   return ARRAY [arr[1]+1, arr[2]+val]::float[];
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

/*********************************************************************************
 Final function [finalfunc] needs to be created before defining aggregate.

 The final function calculates the mean: sum / count.
*********************************************************************************/

CREATE or REPLACE function float8_avg(val float8[])
RETURNS float8 AS
$$
BEGIN
   return val[2] / val[1];  --  sum / count
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

/*********************************************************************************
 Create the aggrate function.
*********************************************************************************/

CREATE AGGREGATE avg_uda (float8)
(
  sfunc = float8_sfunc_for_avg, -- state function calculates count of records (count+=1)
                                -- and running sum (sum+=value)
  stype = float8[],             -- state variable type = float8
  finalfunc = float8_avg,       -- final function to calculate average (sum / count)
  initcond = '{0,0}'            -- initial condition, an array where count, sum are stored
);
