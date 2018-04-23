FILES="plcontainer-1.1.0-rhel6-x86_64.gppkg greenplum-text-2.2.1-rhel6_x86_64.tar.gz plcontainer-python-images-1.1.0.tar.gz greenplum-cc-web-4.0.0-LINUX-x86_64.zip jre-8u151-linux-x64.rpm"

SFTWRE=/data4/software
[[ ! -d $SFTWRE ]] && mkdir ${SFTWRE}

for f in $FILES
do
    wget https://s3.amazonaws.com/gp-demo-workshop/$f -O ${SFTWRE}/$f
done

tar xvzf ${SFTWRE}/greenplum-text-2.2.1-rhel6_x86_64.tar.gz -C ${SFTWRE}
