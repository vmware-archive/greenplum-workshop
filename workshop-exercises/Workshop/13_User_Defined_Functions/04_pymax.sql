-- Note: this function must be created by an account with superuser privileges (like gpadmin)

CREATE or replace FUNCTION pymax (a integer, b integer)
  RETURNS integer
AS $$
  if a > b:
    return a
  return b
$$ LANGUAGE plpythonu;
