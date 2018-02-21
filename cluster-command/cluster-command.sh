#!/bin/bash
# 	cluster-shutdown.sh	1.0.22	2018-02-21_12:28:36_CST uadmin six-rpi3b.cptx86.com v0.1-21-g8174b37 
# 	   remove comment for enhancements and move to issues in github 
#	cluster-shutdown.sh	1.3	2018-01-26_20:54:12_CST uadmin rpi3b-two.cptx86.com
#	place {} around variables, brain storm many new areas
#
#	set -x
#	set -v
#
#	shutdown raspberry pi clusters
#	   ssh $USER@rpi3b-$NODE.$DOMAIN 'sudo shutdown -f now';
###		
display_help() {
echo -e "\n${0} - shutdown system in clusters"
echo -e "\nUSAGE\n   ${0}"
echo    "   ${0} [--help | -help | help | -h | h | -? | ?] [--version | -v]"
echo -e "\nDESCRIPTION\nsudo shutdown -f now"
echo -e "\nOPTIONS "
echo -e "\nDOCUMENTATION\n   https://github.com/BradleyA/pi-scripts/tree/master/cluster-shutdown"
echo -e "\nEXAMPLES\n   Shutdown raspberry pi clusters\n\t${0}\n"
}
if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] || [ "$1" == "?" ] ; then
        display_help
        exit 0
fi
if [ "$1" == "--version" ] || [ "$1" == "-v" ] ; then
        head -2 ${0} | awk {'print$2"\t"$3'}
        exit 0
fi
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
