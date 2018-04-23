#!/bin/bash
INSTALL_DIR="/opt/pivotal/greenplum"
source $INSTALL_DIR/variables.sh
tmpdir=/tmp/greenplum_upgrade

#UPGRADE="$1"
UPGRADE=true
script="gpupgrade"

this_host=$(hostname -s)
who=$(whoami)

set -e

info()
{
	
	msg="$1"
	now=$(date +%Y%m%d:%H:%M:%S:%6N)
	echo "$now $script:$this_host:$who-[INFO]:-$1"
}
error()
{
	msg="$1"
	now=$(date +%Y%m%d:%H:%M:%S:%6N)
	echo "$now $script:[ERROR]:-$1"
	exit 1
}
checks()
{
	if [ "$UPGRADE" == "" ]; then
		error "You must provide true or false to upgrade the Greenplum version."
	fi
	if ! [[ "$UPGRADE" == "true" || "$UPGRADE" == "false" ]]; then
		error "Invalid UPGRADE parameter: \"$UPGRADE\"."
	fi
	count=$(psql -t -A -c "select count(*) from gp_segment_configuration where role <> preferred_role or status <> 'u'")
	if [ "$count" -ne "0" ]; then
		error "One or more nodes needs recovery.  Exiting..."
	fi
	if [ ! -f /home/gpadmin/all_hosts.txt ]; then
		error "Unable to find /home/gpadmin/all_hosts.txt!"
	fi
}
start_database()
{
	count=$(psql -t -A -c "select version();" 2> /dev/null | wc -l)
	if [ "$count" -ne "1" ]; then
		info "Start database."
		gpstart -a
	fi
	pgbdir="/data1/master/gpseg-1/pgbouncer"
	pgb_pid=$(ps -ef | grep pgbouncer | grep -v grep | awk -F ' ' '{print $2}' | head -n1)
	if [ "$pgb_pid" == "" ]; then
		info "Starting pgbouncer."
		pgbouncer -d $pgbdir/pgbouncer.ini
	fi
	info "Database is ready to accept connections."
}
stop_database()
{
	info "Stop database."
	gpstop -a -M fast || true
	pgb_pid=$(ps -ef | grep pgbouncer | grep -v grep | awk -F ' ' '{print $2}' | head -n1)
	if [ "$pgb_pid" != "" ]; then
		info "Stopping pgbouncer."
		kill $pgb_pid
	fi
	info "Database stopped."
}
get_version()
{
	#Get current version details
	current_version=$(psql -t -A -c "select split_part(split_part(version(), 'Greenplum Database ', 2), ' build', 1)")
	info "Current Version: $current_version"

}
get_control_file()
{
	curl -s https://s3.amazonaws.com/gp-demo-workshop/control.txt > $tmpdir/control.txt
	if [ ! -f $tmpdir/control.txt ]; then
		error "Unable to get control file from S3 bucket!"
	fi
}
upgrade_database()
{
	#control file header
	#CURRENT_VERSION|UPGRADE_VERSION|UPGRADE_BINARY

	upgrade_available="0"
	#if there are multiple upgrade versions, pick the last one (latest)
	#skip first line which is the file header
	for i in $(grep $current_version $tmpdir/control.txt); do
		control_current_version=$(echo $i | awk -F '|' '{print $1}')
		upgrade_version=$(echo $i | awk -F '|' '{print $2}')
		upgrade_binary=$(echo $i | awk -F '|' '{print $3}')
		if [[ "$current_version" == "$control_current_version" ]]; then
			upgrade_available="1"
		fi
	done
	if [ "$upgrade_available" -eq "1" ]; then
		if [ "$UPGRADE" == "true" ]; then
			curl -s https://s3.amazonaws.com/gp-demo-workshop/$upgrade_binary > $tmpdir/$upgrade_binary

			# upgrade the database
			for i in $(cat /home/gpadmin/all_hosts.txt); do
				echo "scp $tmpdir/$upgrade_binary $i:/home/gpadmin/"
				scp $tmpdir/$upgrade_binary $i:/home/gpadmin/
			done

			stop_database

			#remove symbolic link, install new rpm, change ownership to gpadmin
			info "Installing rpm on all hosts.  This may take a while."
			gpssh -f /home/gpadmin/all_hosts.txt -e "sudo rm -f /usr/local/greenplum-db; sudo rpm -i /home/gpadmin/$upgrade_binary; sudo chown -R gpadmin:gpadmin /usr/local/greenplum-db*"

			start_database

			old_msg="Version: ""$current_version"
			new_msg="Version: ""$upgrade_version"
			cp /etc/motd $tmpdir
			sed -i "s/$old_msg/$new_msg/" $tmpdir/motd 
			sed -i "/New Greenplum version/ d" $tmpdir/motd
			sudo cp $tmpdir/motd /etc/motd
		else
			info "New version $upgrade_version available."
			cp /etc/motd $tmpdir
			count=$(grep "New Greenplum version" $tmpdir/motd | wc -l)
			if [ "$count" -eq "0" ]; then
				info "Update MOTD"
				echo "**** New Greenplum version is available. Run \"gpupgrade\" to upgrade. ****" >> $tmpdir/motd
				sudo cp $tmpdir/motd /etc/motd
			fi
		fi
	fi
}
rm -rf $tmpdir
mkdir -p $tmpdir

start_database
get_version
checks
get_control_file
upgrade_database
if [[ "$upgrade_available" -eq "1" && "$UPGRADE" == "true" ]]; then
	get_version
	info "Database successfully upgraded!"
fi
