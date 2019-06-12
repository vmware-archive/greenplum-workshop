create or replace  function whoami() returns text as $$
import commands
status, output = commands.getstatusoutput("whoami")
return output
$$ language plpythonu;

select whoami();
