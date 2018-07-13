This Sandbox has a collection of exercises, some of which are of more interest to developers and users of the Pivotal Greenplum Database, some more of interested to DBAs, and some of interest to both groups.  

The dataset is from the Federal Aviation Adminsistration (FAA) set of On Time Performance records for flights within the United States and is set up as a traditional datawarehouse star schema: a fact table with an entry for each flight and dimension tables describing some of the columns of the fact table.  

The exercises are a series of topics covering different aspects of the Greenplum database.
Each topic is included in its own directory.  Each has a set of script files and two special shell scripts.  showme.sh, which should be run first, displays all the scripts to be run for the exercise.  runme.sh runs each of the scripts in the prescribed order, pausing after each step so the results can be reviewed.

As a general rule, the scripts are numbered 01_<name>, 02_<name>, etc.  It's important to run them in the prescribed order as specified by the runme.sh script.  

When appropriate, each section will have pointers to more detailed material.

We use a standard query to run in the exercises called "delay_from_Logan".  Logan is the commonly used name of the airport in Boston, MA, USA whose official name is "General Edward Lawrence Logan International Airport". You will actually see the airport code BOS in these queries, but you can verify this by looking at the d_airports table.
