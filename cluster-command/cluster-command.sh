#!/bin/bash
# 	cluster-command.sh  2.08.118  2018-10-15T19:39:53-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.07  
# 	   Change echo or print DEBUG INFO WARNING ERROR #13 
# 	cluster-command.sh  2.07.117  2018-10-15T19:30:07-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.06-1-g3bc75fb  
# 	   Change echo or print DEBUG INFO WARNING ERROR #13 
#
###	cluster-command.sh - remote cluster system adminstration tool
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
echo    "      showhold       - apt-mark showhold"
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
#       After displaying help in english check for other languages
if ! [ "${LANG}" == "en_US.UTF-8" ] ; then
        get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[WARN]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  Your language, ${LANG}, is not supported, Would you like to help translate?" 1>&2
#       elif [ "${LANG}" == "fr_CA.UTF-8" ] ; then
#               get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[WARN]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  Display help in ${LANG}" 1>&2
#       else
#               get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[WARN]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  Your language, ${LANG}, is not supported.\tWould you like to translate?" 1>&2
fi
}

#       Date and time function ISO 8601
get_date_stamp() {
DATE_STAMP=`date +%Y-%m-%dT%H:%M:%S%:z`
TEMP=`date +%Z`
DATE_STAMP=`echo "${DATE_STAMP} (${TEMP})"`
}

#       Fully qualified domain name FQDN hostname
LOCALHOST=`hostname -f`

#       Version
SCRIPT_NAME=`head -2 ${0} | awk {'printf$2'}`
SCRIPT_VERSION=`head -2 ${0} | awk {'printf$3'}`

#       UID and GID
USER_ID=`id -u`
GROUP_ID=`id -g`

#       Default help and version arguments
if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] ; then
        display_help
        exit 0
fi
if [ "$1" == "--version" ] || [ "$1" == "-version" ] || [ "$1" == "version" ] || [ "$1" == "-v" ] ; then
        echo "${SCRIPT_NAME} ${SCRIPT_VERSION}"
        exit 0
fi

#       INFO
get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[INFO]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  Begin" 1>&2

#       DEBUG
if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[DEBUG]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  Name_of_command >${0}< Name_of_arg1 >${1}<" 1>&2 ; fi

###
#	Execpt only commands in case statement
REMOTECOMMAND=${1:-""}

#       Order of precedence: CLI argument, environment variable, default code
if [ $# -ge  2 ]  ; then CLUSTER=${2} ; elif [ "${CLUSTER}" == "" ] ; then CLUSTER="us-tx-cluster-1/" ; fi
#       Order of precedence: CLI argument, environment variable, default code
if [ $# -ge  3 ]  ; then DATA_DIR=${1} ; elif [ "${DATA_DIR}" == "" ] ; then DATA_DIR="/usr/local/data/" ; fi
#       order of precedence: CLI argument, environment variable, default code
if [ $# -ge  4 ]  ; then SYSTEMS_FILE=${5} ; elif [ "${SYSTEMS_FILE}" == "" ] ; then SYSTEMS_FILE="SYSTEMS" ; fi
#
if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[DEBUG]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  CLUSTER >${CLUSTER}<  DATA_DIR >${DATA_DIR}  SYSTEMS_FILE ${SYSTEMS_FILE} REMOTECOMMAND <${REMOTECOMMAND}" 1>&2 ; fi

#       Check for /${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE} file
if [ ! -e /${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE} ] ; then
	get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[ERROR]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  /${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE} NOT found" 1>&2 
        exit 1
fi

REMOTEHOST=`grep -v "#" /${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}`
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
		get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[INFO]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  ${REMOTECOMMAND} - NOT a supported command" 1>&2
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
#
get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[INFO]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  Done." 1>&2
###
