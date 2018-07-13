If you deal with text fields on a regular basis, you may have a need for parsing a string for particular values or for extracting a substring from a log string. Greenplum, courtesy of our Postgres heritage, has a rich assortment of string functions available from SQL.

In this exercise we will run through a short example of loading a fixed format file and parsing each line into its constituent parts for loading into a relational table.
We will do this in stages:
* Create a staging table that will store each line as a single TEXT field
* Create our production table that we will load from the staging table
* Load our staging table from a fixed format flat file
* Use SQL to load from our staging table into our production table
* Look at the final result
