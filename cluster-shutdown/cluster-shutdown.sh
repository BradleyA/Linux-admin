#!/bin/bash
#	%W% %G% %U%
#	set -x
#	set -v
for NODE in one two three four five six ; do
	echo rpi3b-$NODE;
	ssh $USER@rpi3b-$NODE.cptx86.com 'sudo shutdown -f now';
done
