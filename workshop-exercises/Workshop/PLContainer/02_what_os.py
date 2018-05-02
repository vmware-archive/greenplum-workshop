create or replace  function what_os() returns text as $$
import commands
status, output = commands.getstatusoutput("cat /etc/system-release")
return output
$$ language plpythonu;
