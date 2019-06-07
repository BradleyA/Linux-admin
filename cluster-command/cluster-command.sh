#!/bin/bash
# 	cluster-command/cluster-command.sh  2.42.202  2019-06-07T17:09:06.723711-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.41-4-g2dee103  
# 	   ready for production 
# 	cluster-command/cluster-command.sh  2.40.196  2019-06-07T16:46:37.648780-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.39
# 	   cluster-command.sh - rename several docker sub commands close #27 
# 	cluster-command/cluster-command.sh  2.39.195  2019-06-07T15:34:17.498890-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.38
# 	   cluster-command.sh - add support for production standard 8.0 --usage close #28 
### production standard 3.0 shellcheck
### production standard 5.1.160 Copyright
#       Copyright (c) 2019 Bradley Allen
#       MIT License is in the online DOCUMENTATION, DOCUMENTATION URL defined below.
### production standard 1.0 DEBUG variable
#       Order of precedence: environment variable, default code
if [ "${DEBUG}" == "" ] ; then DEBUG="0" ; fi   # 0 = debug off, 1 = debug on, 'export DEBUG=1', 'unset DEBUG' to unset environment variable (bash)
#       set -x
#       set -v
BOLD=$(tput -Txterm bold)
NORMAL=$(tput -Txterm sgr0)
### production standard 7.0 Default variable value
DEFAULT_REMOTE_COMMAND=""
DEFAULT_REMOTE_COMMAND_OPTION=""
DEFAULT_CLUSTER="us-tx-cluster-1/"
DEFAULT_DATA_DIR="/usr/local/data/"
DEFAULT_SYSTEMS_FILE="SYSTEMS"
### production standard 8.0 --usage
display_usage() {
echo -e "\n${NORMAL}${0} - remote cluster system adminstration tool"
echo -e "\nUSAGE"
echo    "   ${0} [<PREDEFINED-COMMAND>]"
echo -e "   ${0}  <PREDEFINED-COMMAND> [<REMOTE_COMMAND_OPTION>]\n"
echo -e "   ${0}  special|root-special  <REMOTE_COMMAND_OPTION>\n"
echo    "   ${0} [--help | -help | help | -h | h | -?]"
echo    "   ${0} [--usage | -usage | -u]"
echo    "   ${0} [--version | -version | -v]"
}
### production standard 0.1.166 --help
display_help() {
display_usage
#       Displaying help DESCRIPTION in English en_US.UTF-8
echo -e "\nDESCRIPTION"
echo    "This script runs a command from a set of predefined commands on hosts."
echo -e "\nThis script reads ${DEFAULT_DATA_DIR}${DEFAULT_CLUSTER}${DEFAULT_SYSTEMS_FILE} file for hosts."
echo    "The <DATA_DIR>/<CLUSTER>/<SYSTEMS_FILE> includes one FQDN or IP address per"
echo    "line for all hosts in the cluster.  Lines in <SYSTEMS_FILE> that begin with a"
echo    "'#' are comments.  The <SYSTEMS_FILE> is used by markit/find-code.sh,"
echo    "Linux-admin/cluster-command/cluster-command.sh, docker-TLS/copy-registry-tls.sh,"
echo    "pi-display/create-message/create-display-message.sh, and other scripts.  A"
echo    "different <SYSTEMS_FILE> can be used by setting the SYSTEMS_FILE environment"
echo    "variable."

echo -e "\nThe user may receive password and/or passphrase prompts from a"
echo    "remote systen; running the following may stop the prompts in your cluster."
echo -e "\t${BOLD}ssh-copy-id <TLS_USER>@<REMOTE_HOST>${NORMAL}"
echo    "or"
echo -e "\t${BOLD}ssh-copy-id <TLS_USER>@<192.168.x.x>${NORMAL}"
echo    "If that does not resolve the prompting challenge then review the man pages for"
echo    "ssh-agent and ssh-add before entering the following in a terminal window."
echo -e "\t${BOLD}eval \$(ssh-agent)${NORMAL}"
echo -e "\t${BOLD}ssh-add${NORMAL}"
### production standard 4.0 Documentation Language
#       Displaying help DESCRIPTION in French fr_CA.UTF-8, fr_FR.UTF-8, fr_CH.UTF-8
if [ "${LANG}" == "fr_CA.UTF-8" ] || [ "${LANG}" == "fr_FR.UTF-8" ] || [ "${LANG}" == "fr_CH.UTF-8" ] ; then
        echo -e "\n--> ${LANG}"
        echo    "<votre aide va ici>" # your help goes here
        echo    "Souhaitez-vous traduire la section description?" # Do you want to translate the description section?
elif ! [ "${LANG}" == "en_US.UTF-8" ] ; then
        get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[WARN]${NORMAL}  Your language, ${LANG}, is not supported.  Would you like to translate the description section?" 1>&2
fi
echo -e "\nENVIRONMENT VARIABLES"
echo    "If using the bash shell, enter; 'export DEBUG=1' on the command line to set"
echo    "the DEBUG environment variable to '1' (0 = debug off, 1 = debug on).  Use the"
echo    "command, 'unset DEBUG' to remove the exported information from the DEBUG"
echo    "environment variable.  You are on your own defining environment variables if"
echo    "you are using other shells."
echo    "   DEBUG                   (default off '0')"
echo    "   CLUSTER                 Cluster name (default '${DEFAULT_CLUSTER}')"
echo    "   DATA_DIR                Data directory (default '${DEFAULT_DATA_DIR}')"
echo    "   SYSTEMS_FILE            Hosts in cluster (default '${DEFAULT_SYSTEMS_FILE}')"
echo -e "   REMOTE_COMMAND_OPTION   Commands with '+' support options\n"
if ! [ "${REMOTE_COMMAND_OPTION}" == "" ] ; then echo -e "\n   ${BOLD}[INFO]${NORMAL}  Environment Variable ${BOLD}REMOTE_COMMAND_OPTION${NORMAL} is set to >${BOLD}${REMOTE_COMMAND_OPTION}${NORMAL}<"  ; else echo -e "   PREDEFINED-COMMAND that support environment variable ${BOLD}REMOTE_COMMAND_OPTION${NORMAL} are\n   marked with ${BOLD}+${NORMAL}" ; fi
echo -e "\nOPTIONS"
echo    "   REMOTE_COMMAND_OPTION   Commands with '+' support options"
### production standard 6.1.177 Architecture tree
echo -e "\nARCHITECTURE TREE"   # STORAGE & CERTIFICATION
echo    "/usr/local/data/                           <-- <DATA_DIR>"
echo    "└── <CLUSTER>/                             <-- <CLUSTER>"
echo    "   └── SYSTEMS                             <-- List of hosts in cluster"
echo -e "\n   PREDEFINED-COMMAND"
echo    "      shutdown       - sudo shutdown -f now"
echo -e "      reboot         + sudo reboot [<REMOTE_COMMAND_OPTION>]\n"
echo    "      os             - lsb_release -d"
echo    "      cpu            - lscpu"
echo    "      date           + date [<REMOTE_COMMAND_OPTION>]"
echo    "      df             + df [<REMOTE_COMMAND_OPTION>]"
echo    "      last           - lastlog | grep -v '**Never logged in**'"
echo    "      who            + who [<REMOTE_COMMAND_OPTION>]"
echo    "      ip             - ip a"
echo    "      netstat        - sudo netstat -natup"
echo -e "      uptime         + uptime [<REMOTE_COMMAND_OPTION>]\n"
echo    "      docker-version - docker version | grep 'Version:'"
echo    "      docker-release - grep docker /etc/apt/sources.list"
echo    "      docker-df      - docker system df"
echo    "      docker-df-v    - docker system df --verbose"
echo    "      docker-info    + docker system info [<REMOTE_COMMAND_OPTION>]"
echo    "      docker-info-con - docker system info | head -6"
echo    "      docker-info-swarm - docker system info | grep -i swarm"
echo    "      docker-con-ls  + docker container ls [<REMOTE_COMMAND_OPTION>]"
echo    "      docker-ima-ls  + docker images [<REMOTE_COMMAND_OPTION>]"
echo    "      docker-net-ls  + docker network ls [<REMOTE_COMMAND_OPTION>]"
echo    "      docker-vol-ls  + docker volume ls [<REMOTE_COMMAND_OPTION>]"
echo    "      docker-ima-clean	- docker image rm \$(docker image ls --filter='dangling=true' -q)"
echo    "      docker-vol-clean	- docker volume rm \$(docker volume ls --filter dangling=true -q)"
echo    "      docker-net-prune	+ docker network prune [<REMOTE_COMMAND_OPTION>]"
echo    "      docker-vol-prune	+ docker volume prune [<REMOTE_COMMAND_OPTION>]"
echo -e "      docker-all-prune	+ docker system prune [<REMOTE_COMMAND_OPTION>]\n"
echo    "      update         - sudo apt-get update ;"
echo    "                       /usr/lib/update-notifier/apt-check --human-readable"
echo    "      upgrade        - sudo apt-get upgrade --assume-yes ;"
echo    "                       if [ -f /var/run/reboot-required ] ; then"
echo    "                       echo 'reboot required' ; else"
echo    "                       echo 'no reboot required' ; fi"
echo    "      dist-upgrade   - sudo apt-get dist-upgrade --assume-yes"
echo    "      autoremove     - sudo apt-get autoremove --assume-yes"
echo    "      showhold       - apt-mark showhold"
echo    "      unhold         - apt-mark unhold"
echo    "      hold           - apt-mark hold"
echo    "      require-reboot - if [ -f /var/run/reboot-required ]; then echo 'reboot"
echo    "                       required' ; else echo 'no reboot required' ; fi"
echo    "      require-upgrade - /usr/lib/update-notifier/apt-check --human-readable" # >>> not sure this is the correct command becasue one-rpi3b stated no upgrade but then did eight upgrades #12
echo    "      upgrade-package - apt-get upgrade --simulate | grep -vE 'Conf|Inst'"
echo    "                        apt list --upgradeable -> does not work on Ubuntu 14.04"
echo    "      disable-user   + sudo usermod --expiredate 1"  # disable user from logging in (including ssh)
echo    "      enable-user    + sudo usermod --expiredate ''" # enable user to login that was disabled
echo    "      special        + <REMOTE_COMMAND_OPTION>"
echo    "      root-special   + sudo <REMOTE_COMMAND_OPTION>"
echo -e "\nDOCUMENTATION"
echo    "   https://github.com/BradleyA/Linux-admin/tree/master/cluster-command"
echo -e "\nEXAMPLES"
echo -e "   Resynchronize package index files from their sources\n\t${BOLD}${0} update${NORMAL}"
echo -e "   Shutdown hosts in clusters\n\t${BOLD}${0} shutdown${NORMAL}"
echo -e "   Display disk space available on file system /tmp\n\t${BOLD}export REMOTE_COMMAND_OPTION=\"/tmp\"\n\t${0} df${NORMAL}\n   or\n\t${BOLD}${0} df /tmp${NORMAL}"
echo -e "   Remove log file that includes remote hostname\n\t${BOLD}export REMOTE_COMMAND_OPTION='rm  /usr/local/data/us-tx-cluster-1/log/\`hostname -f\`-crontab'\n\t${0} special${NORMAL}"
echo -e "   List files in /usr/local/bin directory\n\t${BOLD}${0} special 'ls -l /usr/local/bin/*'${NORMAL}"
echo -e "   Check public, private keys, and CA for hosts in cluster\n\t${BOLD}${0} root-special check-host-tls.sh${NORMAL}"
}

