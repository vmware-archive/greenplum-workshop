This is a slightly more complicated exercise.  It's well known that you cannot do cross database joins in either PostgresQL or GPDB.  Well, that's not quite true.  You can do them in GPDB, BUT YOU WILL GET AWFUL PERFORMANCE.  We'll show that in this exercise.    

We'll show this by making a copy of the airports dimension table (d_airlines) in another database, otherdb, in a schema called faa (the same name as the schema in the gpuser database).  Then we'll create an external web table that uses the airports data in the otherdb database and joins it with data in the gpuser database.

To do this, there are some nuances.

First, some of the SQL runs in the gpsuer database and some in the faa_external database.  When running the psql command, note which database is being accessed.

Second, we need some help from gpadmin to allow the gpuser access to the otherdb database via psql.  This means adding a line to the pg_hba.conf file and running gpstop to read the new pg_hba.conf file.  

We also need to create an external web table.  We have already granted createexttable to gpuser, so this should not be a problem, should it?  We'll see.

Once we've done that, we do a simple join with the fact table in faa schema in gpuser database to the d_airports dimension table in the faa schema of the otherdb database.

Notice the timings of the join within database and the join across databases.

Take a look at the explain plans for the two queries.

Take a look at explain analyze for the two queries.
