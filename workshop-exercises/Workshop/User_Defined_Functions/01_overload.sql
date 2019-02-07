create or replace function foo(int) returns int as
$$
    select $1 * 2
$$ 
language sql immutable;

create or replace function foo(float) returns float as
$$ 
    select $1 * 3.14159
$$
language sql immutable;

select foo(10);
select foo(10.0);
