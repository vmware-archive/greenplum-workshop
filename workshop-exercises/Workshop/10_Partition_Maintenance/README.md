# Offload a Partition to a Flat File

The scenario for this exercise is that we have already dumped (or COPYed) old data from a partitioned table into a flat file (2009June_otp.dat).
The goal is to illustrate the partition maintenance task of moving old data out of Greenplum to longer term storage (NFS file system, Hadoop, Amazon S3, etc) but still allow SQL access to that data from the partitioned table. So here we are going to create a readable external table and exchange it with an existing partition.

The second part of this maintenance task would be to load new data into Greenplum and add it to the partitioned table. This can be considered extra credit.

Files in this directory:
* 01_create_ext_tbl.sql - Creates the external table
* 02_exchange_parts.sql - Exchanges the partition for June 2009 with the external table.
* 03_run_explain.sql - Run EXPLAIN for a simple SELECT against our table
* 04_show_partitions.sql - Show details on our partitioned table
* 2009_June_otp.dat - Data file we "dumped" from the partitioned table otp_r
* runme.sh - Start gpfdist and run the 0?.sql files.
* showme.sh - View the SQL files.
* show_partitions.sql - Show the partition range values for the otp_r table.
