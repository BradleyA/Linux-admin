#!/bin/bash
# 	cluster-command.sh  2.06.115  2018-08-19_18:14:56_CDT  https://github.com/BradleyA/Linux-admin  uthree  three.cptx86.com 2.05-2-ge7edc34  
# 	   updated --help 
# 	cluster-command/cluster-command.sh  2.02.109  2018-08-15_16:08:28_CDT  https://github.com/BradleyA/Linux-admin  uadmin  three-rpi3b.cptx86.com 2.01  
# 	   add # of upgrades requirted after apt-get update 
# 	cluster-command.sh  2.00.107  2018-08-10_14:54:54_CDT  https://github.com/BradleyA/Linux-admin  uadmin  three-rpi3b.cptx86.com 1.21  
# 	   remote -p 22 because ssh port number is controlled by ~/.ssh/config file 
###
#	administration cluster commands for Raspberry Pi and x86 clusters
#	   ssh $USER@$NODE-rpi3b.$DOMAIN 'sudo shutdown -f now';
###
DEBUG=0                 # 0 = debug off, 1 = debug on
#	set -x
#	set -v
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
###		
display_help() {
echo -e "\n${NORMAL}${0} - remote cluster system adminstration tool"
echo -e "\nUSAGE\n   ${0} [<PREDEFINED-COMMAND>] [<path>/<HOSTFILE>]"
echo    "   ${0} [--help | -help | help | -h | h | -? | ?]"
echo    "   ${0} [--version | -version | -v]"
echo -e "\nDESCRIPTION\nThis script runs a command from a set of predefined commands on hosts."
echo    "The hostnames of the hosts are found in a file with one FQDN or IP address per"
echo    "line for all hosts in a cluster.  Lines in SYSTEMS file that begin with a # are"
echo    "comments.  The defualt location for this cluster command host file, SYSTEMS, is"
echo    "/usr/local/data/us-tx-cluster-1/SYSTEMS.  The SYSTEMS file is used by"
echo    "Linux-admin/cluster-command.sh & pi-display/create-message.sh.  A different"
echo    "path and cluster command host file can be entered on the command line as the"
echo    "second argument."
echo -e "\nOPTIONS "
echo    "   PREDEFINED-COMMAND"
echo    "      shutdown       - sudo shutdown -f now"
echo -e "      reboot         - sudo reboot\n"
echo    "      os             - lsb_release -d"
echo    "      cpu            - lscpu"
echo    "      date           - date"
echo    "      df             - df"
echo    "      last           - lastlog | grep -v '**Never logged in**'"
echo    "      who            - who"
echo    "      ip             - ip a"
echo    "      netstat        - sudo netstat -natup"
echo -e "      uptime         - uptime\n"
echo    "      docker-version - docker version | grep -m 1 'Version:'"
echo    "      docker-release - grep docker /etc/apt/sources.list"
echo    "      docker-df      - docker system df"
echo    "      docker-df-v    - docker system df --verbose"
echo    "      docker-info    - docker system info | head -6"
echo    "      ls-docker-con  - docker container ls"
echo    "      ls-docker-ima  - docker images"
echo    "      ls-docker-net  - docker network ls"
echo    "      ls-docker-vol  - docker volume ls"
echo    "      clean-docker-ima	- docker image rm \$(docker image ls --filter='dangling=true' -q)"
echo    "      clean-docker-vol	- docker volume rm \$(docker volume ls --filter dangling=true -q)"
echo    "      prune-docker-net	- docker network prune"
echo    "      prune-docker-vol	- docker volume prune"
echo -e "      prune-docker-all	- docker system prune\n"
echo    "      showhold       - apt-mark showhold\n"
echo    "      update         - sudo apt-get update ;"
echo    "                       /usr/lib/update-notifier/apt-check --human-readable"
echo    "      upgrade        - sudo apt-get upgrade --assume-yes ;"
echo    "                       if [ -f /var/run/reboot-required ] ; then"
echo    "                       echo 'reboot required' ; else"
echo    "                       echo 'no reboot required' ; fi"
echo    "      dist-upgrade   - sudo apt-get dist-upgrade --assume-yes"
echo    "      autoremove     - sudo apt-get autoremove --assume-yes"
echo    "      require-reboot - if [ -f /var/run/reboot-required ]; then echo 'reboot"
echo    "                       required' ; else echo 'no reboot required' ; fi"
echo    "      require-upgrade - /usr/lib/update-notifier/apt-check --human-readable" # >>> not sure this is the correct command becasue one-rpi3b stated no upgrade but then did eight upgrades
echo    "      upgrade-package - apt-get upgrade --simulate | grep -vE 'Conf|Inst'"
echo    "                        apt list --upgradeable -> does not work on Ubuntu 14.04"
echo -e "\nOPTIONS\n"
echo    " >>>  REMOTECOMMAND   >>> this does not work, requires more design and testing"
echo    " >>>  HOSTFILE        >>> File with hostnames, default /usr/local/data/us-tx-cluster-1/SYSTEMS"
echo -e "\nDOCUMENTATION\n   https://github.com/BradleyA/pi-scripts/tree/master/cluster-command"
echo -e "\nEXAMPLES\n   Shutdown raspberry pi clusters\n\t${0} shutdown\n"
if ! [ "${LANG}" == "en_US.UTF-8" ] ; then
        echo -e "${NORMAL}${0} ${LINENO} [${BOLD}WARNING${NORMAL}]:     Your language, ${LANG}, is not supported.\n\tWould you like to help?\n" 1>&2
fi
}
if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] || [ "$1" == "?" ] ; then
        display_help
        exit 0
