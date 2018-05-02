# Greenplum 5 Workshop

This is a set of scripts and utilities to quickly install and configure a workshop/demo environment for the Pivotal Greenplum Analytic database. To highlight a few of Greenplum's strengths as an analytical platform, this setup provides an environment for performing advanced text analytics (GPText), machine learning and statistical analysis (Madlib), running advanced Python analytics with the database (PLContainers for Python), and soon geospatial processing (PostGIS).

Before proceeding, here are the base assumptions:
* Greenplum Cluster has been instantiated from Pivotal's Greenplum marketplace offering on Amazon AWS. The current version of scripts has been tested with v2.2 cloud formation scripts.
* Greenplum version is 5.2 or higher
* You have at least 100GB of disk space available

### Directories:
* aws-testing-harness - Cloudformation script and cli calls to create a Greenplum single node server and to delete it when done.
* workshop-exercises - A number of user and dba exercises covering important topics
* workshop-setup - Bash scripts to automate (as much as possible) setting up the workshop environment. See the README.md file in the directory for more information.

### Things to note:
* By default, the Greenplum cloud formation setup in Amazon turns off password authentication. We have turned it back so that the gpuser account can login without requiring an SSH key. It is easier to share a password with participants in a training situation. You should strongly consider turning it off and using SSH key authentication.
* Greenplum Command Center v4.0 is downloaded but not installed. If you decide to install it, please read the installation guide carefully. Since we upgrade GP from 5.2->5.7, you have to make the changes specified here:
http://gpcc.docs.pivotal.io/400/topics/install.html#setup_extensions
