# Greenplum 5 Workshop Setup Scripts

### Downloading and installing the workshop:
* The stable release can be pulled from the git repository.
  - Using Subversion to retrieve just the workshop-setup folder:
`svn export https://github.com/Pivotal-Data-Engineering/greenplum-workshop/trunk/workshop-setup workshop-setup`
  - Retrieve the entire repository:
`git clone https://github.com/Pivotal-Data-Engineering/greenplum-workshop.git` or
`wget https://github.com/Pivotal-Data-Engineering/greenplum-workshop/archive/master.zip`

* The workshop setup is also available as a TAR archive on S3. We attempt to keep this up to date but it may not be:
`$ wget https://s3.amazonaws.com/gp-demo-workshop/GP-Workshop-Setup.tgz -O GP-Workshop-Setup.tgz` or
`$ curl https://s3.amazonaws.com/gp-demo-workshop/GP-Workshop-Setup.tgz -o GP-Workshop-Setup.tgz`

### Execute the install scripts:
* Login to the master host as gpadmin
* Extract the archive file if needed:
`$ tar xzf $HOME/GP-Workshop-Setup.tgz` or `unzip $HOME/master.zip`
* Change to the workshop-setup directory:
`$ cd ./workshop-setup`
* Execute the `01_run_as_root.sh`, `02_run_as_gpadmin.sh`, `03_run_as_root.sh` scripts in order as follows:
  1. `$ sudo ./01_run_as_root.sh`
    - adds a Linux login account for the workshop user (gpuser) and sets the password
    - installs several utility scripts in /usr/local/bin
    - yum installs required software, and makes changes to the docker install by moving _/var/lib/docker_ to _/data4/var-lib-docker_ and then soft linking back to _/var/lib/docker_. The last step is done because of limited space on the root volume.
  2. `$ ./02_run_as_gpadmin.sh`
    - modifies the `pg_hba.conf` file
    - runs gpupgrade to install the latest GP 5.x release
    - adds the `gpuser` role and database
    - downloads and installs GP packages
      - Madlib : Statistical and machine learning algorithms exposed as UDFs
      - GPText : Advanced text processing via Solr integration
      - PLContainers : Docker containers for running Python or R
    - restarts the database
  3. `$ sudo ./03_run_as_root.sh`
    - Configure the demo environment for the gpuser role.
    - Adds a `$HOME/.psqlrc` file for gpuser
    - downloads the FAA ontime data files from a public S3 bucket and stores the files in a subdirectory of /data4
    - downloads and extracts the workshop exercises in gpuser's home directory

### Things to note:
* If you downloaded from the git repository (either cloned or downloaded zip), you can move the `workshop-exercises` directory to `/home/gpuser`. However, it is not necessary since the third step above will download and install the exercises.
* By default, the Greenplum cloud formation setup in Amazon turns off password authentication. We have turned it back so that the gpuser account can login without requiring an SSH key. It is easier to share a password with participants in a training situation. You should strongly consider turning it off and using SSH key authentication.
* Greenplum Command Center v4.x is downloaded but not installed. If you decide to install it, please read the installation guide carefully. Since we upgrade GP from 5.2->5.latest, you have to make the changes specified here:
`http://gpcc.docs.pivotal.io/400/topics/install.html#setup_extensions`
