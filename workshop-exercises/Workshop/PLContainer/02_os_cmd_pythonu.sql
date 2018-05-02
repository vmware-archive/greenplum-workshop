create or replace  function public.os_cmd_pythonu(cmd text) returns text as $$
import commands
status, output = commands.getstatusoutput(cmd)
return output
$$ language plpythonu;
