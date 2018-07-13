Creating tables in the Pivotal Greenplum Database is much like any other SQL database with one important difference. In MPP "shared nothing" databases the rows of the table are distributed across the cluster shards (referred to as segments in Greenplum).

Distributing the data correctly is an important consideration in query performance.  It is critical to distribute the data evenly across the segments.  Since an MPP database waits until all the segments have completed their work, if one of the segments has a disproportionate number of rows, the other segments will finish more quickly and the process waits for the lagging segment.

Greenplum provides two methods for distributing data: random and hash of a user defined key. Smaller tables can be distributed randomly. For larger tables, especially those frequently joined to other tables, the recommendation is to distribute on the join columns. This minimizes the amount of data that must be transferred between segments. This is not an exact science and often requires some amount of experimentation to get near optimal performance.  

More information about distribution can be found in the Pivotal Greenplum Database Best Practices Guide.
