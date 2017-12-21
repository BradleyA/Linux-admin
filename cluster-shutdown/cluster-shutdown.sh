#!/bin/bash
#	cluster-shutdown.sh	1.2	2017-12-20_22:01:37_CST uadmin rpi3b-two.cptx86.com
#	cleanup script description comment
#	cluster-shutdown.sh	1.0	2017-12-20_21:48:47_CST uadmin rpi3b-two.cptx86.com
#	add version to file from markit
#
#	set -x
#	set -v
#	
#	shutdown raspberry pi clusters
#
REMOTECOMMAND="shutdown -f now"
DOMAIN="cptx86.com"
LOCALHOST=`hostname -f`
#
for NODE in one two three four five six ; do
	echo rpi3b-$NODE.$DOMAIN;
	if [ "$LOCALHOST" != "rpi3b-$NODE.$DOMAIN" ]; then
		ssh -tt $USER@rpi3b-$NODE.$DOMAIN 'stty raw -echo;sudo shutdown -f now';
	fi
done
sudo $REMOTECOMMAND