fi
if [ "$1" == "--version" ] || [ "$1" == "-version" ] || [ "$1" == "version" ] || [ "$1" == "-v" ] ; then
        head -2 ${0} | awk {'print$2"\t"$3'}
        exit 0
fi
###
#	execpt only commands in case statement
REMOTECOMMAND=${1:-""}
#	open issues :add argument or flag argument for a single host and not use SYSTEMS file to execute a new command or a commad defined in this file
HOSTFILE=${2:-"/usr/local/data/us-tx-cluster-1/SYSTEMS"}
LOCALHOST=`hostname -f`
if [ "${DEBUG}" == "1" ] ; then echo -e "> DEBUG ${LINENO}  REMOTECOMMAND <${REMOTECOMMAND}< HOSTFILE >${HOSTFILE}<" 1>&2 ; fi
#       Check for ${HOSTFILE} file
if [ ! -e ${HOSTFILE} ] ; then
        echo -e "${0} ${LINENO} [WARN]:        ${HOSTFILE} NOT found"   1>&2
        exit 0
fi
REMOTEHOST=`grep -v "#" ${HOSTFILE}`
###
case ${REMOTECOMMAND} in
	shutdown)
		REMOTECOMMAND="sudo shutdown -f now"
		;;
	reboot)
		REMOTECOMMAND="sudo reboot"
		;;
	OS|os)
		REMOTECOMMAND="lsb_release -d"
		;;
	CPU|cpu)
		REMOTECOMMAND="lscpu"
		;;
	date)
		REMOTECOMMAND="date"
		;;
	df)
		REMOTECOMMAND="df"
		;;
	last)
		REMOTECOMMAND="lastlog | grep -v '**Never logged in**'"
		;;
	who)
		REMOTECOMMAND="who"
		;;
	ip)
		REMOTECOMMAND="ip a"
		;;
	netstat)
		REMOTECOMMAND="sudo netstat -natup"
		;;
	uptime)
		REMOTECOMMAND="uptime"
		;;
	showhold)
		REMOTECOMMAND="apt-mark showhold"
		;;
	docker-version)
		REMOTECOMMAND="docker version | grep -m 1 'Version:'"
		;;
	docker-release)
		REMOTECOMMAND="grep docker /etc/apt/sources.list"
		;;
	docker-df)
		REMOTECOMMAND="docker system df"
		;;
	docker-df-v)
		REMOTECOMMAND="docker system df --verbose"
		;;
	docker-info)
		REMOTECOMMAND="docker system info | head -6"
		;;
	ls-docker-con)
		REMOTECOMMAND="docker container ls"
		;;
	ls-docker-ima)
		REMOTECOMMAND="docker images"
		;;
	ls-docker-net)
		REMOTECOMMAND="docker network ls"
		;;
	ls-docker-vol)
		REMOTECOMMAND="docker volume ls"
		;;
	clean-docker-vol)
		REMOTECOMMAND="docker volume rm \$(docker volume ls --filter dangling=true -q)"
		;;
	clean-docker-ima)
		REMOTECOMMAND="docker image rm \$(docker image ls --filter='dangling=true' -q)"
		;;
	prune-docker-net)
		REMOTECOMMAND="docker network prune"
		;;
	prune-docker-vol)
		REMOTECOMMAND="docker volume prune"
		;;
	prune-docker-all)
		REMOTECOMMAND="docker system prune"
		;;
	update)
		REMOTECOMMAND="sudo apt-get update ; /usr/lib/update-notifier/apt-check --human-readable"
		;;
	upgrade)
		REMOTECOMMAND="sudo apt-get upgrade --assume-yes ; if [ -f /var/run/reboot-required ]; then echo -e '\treboot required' ; else echo -e '\tno reboot required' ; fi"
		;;
	dist-upgrade)
		REMOTECOMMAND="sudo apt-get dist-upgrade --assume-yes"
		;;
	autoremove)
		REMOTECOMMAND="sudo apt-get autoremove  --assume-yes"
		;;
	require-reboot)
		REMOTECOMMAND="if [ -f /var/run/reboot-required ]; then echo 'reboot required' ; else echo 'no reboot required' ; fi"
		;;
	require-upgrade|require-update)
		REMOTECOMMAND="/usr/lib/update-notifier/apt-check --human-readable"
		;;
	upgrade-package)
		REMOTECOMMAND="apt-get upgrade --simulate  | grep -vE 'Conf|Inst'"
		;;
	*)
		echo -e "\n${NORMAL}${0} ${LINENO} [${BOLD}INFO${NORMAL}]:	${REMOTECOMMAND} - NOT a supported command"
		exit 0
		;;
esac
#
for NODE in ${REMOTEHOST} ; do
	echo -e "\n${BOLD}  -->  ${NODE}${NORMAL}	->${REMOTECOMMAND}<-" 
	if [ "${LOCALHOST}" != "${NODE}" ] ; then
		ssh -t ${USER}@${NODE} ${REMOTECOMMAND} 
	else
		eval ${REMOTECOMMAND}
	fi
done
echo -e "\n${NORMAL}${0} ${LINENO} [${BOLD}INFO${NORMAL}]:	Done.\n"	1>&2
###
