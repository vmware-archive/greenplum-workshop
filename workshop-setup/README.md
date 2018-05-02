# Greenplum 5 Workshop Setup Scripts

### Two ways to download the scripts:
* The most stable version is available as a TAR archive on S3:
`$ wget https://s3.amazonaws.com/gp-demo-workshop/GP-Workshop-Setup.tgz -O GP-Workshop-Setup.tgz`
* Clone this repository via `git clone https://github.com/Pivotal-Data-Engineering/greenplum-workshop.git` or `wget https://github.com/Pivotal-Data-Engineering/greenplum-workshop/archive/master.zip`

### Here's how to download and run the scripts:
* Login to the master host as gpadmin
* Extract the archive file if needed:
`$ tar xzf $HOME/GP-Workshop-Setup.tgz` or `unzip $HOME/master.zip`
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
* If you downloaded from the git repository (either cloned or downloaded zip), move the `workshop-exercises` directory to `/home/gpuser`
* By default, the Greenplum cloud formation setup in Amazon turns off password authentication. We have turned it back so that the gpuser account can login without requiring an SSH key. It is easier to share a password with participants in a training situation. You should strongly consider turning it off and using SSH key authentication.
* Greenplum Command Center v4.0 is downloaded but not installed. If you decide to install it, please read the installation guide carefully. Since we upgrade GP from 5.2->5.7, you have to make the changes specified here:
http://gpcc.docs.pivotal.io/400/topics/install.html#setup_extensions
