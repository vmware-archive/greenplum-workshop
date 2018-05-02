Greenplum has the ability to load fixed format files using external tables and the gpfdist loader. Details can be found here: [Importing and Exporting Fixed Width Data](http://gpdb.docs.pivotal.io/4380/admin_guide/load/topics/g-importing-and-exporting-fixed-width-data.html)

But a quick example is below:
```
CREATE READABLE EXTERNAL TABLE students (
    name varchar(20), address varchar(30), age int)
LOCATION ('file://<host>/file/path/')
FORMAT 'CUSTOM' (formatter=fixedwidth_in,
         name='20', address='30', age='4');
```


There is another fixed format file we received (survey_data.fixed) that needs to be loaded. For this exercise, we will load straight from the fixed format file into a relational table with six columns.
Look at the first few lines of the file and create an external table to map the data (there are 6 fields). Follow the format in the example above. Start a _gpfdist_ process. Execute a select query to read from the external table.
NOTE: The ability to read from a local file using 'file:// ...' is reserved for users with Greenplum superuser privileges.

ExtraExtra Credit: Use a string function to further parse the 6th field.
