<h1> VMware has ended active development of this project, this repository will no longer be updated.</h1><br># Greenplum 5 Workshop

This is a set of scripts and utilities to quickly install and configure a workshop/demo environment for the Pivotal Greenplum Analytic database. To highlight a few of Greenplum's strengths as an analytical platform, this setup provides an environment for performing advanced text analytics (GPText), machine learning and statistical analysis (Madlib), running advanced Python analytics with the database (PLContainers for Python), and soon geospatial processing (PostGIS).

Before proceeding, here are the base assumptions:
* Greenplum version is 5.2 or higher
* You have at least 100GB of disk space available

### Directories:
* workshop-exercises - A number of user and dba exercises covering important topics
* workshop-setup - Bash scripts to automate (as much as possible) setting up the workshop environment. See the README.md file in the directory for more information.
* Slides - PDFs of the overview material.

### Things to note:
* By default, the Greenplum marketplace offerings turn off password authentication. We have turned it back on so that the gpuser account can login without requiring an SSH key. It is easier to share a password with participants in a training situation. You should strongly consider turning it off and using SSH key authentication if you are installing this for personal use.

* This workshop has been tested and verified on the latest (as of Feb 2019) Pivotal Greenplum markeplace offerings on Amazon AWS and Google Cloud.
