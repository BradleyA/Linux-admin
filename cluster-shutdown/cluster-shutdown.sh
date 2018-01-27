#!/bin/bash
#	cluster-shutdown.sh	1.3	2018-01-26_20:54:12_CST uadmin rpi3b-two.cptx86.com
#	place {} around variables, brain storm many new areas
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
#	ssh $USER@rpi3b-$NODE.$DOMAIN 'sudo shutdown -f now';
#
#	Need to modify script to work from a host list in another file, one per line and supporting comments #
#
#	Another idea would be to have a script;	
#	   maybe use a case statement for each command and include --help to support useage 1) system reboot 2) check if reboot, etc
#		check if eash host requires updates
#		check if each host requires reboot
#
#	XOS host OS:	Ubuntu_14.04.5_LTS / Ubuntu_16.04.3_LTS
#	--`lsb_release -d | awk '{ print $2"_"$3"_"$4 }'`
#	XRELEASE docker release #:	17.12.0-ce / 18.01.0-ce / 17.03.0-ce
#	--`docker version | grep -m 1 Version: |  awk '{ print $2 }'`
#	Processor information
#	--`lshw | grep "^${XHOST}" -A2 | grep product | head -1 | sed -e 's/ /_/g' | sed -e 's/__*/_/g' | sed -e 's/^_product:_//'`
#	Chip Architecture
#	--`lscpu | grep "Architecture" | awk '{ print $2 }'`
#	Number of CPU's
#	--`lscpu | grep "^CPU(s):" | awk '{ print $2 }'`
#		
###
REMOTECOMMAND="shutdown -f now"
DOMAIN="cptx86.com"
LOCALHOST=`hostname -f`
#
for NODE in one two three four five six ; do
	echo ${NODE}-rpi3b.${DOMAIN};
	if [ "${LOCALHOST}" != " ${NODE}-rpi3b.${DOMAIN}" ]; then
		ssh -tt ${USER}@${NODE}-rpi3b.${DOMAIN} 'stty raw -echo;sudo shutdown -f now';
	fi
done
echo "${LOCALHOST}"
sudo ${REMOTECOMMAND}
###
#
#
###
#	NOTES:	check if eash host requires updates
#	===>
#	/usr/lib/update-notifier/apt-check 
#	is actually equivalent to stats returned by
#	apt-get -s dist-upgrade | grep "^[[:digit:]]\+ upgraded"
#	and not
#	apt-get upgrade|grep "^[[:digit:]]\+ upgraded"
#	For Example
#	/usr/lib/update-notifier/apt-check --human-readable
#	returns
#	22 packages can be updated.
#	0 updates are security updates.
#	whereas
#	apt-get -s dist-upgrade | grep "^[[:digit:]]\+ upgraded"
#	returns
#	18 upgraded, 4 newly installed, 0 to remove and 0 not upgraded.
#	It actually 18+4 which amounts to 22.
#	From apt-get manual:
#	upgrade
#	       upgrade is used to install the newest versions of all packages        currently installed on the system from the sources enumerated in        /etc/apt/sources.list. Packages currently installed with new        versions available are retrieved and upgraded; under no        circumstances are currently installed packages removed, or packages        not already installed retrieved and installed. New versions of        currently installed packages that cannot be upgraded without        changing the install status of another package will be left at        their current version. An update must be performed first so that        apt-get knows that new versions of packages are available.
#	   dist-upgrade
#	       dist-upgrade in addition to performing the function of upgrade,        also intelligently handles changing dependencies with new versions        of packages; apt-get has a "smart" conflict resolution system, and        it will attempt to upgrade the most important packages at the        expense of less important ones if necessary. So, dist-upgrade        command may remove some packages. The /etc/apt/sources.list file        contains a list of locations from which to retrieve desired package        files. See also apt_preferences(5) for a mechanism for overriding        the general settings for individual packages.
#	
###
#	NOTES:	check if each host requires reboot
#	==>  apt-get reboot
#	You can simply check if the file /var/run/reboot-required exists or not.
#	
#	For example, any of these would tell you "no such file" or "file not found" if you do not need to reboot, otherwise (if you need to reboot) the file would exist and these commands would show information about the file:
#	file /var/run/reboot-required
#	stat /var/run/reboot-required
#	ls /var/run/reboot-required
#	In a bash script, you can use:
#	#!/bin/bash
#	if [ -f /var/run/reboot-required ]; then
#	  echo 'reboot required'
#	fi
#	alias rr='if [ -f /var/run/reboot-required ]; then echo "reboot required"; else echo "No reboot needed"; fi'
#	root@two:/etc/docker/certs.d# file /var/run/reboot-required
#	/var/run/reboot-required: diff output, ASCII text
#	root@two:/etc/docker/certs.d# cat /var/run/reboot-required
#	*** System restart required ***
#	root@two:/etc/docker/certs.d# file /var/run/reboot-required.pkgs
#	/var/run/reboot-required.pkgs: ASCII text
#	root@two:/etc/docker/certs.d# cat  /var/run/reboot-required.pkgs
#	l
#	root@two:/etc/docker/certs.d# ls -l /var/run/reboot-required.pkgs /var/run/reboot-required.pkgs
#	-rw-r--r-- 1 root root 6 Jan 17 06:43 /var/run/reboot-required.pkgs
#	-rw-r--r-- 1 root root 6 Jan 17 06:43 /var/run/reboot-required.pkgs
#