#       Date and time function ISO 8601
get_date_stamp() {
DATE_STAMP=$(date +%Y-%m-%dT%H:%M:%S.%6N%:z)
TEMP=$(date +%Z)
DATE_STAMP="${DATE_STAMP} (${TEMP})"
}

#       Fully qualified domain name FQDN hostname
LOCALHOST=$(hostname -f)

#       Version
SCRIPT_NAME=$(head -2 "${0}" | awk {'printf $2'})
SCRIPT_VERSION=$(head -2 "${0}" | awk {'printf $3'})

#       UID and GID
USER_ID=$(id -u)
GROUP_ID=$(id -g)

#       Added line because USER is not defined in crobtab jobs
if ! [ "${USER}" == "${LOGNAME}" ] ; then  USER=${LOGNAME} ; fi
if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Setting USER to support crobtab...  USER >${USER}<  LOGNAME >${LOGNAME}<" 1>&2 ; fi

#       Default help, usage, and version arguments
if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] ; then
        display_help | more
        exit 0
fi
if [ "$1" == "--usage" ] || [ "$1" == "-usage" ] || [ "$1" == "usage" ] || [ "$1" == "-u" ] ; then
        display_usage | more
        exit 0
fi
if [ "$1" == "--version" ] || [ "$1" == "-version" ] || [ "$1" == "version" ] || [ "$1" == "-v" ] ; then
        echo "${SCRIPT_NAME} ${SCRIPT_VERSION}"
        exit 0
