select (1.0/0.0);

create or replace function reciprocal(p_num float) returns float as
$$
declare
begin
  return (1.0/p_num);
  exception when DIVISION_BY_ZERO   then return ('NaN'::float8);
end;
$$
language plpgsql immutable ;

select reciprocal(2.0);
select reciprocal(-4.0);
select (1.0/0.0);
select reciprocal (0.0);

