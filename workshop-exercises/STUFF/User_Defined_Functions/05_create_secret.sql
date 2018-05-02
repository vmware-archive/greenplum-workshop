drop table if exists public.secret;
create table public.secret (
  id int,
  value float) distributed randomly;

insert into public.secret values (1,1.1), (2,2.2), (3,3.3);

select * from public.secret;

create or replace function public.secret_sum() returns float as
$$
select sum(value) from public.secret;
$$ 
language sql stable security definer;

grant execute on function public.secret_sum() to gpuser;
