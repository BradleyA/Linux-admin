#!/bin/bash
# 	cluster-command.sh	1.7.40	2018-02-22_12:33:17_CST uadmin six-rpi3b.cptx86.com 1.6-3-g5675629 
# 	   cluster-command stop ssh for local host closes #7 
# 	cluster-command.sh	1.6.36	2018-02-22_08:59:07_CST uadmin six-rpi3b.cptx86.com 1.5 
# 	   cluster-command complete display-help closes #4 
# 	cluster-command.sh	1.5.35	2018-02-22_08:16:57_CST uadmin six-rpi3b.cptx86.com 1.4 
# 	   cluster-command.sh set default location for host file closes #3 
#
#	set -x
#	set -v
#
#	administration cluster comment for Raspberry Pi and x86 clusters
#	   ssh $USER@rpi3b-$NODE.$DOMAIN 'sudo shutdown -f now';
###		
display_help() {
echo -e "\n${0} - remote cluster system adminstration tool"
echo -e "\nUSAGE\n   ${0} [<options>] [<path>/<hostfile.txt>]"
echo    "   ${0} [--help | -help | help | -h | h | -? | ?] [--version | -v]"
echo -e "\nDESCRIPTION\nThis script runs a command from a set of predefined commands on hosts."
echo    "The hostnames of the hosts are found in a file with one hostname per line."
echo    "Lines in this file that begin with a # are comments.  The defualt"
echo    "location for this cluster command host file, cluster-command.txt, is"
echo    "/usr/local/bin.  A different path and cluster command host file can be"
echo    "entered on the command line as the second argument."
echo -e "\nOPTIONS "
echo    "   List of predefind commands:"
echo    "      docker-version - docker version | grep -m 1 'Version:'"
echo    "      shutdown       - sudo shutdown -f now"
echo    "      reboot         - sudo reboot"
echo    "      update         - sudo apt-get update"
echo    "      upgrade        - sudo apt-get upgrade --assume-yes"
echo    "      dist-upgrade   - sudo apt-get dist-upgrade --assume-yes"
echo    "      showhold       - apt-mark showhold"
echo    "      OS             - lsb_release -d"
echo    "      cpu            - lscpu"
echo    "      require-reboot - if [ -f /var/run/reboot-required ]; then echo 'reboot"
echo    "                       required' ; else echo 'no reboot required' ; fi"
echo    "      require-upgrade - /usr/lib/update-notifier/apt-check --human-readable"
echo    "      upgrade-package - apt-get upgrade --simulate | grep -vE 'Conf|Inst'"
echo    "   hostfile - default /usr/local/bin/cluster-command.txt"
echo -e "\nDOCUMENTATION\n   https://github.com/BradleyA/pi-scripts/tree/master/cluster-command"
echo -e "\nEXAMPLES\n   Shutdown raspberry pi clusters\n\t${0} shutdown\n"
}
if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] || [ "$1" == "?" ] ; then
        display_help
        exit 0
fi
if [ "$1" == "--version" ] || [ "$1" == "-v" ] ||  [ "$1" == "version" ]  ; then
        head -2 ${0} | awk {'print$2"\t"$3'}
        exit 0
fi
###
#	execpt only commands in case statement
REMOTECOMMAND=${1:-""}
#	open issues :add argument or flag argument for a single host and not use cluster-command.txt file to execute a new command or a commad defined in this file
HOSTFILE=${2:-"/usr/local/bin/cluster-command.txt"}
LOCALHOST=`hostname -f`
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
#       Check for ${HOSTFILE} file
if [ ! -e ${HOSTFILE} ] ; then
        echo -e "${0} ${LINENO} [WARN]:        ${HOSTFILE} NOT found"   1>&2
        exit 0
fi
REMOTEHOST=`grep -v "#" ${HOSTFILE}`
###
case ${REMOTECOMMAND} in
	docker-version)
		REMOTECOMMAND="docker version | grep -m 1 'Version:'"
		;;
	shutdown)
		REMOTECOMMAND="sudo shutdown -f now"
		;;
	reboot)
		REMOTECOMMAND="sudo reboot"
		;;
	update)
		REMOTECOMMAND="sudo apt-get update"
		;;
	upgrade)
		REMOTECOMMAND="sudo apt-get upgrade --assume-yes"
		;;
	dist-upgrade)
		REMOTECOMMAND="sudo apt-get dist-upgrade --assume-yes"
		;;
	showhold)
		REMOTECOMMAND="apt-mark showhold"
		;;
	OS|os)
		REMOTECOMMAND="lsb_release -d"
		;;
	CPU|cpu)
		REMOTECOMMAND="lscpu"
		;;
	require-reboot)
		REMOTECOMMAND="if [ -f /var/run/reboot-required ]; then echo 'reboot required' ; else echo 'no reboot required' ; fi"
		;;
	require-upgrade)
		REMOTECOMMAND="/usr/lib/update-notifier/apt-check --human-readable"
		;;
	upgrade-package)
		REMOTECOMMAND="apt-get upgrade --simulate  | grep -vE 'Conf|Inst'"
		;;
	*)
		echo -e "\n${0} ${LINENO} [INFO]:	Command missing  ${FILE_NAME}"
		exit 0
		;;
esac
#
for NODE in ${REMOTEHOST} ; do
	echo -e "\n${BOLD}  -->  ${NODE}${NORMAL}" 
#	Check if host is online ?
	if [ "${LOCALHOST}" != "${NODE}" ] ; then
		ssh ${USER}@${NODE} ${REMOTECOMMAND} 
	else
		echo $(eval $REMOTECOMMAND)
	fi
done
echo -e "\n${0} ${LINENO} [INFO]:	Done.\n"	1>&2
###
