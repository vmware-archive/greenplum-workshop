create or replace function get_loc(text) returns geography AS
$$
select location from d_airports  where airport_code = $1
$$
language SQL;

