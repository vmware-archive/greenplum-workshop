drop external table faa.d_airlines_ext;
CREATE EXTERNAL WEB TABLE faa.d_airlines_ext
(like faa.d_airlines)
EXECUTE 'psql -At -d otherdb -U gpadmin -c "select * from faa.d_airlines"' ON MASTER
FORMAT 'TEXT' (DELIMITER '|' NULL E'\N');

grant select on faa.d_airlines_ext to gpuser;
