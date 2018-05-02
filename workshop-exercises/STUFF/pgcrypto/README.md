This module shows one method of encrypting data in the Pivotal Greenplum Database using the PostgreSQL pgcrytpo module.  There are other encryption  methods that you can read about in the Pivotal Greenplum Security Whitepaper.

Suppose there was a table with the names, pilot's license number, and employee id of each pilot and suppose the FAA data set indicated which pilot flew each flight, but we didn't want to expose the pilot's name.  We could do this quite simply by using a pgcrypto
symmetric encryption method which stores the encrypted data in a column of type bytea.  

First, we'll create two versions of the pilots table, one encrypted and one in plain text.

Then we'll load the tables with gpload.  Notice in the yaml file for the encrypted tables, we do a transformation on the name column of the pilots_encrypted table.  You should read the documentation for use of the pgp_sym_encrypt_bytea function. 

Then we'll run a select * on each of the tables, showing that in the encrypted table, the name column truly is encrypted.  

Next, we'll run a query on the encryped table using the correct decryption function and see that we get the actual names.

Finally, we'll create a function that produces the names of the data files corresponding to these tables
and then run the function on both the encrypted and unencrypted tables.

Lastly, as gpadmin, we'll run the Linux strings command on both files, demonstrating that the names are visible in the plain text version of the table, but not in the encrypted version.