fi

#       INFO
get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[INFO]${NORMAL}  Started..." 1>&2

#       DEBUG
if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Name_of_command >${0}< Name_of_arg1 >${1}< Name_of_arg2 >${2}< Name_of_arg3 >${3}<  Version of bash ${BASH_VERSION}" 1>&2 ; fi

###
#       Set default
REMOTE_COMMAND=${1:-${DEFAULT_REMOTE_COMMAND}}
REMOTE_COMMAND_OPTION=${2:-${DEFAULT_REMOTE_COMMAND_OPTION}}
if [ "${CLUSTER}" == "" ] ; then CLUSTER=${DEFAULT_CLUSTER} ; fi
if [ "${DATA_DIR}" == "" ] ; then DATA_DIR=${DEFAULT_DATA_DIR} ; fi
if [ "${SYSTEMS_FILE}" == "" ] ; then SYSTEMS_FILE=${DEFAULT_SYSTEMS_FILE} ; fi
if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  CLUSTER >${CLUSTER}<  DATA_DIR >${DATA_DIR}<  SYSTEMS_FILE >${SYSTEMS_FILE}< REMOTE_COMMAND >${REMOTE_COMMAND}< REMOTE_COMMAND_OPTION >${REMOTE_COMMAND_OPTION}< Number of options >$#<" 1>&2 ; fi

