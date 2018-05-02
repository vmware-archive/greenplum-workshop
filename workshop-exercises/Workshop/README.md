This Sandbox has a collection of exercises, some of which are of more interest to developers and users of the Pivotal Greenplum Database, some more of interested to DBAs, and some of interest to both groups.  

The dataset is from the Federal Aviation Adminsistration (FAA) set of On Time Performance records for flights within the United States and is set up as a traditional datawares star schema with a fact table, with an entry for each flight, and dimension tables which describe some of the columns of the fact table.  

The exercises begin with some work by the root user and gpadmin, the database superuser.  These are described in the 00_Setup Directory and must be done first.  Then tables are created and loaded in the exercises in the 01_Create_Table, 02_Load_Tables and 03_First_Query.

Each topic is included in its own directory.  Each has a set of script files and two special shell scripts.  showme.sh should be run first.  It displays all the scripts to be run in doing the exercise.  runme.sh runs each of the scripts in the prescribed order, pausing after each so that the results can be seen.

As a general rule, the scripts are numbered 01_<name>, 02_<name>, etc.  It's important to run them in the prescribed order as specified by the runme.sh script.  

When appropriate, each section should have pointers to more detailed material.

We use a standard query to run in the exercises called "delay_from_Logan".  Logan is the commonly used name of the airport in Boston, MA, USA whose official name is "General Edward Lawrence Logan International Airport".    You will actually see the airport code BOS in these queries, but you can verify this by looking at the d_airports table.


