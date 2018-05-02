-- Be sure to add a runtime first:
-- plcontainer runtime-add -r plc_py -i pivotaldata/plcontainer_python_shared:devel -l python

CREATE OR REPLACE FUNCTION public.os_cmd_container(cmd text) RETURNS text AS $$
# container: plc_py

import commands
status, output = commands.getstatusoutput(cmd)
return output
$$ LANGUAGE plcontainer;
