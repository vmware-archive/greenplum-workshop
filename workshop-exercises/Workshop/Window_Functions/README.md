According to the Postgres documentation, "A window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. But unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row — the rows retain their separate identities."

In this example, we will compute, for each flight from BOS on a particular day, the average delay to 4 destination airports.

We will compute the longest delay for each destination for flights originating from Boston during the month of November 2009.

Window functions are very useful and very powerful.  The examples here are just an introduction to their power.  To make it easier to see, look only at a small number of rows in the table.  All the flights from Manchester NH  on a single day, 3 Jan 2010.  What we want to determine is if the departure delay of each flight differed from the average departure delay for all flights on that day.  The window is the set of 36 flights that departed on that day from Manchester.  The window functions computes depdelay - avg(depdelay) where flightdate= 2010-01-03 and origin = MHT.
