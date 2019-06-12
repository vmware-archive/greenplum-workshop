This workshop has a collection of exercises, some of which are of more interest to developers and users of the Pivotal Greenplum Database, some more of interested to DBAs, and some of interest to both groups.  

The dataset used for most of the exercises is from the Federal Aviation Adminsistration (FAA) set of On Time Performance records for flights within the United States. It is set up as a traditional datawarehouse star schema with a fact table containing an entry for each flight and a set of supporting dimension tables.  

The exercises assume that the server has been prepared using the scripts in the workshop-setup directory.

Each topic is included in its own directory.  Each has a set of script files and two special shell scripts:
* showme.sh - displays all the scripts to be run in doing the exercise
* runme.sh  - runs each of the scripts in the prescribed order, pausing after each so that the results can be seen.

There are a number of directories in the Workshop folder.  Each has a set of exercises.  
The first four numbered exercises in the Workshop directory are run first. After that, the exercises can be run in any order.
As a general rule, the scripts for each section are numbered 01_<name>, 02_<name>, etc.  It's important to run them in the prescribed order as specified by the runme.sh script.  

When appropriate, each section should have pointers to more detailed material.

We use a standard query to run in the exercises called "delay_from_Logan". Logan is the commonly used name of the airport in Boston, MA, USA whose official name is "General Edward Lawrence Logan International Airport". You will actually see the airport code BOS in these queries, but you can verify this by looking at the d_airports table.