if [ "$1" == "special" ] || [ "$1" == "root-special" ] && ! [ $# == "2" ] ; then
		get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Command not found after special|root-special." 1>&2
		exit 1
fi

#       Check if ${SYSTEMS_FILE} file is on system, one FQDN or IP address per line for all hosts in cluster
if ! [ -e ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE} ] || ! [ -s ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE} ] ; then
	get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[WARN]${NORMAL}  ${BOLD}${SYSTEMS_FILE} file missing or empty, creating ${SYSTEMS_FILE} file with local host.  Edit ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE} file and add additional hosts that are in the cluster.${NORMAL}" 1>&2
	mkdir -p ${DATA_DIR}/${CLUSTER}
        echo -e "#\n# "  > ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}
        echo -e "### ${SYSTEMS_FILE}"  >> ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}
        echo -e "#	Created: ${DATE_STAMP} ${LOCALHOST}"  >> ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}
        echo -e "#	List of hosts for scripts Linux-admin/cluster-command/cluster-command.sh,"  >> ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}
        echo -e "#	markit/find-code.sh, pi-display/create-message/create-message.sh,"  >> ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}
        echo -e "#	and other scripts."  >> ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}
        echo -e "#\n#	One FQDN or IP address per line for all hosts in cluster" >> ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}
        echo -e "###" >> ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}
        echo -e "${LOCALHOST}" >> ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE}
fi

