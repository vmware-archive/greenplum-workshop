-- Be sure to add a runtime first:
-- plcontainer runtime-add -r plc_py -i pivotaldata/plcontainer_python_shared:devel -l python

CREATE OR REPLACE FUNCTION pylog100() RETURNS double precision AS $$
# container: plc_py
import math
return math.log10(100)
$$ LANGUAGE plcontainer;

select pylog100();

