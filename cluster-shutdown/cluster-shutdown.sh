#!/bin/bash
#	%W% %G% %U%
#	set -x
#	set -v
#	ssh $USER@rpi3b-$NODE.$DOMAIN 'sudo shutdown -f now';
REMOTECOMMAND="shutdown -f now"
DOMAIN="cptx86.com"
LOCALHOST=`hostname -f`
#
for NODE in one two three four five six ; do
	echo rpi3b-$NODE.$DOMAIN;
	if [ "$LOCALHOST" != "rpi3b-$NODE.$DOMAIN" ]; then
		ssh $USER@rpi3b-$NODE.$DOMAIN $REMOTECOMMAND;
	fi
done
$REMOTECOMMAND