REMOTE_HOST=$(grep -v "#" ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE})
###
case ${REMOTE_COMMAND} in
	shutdown)
		REMOTE_COMMAND="sudo shutdown -f now"
		;;
	reboot)
		REMOTE_COMMAND="sudo reboot ${REMOTE_COMMAND_OPTION}"
		;;
	OS|os)
		REMOTE_COMMAND="lsb_release -d"
		;;
	CPU|cpu)
		REMOTE_COMMAND="lscpu"
		;;
	date)
		REMOTE_COMMAND="date ${REMOTE_COMMAND_OPTION}"
		;;
	df)
		REMOTE_COMMAND="df ${REMOTE_COMMAND_OPTION}"
		;;
	last)
		REMOTE_COMMAND="lastlog | grep -v '**Never logged in**'"
		;;
	who)
		REMOTE_COMMAND="who ${REMOTE_COMMAND_OPTION}"
		;;
	ip)
		REMOTE_COMMAND="ip a"
		;;
	netstat)
		REMOTE_COMMAND="sudo netstat -natup"
		;;
	uptime)
		REMOTE_COMMAND="uptime ${REMOTE_COMMAND_OPTION}"
		;;
	docker-version)
		REMOTE_COMMAND="docker version | grep 'Version:'"
		;;
	docker-release)
		REMOTE_COMMAND="grep docker /etc/apt/sources.list"
		;;
	docker-df)
		REMOTE_COMMAND="docker system df"
		;;
	docker-df-v)
		REMOTE_COMMAND="docker system df --verbose"
		;;
	docker-info)
		REMOTE_COMMAND="docker system info ${REMOTE_COMMAND_OPTION}"
		;;
	docker-info-con)
		REMOTE_COMMAND="docker system info | head -6"
		;;
	docker-info-swarm)
		REMOTE_COMMAND="docker system info | grep -i swarm"
		;;
	docker-con-ls)
		REMOTE_COMMAND="docker container ls ${REMOTE_COMMAND_OPTION}"
		;;
	docker-ima-ls)
		REMOTE_COMMAND="docker images ${REMOTE_COMMAND_OPTION}"
		;;
	docker-net-ls)
		REMOTE_COMMAND="docker network ls ${REMOTE_COMMAND_OPTION}"
		;;
	docker-vol-ls)
		REMOTE_COMMAND="docker volume ls ${REMOTE_COMMAND_OPTION}"
		;;
	docker-ima-clean)
		REMOTE_COMMAND="docker image rm \$(docker image ls --filter='dangling=true' -q)"
		;;
	docker-vol-clean)
		REMOTE_COMMAND="docker volume rm \$(docker volume ls --filter dangling=true -q)"
		;;
	docker-net-prune)
		REMOTE_COMMAND="docker network prune ${REMOTE_COMMAND_OPTION}"
		;;
	docker-vol-prune)
		REMOTE_COMMAND="docker volume prune ${REMOTE_COMMAND_OPTION}"
		;;
	docker-all-prune)
		REMOTE_COMMAND="docker system prune ${REMOTE_COMMAND_OPTION}"
		;;
	update)
		REMOTE_COMMAND="sudo apt-get update ; /usr/lib/update-notifier/apt-check --human-readable"
		;;
	upgrade)
		REMOTE_COMMAND="sudo apt-get upgrade --assume-yes ; if [ -f /var/run/reboot-required ]; then echo -e '\treboot required' ; else echo -e '\tno reboot required' ; fi"
		;;
	dist-upgrade)
		REMOTE_COMMAND="sudo apt-get dist-upgrade --assume-yes"
		;;
	autoremove)
		REMOTE_COMMAND="sudo apt-get autoremove  --assume-yes"
		;;
	showhold)
		REMOTE_COMMAND="apt-mark showhold"
		;;
	unhold)
		REMOTE_COMMAND="apt-mark unhold ${REMOTE_COMMAND_OPTION}"
		;;
	hold)
		REMOTE_COMMAND="apt-mark hold ${REMOTE_COMMAND_OPTION}"
		;;
	require-reboot)
		REMOTE_COMMAND="if [ -f /var/run/reboot-required ]; then echo 'reboot required' ; else echo 'no reboot required' ; fi"
		;;
	require-upgrade|require-update)
		REMOTE_COMMAND="/usr/lib/update-notifier/apt-check --human-readable"
		;;
	upgrade-package)
		REMOTE_COMMAND="apt-get upgrade --simulate  | grep -vE 'Conf|Inst'"
		;;
	disable-user)
		echo -e "\n\tEnter user login name to disable"
		read USER_LOGIN
		REMOTE_COMMAND="sudo usermod --expiredate 1 ${USER_LOGIN}"
		;;
	enable-user)
		echo -e "\n\tEnter user login name to re-enable"
		read USER_LOGIN
		REMOTE_COMMAND="sudo usermod --expiredate '' ${USER_LOGIN}"
		;;
	special)
		REMOTE_COMMAND="${REMOTE_COMMAND_OPTION}"
		;;
	root-special)
		REMOTE_COMMAND="sudo ${REMOTE_COMMAND_OPTION}"
		;;
	*)
		get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[INFO]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  ${REMOTE_COMMAND} - NOT a supported command" 1>&2
		exit 0
		;;
esac

if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  REMOTE_HOST >${REMOTE_HOST}<" 1>&2 ; fi

#	is LOCALHOST included in ${REMOTE_HOST} list #26
CHECK_LOCALHOST=0
#
for NODE in ${REMOTE_HOST} ; do
	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  NODE  >${NODE}<" 1>&2 ; fi
	if [ "${LOCALHOST}" != "${NODE}" ] ; then
		echo -e "\n${BOLD}  =-->  ${NODE}${NORMAL}	->${REMOTE_COMMAND}<-" 
		ssh -t "${USER}"@"${NODE}" ${REMOTE_COMMAND}
	else
		CHECK_LOCALHOST=1
	fi
done
if [ "${CHECK_LOCALHOST}" == "1" ] ; then
	echo -e "\n${BOLD}  -->  ${LOCALHOST}${NORMAL}	->${REMOTE_COMMAND}<-" 
	eval "${REMOTE_COMMAND}"
fi

#
get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[INFO]${NORMAL}  Operation finished." 1>&2
###
