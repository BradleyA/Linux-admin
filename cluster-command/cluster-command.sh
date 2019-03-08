#!/bin/bash
# 	cluster-command/cluster-command.sh  2.26.151  2019-03-08T14:01:47.975300-06:00 (CST)  https://github.com/BradleyA/Linux-admin  uadmin  four-rpi3b.cptx86.com 2.25-6-g048c86d  
# 	   add SOFTWARE ARCHITECTURE to display_help 
# 	cluster-command/cluster-command.sh  2.25.144  2019-01-23T15:46:18.461244-06:00 (CST)  https://github.com/BradleyA/Linux-admin  uadmin  four-rpi3b.cptx86.com 2.24  
# 	   cluster-command.sh --> production standard 5 include Copyright notice close #19 
# 	cluster-command/cluster-command.sh  2.24.143  2019-01-23T15:39:34.531354-06:00 (CST)  https://github.com/BradleyA/Linux-admin  uadmin  four-rpi3b.cptx86.com 2.23  
# 	   cluster-command/cluster-command.sh update local host last close #18 
# 	cluster-command/cluster-command.sh  2.23.142  2019-01-23T11:27:21.815863-06:00 (CST)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.22-5-gdafdbec  
# 	   change docker version to display both for user & server 
# 	cluster-command/cluster-command.sh  2.21.132  2018-12-14T10:08:27.099551-06:00 (CST)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.20  
# 	   updates during testing of options support REMOTECOMMAND REMOTECOMMANDOPTION   #17  #14 
#
### cluster-command.sh - remote cluster system adminstration tool
#       Copyright (c) 2019 Bradley Allen
#       License is in the online DOCUMENTATION, DOCUMENTATION URL defined below.
###
#   production standard 5
#       Order of precedence: environment variable, default code
if [ "${DEBUG}" == "" ] ; then DEBUG="0" ; fi   # 0 = debug off, 1 = debug on, 'export DEBUG=1', 'unset DEBUG' to unset environment variable (bash)
#	set -x
#	set -v
BOLD=$(tput -Txterm bold)
NORMAL=$(tput -Txterm sgr0)
###		
display_help() {
echo -e "\n${NORMAL}${0} - remote cluster system adminstration tool"
echo -e "\nUSAGE\n   ${0} [<PREDEFINED-COMMAND>] [<CLUSTER>] [<DATA_DIR>] [SYSTEMS_FILE]"
echo    "   ${0} [--help | -help | help | -h | h | -?]"
echo    "   ${0} [--version | -version | -v]"
echo -e "\nDESCRIPTION"
#       Displaying help DESCRIPTION in English en_US.UTF-8
echo    "This script runs a command from a set of predefined commands on hosts."
echo -e "\nThis script reads /usr/local/data/us-tx-cluster-1/SYSTEMS file for hosts."
echo    "The hosts are one FQDN or IP address per line for all hosts in a cluster."
echo    "Lines in SYSTEMS file that begin with a # are comments.  The SYSTEMS file is"
echo    "used by Linux-admin/cluster-command/cluster-command.sh, markit/find-code.sh,"
echo    "pi-display/create-message/create-display-message.sh, and other scripts.  A"
echo    "different SYSTEMS file can be entered on the command line or environment"
echo    "variable."
echo -e "\nTo avoid many login prompts for each host in a cluster, enter the following:"
echo    "${BOLD}ssh-copy-id uadmin@<host-name>${NORMAL} to each host in the SYSTEMS file."
#       Displaying help DESCRIPTION in French fr_CA.UTF-8, fr_FR.UTF-8, fr_CH.UTF-8
if [ "${LANG}" == "fr_CA.UTF-8" ] || [ "${LANG}" == "fr_FR.UTF-8" ] || [ "${LANG}" == "fr_CH.UTF-8" ] ; then
        echo -e "\n--> ${LANG}"
        echo    "<votre aide va ici>" # your help goes here
        echo    "Souhaitez-vous traduire la section description?" # Do you want to translate the description section?
elif ! [ "${LANG}" == "en_US.UTF-8" ] ; then
        get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[WARN]${NORMAL}  Your language, ${LANG}, is not supported.  Would you like to translate the description section?" 1>&2
fi
echo -e "\nSOFTWARE ARCHITECTURE"
echo    "/usr/local/data/                            <-- <DATA_DIR>"
echo    "   <CLUSTER>/                               <-- <CLUSTER>"
echo    "   └── SYSTEMS                              <-- List of hosts in cluster"
echo -e "\nEnvironment Variables"
echo    "If using the bash shell, enter; export CLUSTER='us-west1' on the command"
echo    "line to set the CLUSTER environment variable to 'us-west1'.  Use the command,"
echo    "unset CLUSTER to remove the exported information from the CLUSTER environment"
echo    "variable.  To set an environment variable to be defined at login, add it to"
echo    "~/.bashrc file or you can modify this script with your default location for"
echo    "CLUSTER, DATA_DIR, and SYSTEMS_FILE.  You are on your own defining environment"
echo    "variables if you are using other shells."
echo    "   CLUSTER               (default us-tx-cluster-1/)"
echo    "   DATA_DIR              (default /usr/local/data/)"
echo    "   SYSTEMS_FILE          (default SYSTEMS)"
echo    "   DEBUG                 (default '0')"
echo    "   REMOTECOMMANDOPTION   command options (+) or special command (default '')"
if ! [ "${REMOTECOMMANDOPTION}" == "" ] ; then echo -e "\n   ${BOLD}[WARN]${NORMAL}  Environment Variable ${BOLD}REMOTECOMMANDOPTION${NORMAL} is set to >${BOLD}${REMOTECOMMANDOPTION}${NORMAL}<"  ; else echo "   Commands that support environment variable ${BOLD}REMOTECOMMANDOPTION${NORMAL} are mark with ${BOLD}+${NORMAL}" ; fi
echo -e "\nOPTIONS "
echo    "   CLUSTER       name of cluster directory (default us-tx-cluster-1)"
echo    "   DATA_DIR      path to cluster data directory (default /usr/local/data/)"
echo -e "   SYSTEMS_FILE  name of SYSTEMS file (default SYSTEMS)\n"
echo -e "\n   PREDEFINED-COMMAND"
echo    "      shutdown       - sudo shutdown -f now"
echo -e "      reboot         + sudo reboot ${REMOTECOMMANDOPTION}\n"
echo    "      os             - lsb_release -d"
echo    "      cpu            - lscpu"
echo    "      date           + date ${REMOTECOMMANDOPTION}"
echo    "      df             + df ${REMOTECOMMANDOPTION}"
echo    "      last           - lastlog | grep -v '**Never logged in**'"
echo    "      who            + who ${REMOTECOMMANDOPTION}"
echo    "      ip             - ip a"
echo    "      netstat        - sudo netstat -natup"
echo -e "      uptime         + uptime ${REMOTECOMMANDOPTION}\n"
echo    "      docker-version - docker version | grep 'Version:'"
echo    "      docker-release - grep docker /etc/apt/sources.list"
echo    "      docker-df      - docker system df"
echo    "      docker-df-v    - docker system df --verbose"
echo    "      docker-info    + docker system info ${REMOTECOMMANDOPTION}"
echo    "      docker-info-con - docker system info | head -6"
echo    "      docker-info-swarm - docker system info | grep -i swarm"
echo    "      ls-docker-con  + docker container ls ${REMOTECOMMANDOPTION}"
echo    "      ls-docker-ima  + docker images ${REMOTECOMMANDOPTION}"
echo    "      ls-docker-net  + docker network ls ${REMOTECOMMANDOPTION}"
echo    "      ls-docker-vol  + docker volume ls ${REMOTECOMMANDOPTION}"
echo    "      clean-docker-ima	- docker image rm \$(docker image ls --filter='dangling=true' -q)"
echo    "      clean-docker-vol	- docker volume rm \$(docker volume ls --filter dangling=true -q)"
echo    "      prune-docker-net	+ docker network prune ${REMOTECOMMANDOPTION}"
echo    "      prune-docker-vol	+ docker volume prune ${REMOTECOMMANDOPTION}"
echo -e "      prune-docker-all	+ docker system prune ${REMOTECOMMANDOPTION}\n"
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
echo    "      require-upgrade - /usr/lib/update-notifier/apt-check --human-readable" # >>> not sure this is the correct command becasue one-rpi3b stated no upgrade but then did eight upgrades
echo    "      upgrade-package - apt-get upgrade --simulate | grep -vE 'Conf|Inst'"
echo    "                        apt list --upgradeable -> does not work on Ubuntu 14.04"
echo    "      special        + ${REMOTECOMMANDOPTION}"
echo    "      root-special   + sudo ${REMOTECOMMANDOPTION}"
echo -e "\nDOCUMENTATION\n   https://github.com/BradleyA/pi-scripts/tree/master/cluster-command"
echo -e "\nEXAMPLES\n   Shutdown raspberry pi clusters\n\t${0} shutdown\n"
echo -e "   Display disk space available on file system /tmp\n\texport REMOTECOMMANDOPTION=\"/tmp\"\n\t${0} df\n"
echo -e "   Remove log file that includes remote hostname\n\texport REMOTECOMMANDOPTION='rm  /usr/local/data/us-tx-cluster-1/log/*\`hostname -f\`-crontab'\n\t${0} special\n"
echo -e "   List files in /usr/local/bin directory\n\t${0} special 'ls -l /usr/local/bin/*'\n"
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

#       Default help and version arguments
if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] ; then
        display_help | more
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
#	Execpt only commands in case statement
REMOTECOMMAND=${1:-""}
if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  REMOTECOMMAND >${REMOTECOMMAND}<" 1>&2 ; fi
if [ "$1" == "special" ] || [ "$1" == "root-special" ] ; then
	REMOTECOMMANDOPTION=${2}
	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  REMOTECOMMAND >${REMOTECOMMAND}<  REMOTECOMMANDOPTION >${REMOTECOMMANDOPTION}<" 1>&2 ; fi
	#       Set default
	CLUSTER="us-tx-cluster-1/"
	DATA_DIR="/usr/local/data/"
	SYSTEMS_FILE="SYSTEMS"
