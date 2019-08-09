# Greenplum 5 Workshop Setup using Ansible

A set of Ansible roles and playbooks for installing the Greenplum workshop. Note that it is assumed Greenplum has been configured and initialized and that the version is 5.x.

### Downloading and installing the workshop:
* The stable release can be pulled from the git repository.
  - Using Subversion to retrieve just the Ansible playbooks folder:\
`svn export https://github.com/Pivotal-Data-Engineering/greenplum-workshop/trunk/workshop-setup-ansible workshop-setup-ansible`
  - Retrieve the entire repository:\
`git clone https://github.com/Pivotal-Data-Engineering/greenplum-workshop.git`\
or\
`wget https://github.com/Pivotal-Data-Engineering/greenplum-workshop/archive/master.zip`

* The workshop setup is also available as a TAR archive on S3. We attempt to keep this up to date but it may not be:
  - `wget https://s3.amazonaws.com/gp-demo-workshop/GP-Workshop-Setup.tgz -O GP-Workshop-Setup.tgz` or
  - `curl https://s3.amazonaws.com/gp-demo-workshop/GP-Workshop-Setup.tgz -o GP-Workshop-Setup.tgz`

### Execute the Ansible playbooks:
* Install Ansible on the workstation you will use to run the playbooks.
* Extract the archive file if needed:
  - `tar xzf GP-Workshop-Setup.tgz` or
  - `unzip master.zip`
* Change to the correct directory:
  - `cd greenplum-workshop-master/workshop-setup-ansible/install_gp_workshop`  or
  - `cd ./workshop-set-ansible/install_gp_workshop`
* Configure the `inventory` file:
  - The example file provided sub-divides the hosts into whether they are running in Amazon AWS or Google GCP.
  The associated SSH connection parameters are also provided. This format is not required and can be changed based on
  your needs.
* To run the playbooks, execute the following:
  - `ansible-playbook -i inventory install-greenplum-workshop.yml`
  - This will create the necessary Greenplum user account and database,
    install the packages required for the workshop (madlib, postgis),
    make the necessary changes to the `pg_hba.conf` authentication file,
    and download the exercises and data for the workshop.
    By default we do not install or configure GPText.
* Optional - Installing GPText:
  - If you know beforehand you want to run GPText exercises, you need to specify the correct tags (`all` and `never`)
    - `ansible-playbook -i inventory install-greenplum-workshop.yml --tags="all,never"`
  - If you already ran the playbook, rerun and specify the tag `never`
    - `ansible-playbook -i inventory install-greenplum-workshop.yml --tags="never"`

### Things to note:
* It is assumed that Greenplum 5.x has been installed, configured, and started.
* By default, the Greenplum cloud marketplace setups turn off password authentication. We have turned it back on so the gpuser account can login without requiring an SSH key. It is easier to share a password with participants in a training situation. You should strongly consider turning it off and using SSH key authentication if you don't have this need.
