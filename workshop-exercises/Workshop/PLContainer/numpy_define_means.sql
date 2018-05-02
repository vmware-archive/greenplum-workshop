DROP FUNCTION IF EXISTS public.arith_mean(double precision[]);
CREATE OR REPLACE FUNCTION public.arith_mean(value_array double precision[])
RETURNS float
AS $$
# container: plc_py
import numpy as np
return np.mean(value_array)
$$ LANGUAGE plcontainer;

DROP FUNCTION IF EXISTS public.geom_mean(double precision[]);
CREATE OR REPLACE FUNCTION public.geom_mean(value_array double precision[])
RETURNS float
AS $$
# container: plc_py
from scipy import stats
return stats.gmean(value_array)
$$ LANGUAGE plcontainer;

DROP FUNCTION IF EXISTS public.harmonic_mean(double precision[]);
CREATE OR REPLACE FUNCTION public.harmonic_mean(value_array double precision[])
RETURNS float
AS $$
# container: plc_py
from scipy import stats
return stats.hmean(value_array)
$$ LANGUAGE plcontainer;

