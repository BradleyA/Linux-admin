#!/bin/bash
#	%W% %G% %U%
#	set -x
#	set -v
DOMAIN="cptx86.com"
for NODE in one two three four five six ; do
	echo rpi3b-$NODE.$DOMAIN;
	ssh $USER@rpi3b-$NODE.$DOMAIN 'sudo shutdown -f now';
done
