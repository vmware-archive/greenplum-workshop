Partitioning data is often confused with distributing data.  Distribution physically assigns rows to segments throughout the cluster to facilitate parallel processing and is a way to horizontally spread the data. Data is distributed in one of two ways:
 1. A hash function is used to determine which row belongs to which segment, or
 2. A random distribution is used if a good distribution key cannot be determined.

Partitioning is dividing a table's rows in each segment into different files and can be thought of as vertically distributing the data.
There are several advantages to partitioning large tables but the main advantage is partition pruning. Partition pruning is where the optimizer eliminates the scanning one or more partitions (this can greatly reduce IO), usually by a WHERE clause filter on the columns used in partitioning (i.e, `WHERE order_date BETWEEN '2015-12-15' and '2015-12-31'`).

Very often partitioning is done using temporal data (TIMESTAMP, DATE, etc).
In these examples, each partition will hold data for a particular week or month.
Thus if the WHERE clause specifies only a small date range, the optimizer will not scan partitions which hold no relevant data for the query.
Note that in this exercise, we include a DEFAULT partition for rows that do not fall within the partitioned range.  In general, this is bad practice because DEFAULT partitions do not participate in partition pruning, meaning they are always scanned regardless of the WHERE filter.

Date range partitioning is also used in maintenance operations, in what are called sliding or moving windows.  When data becomes old (or stale), dropping a partition is much more efficient then deleting rows. Similarly, data can be added to a new table and that table can then be added as a partition to the fact table.  This allows ELT operations on new data without affecting the existing data.

Partitions are either row or column oriented. Partitioned tables can contain a mix of the two.  Often newer data is kept in row oriented partitions for ease of update operations and after a freeze date, the partition's data can be converted to a compressed columnar format. 

More details are available in the Best Practices Guide.
