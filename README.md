# Greenplum 5 Workshop

This is a set of scripts and utilities to quickly install and configure a workshop/demo environment for the Pivotal Greenplum Analytic database. To highlight a few of Greenplum's strengths as an analytical platform, this setup provides an environment for performing advanced text analytics (GPText), machine learning and statistical analysis (Madlib), running advanced Python analytics with the database (PLContainers for Python), and soon geospatial processing (PostGIS).

Before proceeding, here are the base assumptions:
* Greenplum Cluster has been instantiated from Pivotal's Greenplum marketplace offering on Amazon AWS. The current version of scripts has been tested with v2.2 cloud formation scripts.
* Greenplum version is 5.2 or higher
* You have at least 100GB of disk space available

### Here's how to download and run the scripts:
* Login to the master host as gpadmin
* Download the current scripts tar ball from S3:
`$ wget https://s3.amazonaws.com/gp-demo-workshop/GP-Workshop-Setup.tgz -O GP-Workshop-Setup.tgz`
* Extract the compressed tar file:
`$ tar xzf $HOME/GP-Workshop-Setup.tgz`
* Change to the workshop-setup directory:
`$ cd ./workshop-setup`
* Execute the 01-03* scripts:
  * `$ sudo ./01_run_as_root.sh`
    - adds a Linux login account for the workshop user (gpuser) and sets the password
    - installs several utility scripts in /usr/local/bin
    - yum installs required software, and makes changes to the docker install by moving _/var/lib/docker_ to _/data4/var-lib-docker_ and then soft linking back to _/var/lib/docker_. The last step is done because of limited space on the root volume.
  * `$ ./02_run_as_gpadmin.sh`
    - modifies the pg_hba.conf file
    - runs gpupgrade to install GP 5.7
    - adds the gpuser role and database
    - downloads and installs GP packages (Madlib, GPText, PLContainers)
    - restarts the database
  * `$ sudo ./03_run_as_root.sh`
    - Configure the demo environment for the gpuser role.
    - Adds a .psqlrc file for gpuser
    - downloads the FAA ontime data files from a public S3 bucket and stores the files in a subdirectory of /data4
    - downloads and extracts the workshop exercises in gpuser's home directory

### Things to note:
* By default, the Greenplum cloud formation setup in Amazon turns off password authentication. We have turned it back so that the gpuser account can login without requiring an SSH key. It is easier to share a password with participants in a training situation. You should strongly consider turning it off and using SSH key authentication.
* Greenplum Command Center v4.0 is downloaded but not installed. If you decide to install it, please read the installation guide carefully. Since we upgrade GP from 5.2->5.7, you have to make the changes specified here:
http://gpcc.docs.pivotal.io/400/topics/install.html#setup_extensions