else
	#	Environment variable to set option for some remote commands 
	#       Order of precedence: CLI argument, environment variable, default code
	if [ $# -ge  2 ]  ; then CLUSTER=${2} ; elif [ "${CLUSTER}" == "" ] ; then CLUSTER="us-tx-cluster-1/" ; fi
	#       Order of precedence: CLI argument, environment variable, default code
	if [ $# -ge  3 ]  ; then DATA_DIR=${1} ; elif [ "${DATA_DIR}" == "" ] ; then DATA_DIR="/usr/local/data/" ; fi
	#       order of precedence: CLI argument, environment variable, default code
	if [ $# -ge  4 ]  ; then SYSTEMS_FILE=${5} ; elif [ "${SYSTEMS_FILE}" == "" ] ; then SYSTEMS_FILE="SYSTEMS" ; fi
fi
if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  CLUSTER >${CLUSTER}<  DATA_DIR >${DATA_DIR}<  SYSTEMS_FILE ${SYSTEMS_FILE} REMOTECOMMAND >${REMOTECOMMAND}<" 1>&2 ; fi

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

REMOTEHOST=$(grep -v "#" ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE})
###
case ${REMOTECOMMAND} in
	shutdown)
		REMOTECOMMAND="sudo shutdown -f now"
		;;
	reboot)
		REMOTECOMMAND="sudo reboot ${REMOTECOMMANDOPTION}"
		;;
	OS|os)
		REMOTECOMMAND="lsb_release -d"
		;;
	CPU|cpu)
		REMOTECOMMAND="lscpu"
		;;
	date)
		REMOTECOMMAND="date ${REMOTECOMMANDOPTION}"
		;;
	df)
		REMOTECOMMAND="df ${REMOTECOMMANDOPTION}"
		;;
	last)
		REMOTECOMMAND="lastlog | grep -v '**Never logged in**'"
		;;
	who)
		REMOTECOMMAND="who ${REMOTECOMMANDOPTION}"
		;;
	ip)
		REMOTECOMMAND="ip a"
		;;
	netstat)
		REMOTECOMMAND="sudo netstat -natup"
		;;
	uptime)
		REMOTECOMMAND="uptime ${REMOTECOMMANDOPTION}"
		;;
	docker-version)
		REMOTECOMMAND="docker version | grep 'Version:'"
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
		REMOTECOMMAND="docker system info ${REMOTECOMMANDOPTION}"
		;;
	docker-info-con)
		REMOTECOMMAND="docker system info | head -6"
		;;
	docker-info-swarm)
		REMOTECOMMAND="docker system info | grep -i swarm"
		;;
	ls-docker-con)
		REMOTECOMMAND="docker container ls ${REMOTECOMMANDOPTION}"
		;;
	ls-docker-ima)
		REMOTECOMMAND="docker images ${REMOTECOMMANDOPTION}"
		;;
	ls-docker-net)
		REMOTECOMMAND="docker network ls ${REMOTECOMMANDOPTION}"
		;;
	ls-docker-vol)
		REMOTECOMMAND="docker volume ls ${REMOTECOMMANDOPTION}"
		;;
	clean-docker-ima)
		REMOTECOMMAND="docker image rm \$(docker image ls --filter='dangling=true' -q)"
		;;
	clean-docker-vol)
		REMOTECOMMAND="docker volume rm \$(docker volume ls --filter dangling=true -q)"
		;;
	prune-docker-net)
		REMOTECOMMAND="docker network prune ${REMOTECOMMANDOPTION}"
		;;
	prune-docker-vol)
		REMOTECOMMAND="docker volume prune ${REMOTECOMMANDOPTION}"
		;;
	prune-docker-all)
		REMOTECOMMAND="docker system prune ${REMOTECOMMANDOPTION}"
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
	showhold)
		REMOTECOMMAND="apt-mark showhold"
		;;
	unhold)
		REMOTECOMMAND="apt-mark unhold ${REMOTECOMMANDOPTION}"
		;;
	hold)
		REMOTECOMMAND="apt-mark hold ${REMOTECOMMANDOPTION}"
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
	special)
		REMOTECOMMAND="${REMOTECOMMANDOPTION}"
		;;
	root-special)
		REMOTECOMMAND="sudo ${REMOTECOMMANDOPTION}"
		;;
	*)
		get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0} ${SCRIPT_VERSION} ${LINENO} ${BOLD}[INFO]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  ${REMOTECOMMAND} - NOT a supported command" 1>&2
		exit 0
		;;
esac

#
if ! [ "${REMOTECOMMANDOPTION}" == "" ] ; then echo -e "${BOLD}[WARN]${NORMAL}\tEnvironment Variable ${BOLD}REMOTECOMMANDOPTION${NORMAL} is set to >${BOLD}${REMOTECOMMANDOPTION}${NORMAL}<.\n\tCommand to be executed ${BOLD}${REMOTECOMMAND}${NORMAL}.\n\tPress enter to continue ctrl c to stop." ; read input ; fi

#
for NODE in ${REMOTEHOST} ; do
	if [ "${LOCALHOST}" != "${NODE}" ] ; then
		echo -e "\n${BOLD}  =-->  ${NODE}${NORMAL}	->${REMOTECOMMAND}<-" 
		ssh -t ${USER}@${NODE} ${REMOTECOMMAND} 
	fi
done
echo -e "\n${BOLD}  -->  ${LOCALHOST}${NORMAL}	->${REMOTECOMMAND}<-" 
eval ${REMOTECOMMAND}

#
get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[INFO]${NORMAL}  Operation finished." 1>&2
###
