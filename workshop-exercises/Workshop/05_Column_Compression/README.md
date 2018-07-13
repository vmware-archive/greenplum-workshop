The fact table produced so far is row oriented.  That is, the server collects groups of rows and places them in blocks in the file system.  This is a standard practice in many databases.  But for some purposes, it is more efficient to store the table in a columnar fashion.  This is useful in very wide tables where typical queries only return a small set of the columns as it minimizes the number of I/O operations.  Columnar data is also capable of greater compression.

In this exercise, the SQL files will produce the same data as in the otp_r version of the file -- the row oriented version -- but with different compression schemes and with columnar orientation.  The exercises will also run the same basic "delay from Logan" query.

You should note that compression IN THIS CASE (your mileage will vary), may or may not affect run time, but it should diminish disk space.  Also, ZLIB level 9 compression takes considerably longer for little gain in disk savings or run time for the standard query.

This material is covered in greater detail in the Greenplum Database Best Practices Guide.
