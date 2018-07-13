This module provides an introduction to PostGIS, the spatial database extension to PostgreSQL and the Pivotal Greenplum Database.  The exercises begin with a grant done by gpadmin to allow the gpuser to access the PostGIS capabilities required for this exercise.  This grant is accomplished by the use of sudo, a Linux feature which may or may not be available on production systems.  

Then the d_airports table is altered to add a geography column into which the longitude and latitude coordinates of the airports are converted to PostGIS geography types.  Following a few user defined functions are created to make the following code more readable and convert distances from meters to kilometers.  Americans who prefer miles can alter the functions by remembering that there are approximately 1609.34 meters in a mile and altering the code.  

Of the approximately 1.5M flights in the fact table, some 3600 were diverted.  Let's consider :

