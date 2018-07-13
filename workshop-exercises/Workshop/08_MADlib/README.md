MADlib (MAD = Magnetic Agile Deep) is an open source set of analytic routines that are optimized to run in the Pivotal Greenplum Database.  The routines encompass a large set of Machine Learning tools that Data Scientists and Analysts use frequently.  In addition, they often use programs in Python and R that can be downloaded and used in conjunction with PL/Python and PL/R to broaden the toolset.

In this small set of exercises, first compute some statistics using built-in functions, then use the madlib "summary" function.  Next we perform some linear regressions to try and predict if the flight length or the departure delay are good predictors of arrival delay.  This is not a statistics primer.  If you run the regressions, remember your Statistics 101 a bit, and read the madlib documentation, you'll better understand the examples. 

Documentationn is available at http://doc.madlib.net/latest/

If you are interested in the birth of this project:
http://vldb.org/pvldb/vol5/p1700_joehellerstein_vldb2012.pdf
