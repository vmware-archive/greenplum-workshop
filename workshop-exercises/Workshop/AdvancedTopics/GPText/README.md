A quick introduction into GPText, Greenplum's highly scalable, highly available full text search engine.
GPText joins the Greenplum Database massively parallel-processing database server with Apache SolrCloud enterprise search and the Apache MADlib Analytics Library to provide large-scale analytics processing and business decision support. GPText includes free text search as well as support for text analysis.

To verify GPText has been installed properly and is currently running, execute the `00_gptext_test_script.sh` shell script.
This script:
* creates a simple two column table (id and data) in schema `test`
* populates it with a few rows of data
* creates, populates, and commits a solr index
* runs a few search queries
* and finally cleans up (drops the index, table, and schema)

If that satisfies your curiosity, then nothing more needs to be done here.

If not, the following set of shell and SQL scripts provide a bit more depth. A large corpus of emails from Enron have been made public and we use a reasonably sized subset as the basis for the rest of this exercise.

The files and their descriptions:
* 01_setup_enron.sh - creates and populates the `enron` table, creates and populates our Solr index, and commits the index
* 01_enron.sql - called from the setup script
* 02_basic_enron_search_queries.sql - performs basic text search queries
* 03_faceted_enron_search_queries.sql - performs faceted search queries
* 99_teardown.sh - drops the index and table

Documentation for the latest release of GPText can be found at http://gptext.docs.pivotal.io
