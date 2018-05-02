-- Be sure to add a runtime first:
-- plcontainer runtime-add -r plc_r -i pivotaldata/plcontainer_r_shared:devel -l r

CREATE OR REPLACE FUNCTION rlog100() RETURNS double precision AS $$
# container: plc_r
return(log10(100))
$$ LANGUAGE plcontainer;

select rlog100();
