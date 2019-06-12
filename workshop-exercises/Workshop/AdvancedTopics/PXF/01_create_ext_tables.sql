CREATE WRITABLE EXTERNAL TABLE pxf_write_airlines_parquet (airlineid integer, airline_desc text)
    LOCATION ('pxf://data/pxf_examples/pxf_parquet?PROFILE=hdfs:parquet')
  FORMAT 'CUSTOM' (FORMATTER='pxfwritable_export');


CREATE EXTERNAL TABLE pxf_read_airlines_parquet(airlineid integer, airline_desc text)
    LOCATION ('pxf://data/pxf_examples/pxf_parquet?PROFILE=hdfs:parquet')
    FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

