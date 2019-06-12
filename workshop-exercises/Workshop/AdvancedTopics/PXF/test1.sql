drop external table foo_write_ext;
CREATE WRITABLE EXTERNAL TABLE foo_write_ext (LIKE foo)
LOCATION ('gpfdist://localhost:8080/foo_ext')  
FORMAT 'csv' ;

drop external table foo_read_ext;
CREATE EXTERNAL TABLE foo_read_ext (LIKE foo)
LOCATION ('gpfdist://localhost:8080/foo_ext')  
FORMAT 'csv' 
LOG ERRORS SEGMENT REJECT LIMIT 50000 rows;
