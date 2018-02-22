#!/bin/bash
# 	cluster-command.sh	1.5.35	2018-02-22_08:16:57_CST uadmin six-rpi3b.cptx86.com 1.4 
# 	   cluster-command.sh set default location for host file closes #3 
# 	cluster-command.sh	1.3.33	2018-02-21_21:12:39_CST uadmin six-rpi3b.cptx86.com 1.2-2-gde89b7b 
# 	   cluster-shutdown.sh use host list file closes #1 support several commands closes #2 
# 	cluster-command.sh	1.2.30	2018-02-21_13:36:37_CST uadmin six-rpi3b.cptx86.com 1.1 
# 	   comment out x86 hosts so I will not shutdown production cluster during testing; supports #1 
# 	cluster-shutdown.sh	1.0.22	2018-02-21_12:28:36_CST uadmin six-rpi3b.cptx86.com v0.1-21-g8174b37 
# 	   remove comment for enhancements and move to issues in github 
#
#	set -x
#	set -v
#
#	administration cluster comment for Raspberry Pi and x86 clusters
#	   ssh $USER@rpi3b-$NODE.$DOMAIN 'sudo shutdown -f now';
###		
display_help() {
echo -e "\n${0} - remote cluster system adminstration"
echo -e "\nUSAGE\n   ${0} [<options>] [<path>/<hostfile.txt>]"
echo    "   ${0} [--help | -help | help | -h | h | -? | ?] [--version | -v]"
echo -e "\nDESCRIPTION\nRun one command from a set of commands on a group of systems found in cluster-command.txt file."
echo -e "\nOPTIONS "
echo    "   docker-version - docker version | grep -m 1 'Version:'"
echo    "   shutdown - sudo shutdown -f now"
echo    "   reboot - sudo reboot"
echo    "   update - sudo apt-get update"
echo    "   upgrade - sudo apt-get upgrade --assume-yes"
echo    "   dist-upgrade - sudo apt-get dist-upgrade --assume-yes"
echo    "   showhold - apt-mark showhold"
echo    "   OS - lsb_release -d"
echo    "   cpu - lscpu"
echo    "   require-reboot - if [ -f /var/run/reboot-required ]; then echo 'reboot required' ; else echo 'no reboot required' ; fi"
echo    "   require-upgrade - /usr/lib/update-notifier/apt-check --human-readable"
echo    "   upgrade-package - apt-get upgrade --simulate | grep -vE 'Conf|Inst'"
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
#       Check for ${HOSTFILE} file
if [ ! -e ${HOSTFILE} ] ; then
        echo -e "${0} ${LINENO} [WARN]:        ${HOSTFILE} NOT found"   1>&2
        exit 0
fi
REMOTEHOST=`grep -v "#" cluster-command.txt`
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
	echo -e "\n${0} ${LINENO} [INFO]:	${NODE}" ;
	if [ "${LOCALHOST}" != " ${NODE}" ] ; then
		ssh -tt ${USER}@${NODE} ${REMOTECOMMAND} ;
	fi
done
echo -e "\n${0} ${LINENO} [INFO]:	Done.\n"	1>&2
###
