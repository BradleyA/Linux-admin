#!/bin/bash
# 	cluster-command/cluster-command.sh  3.2.5.778  2020-03-02T23:27:13.398432-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 3.2.4-2-g22f85c4  
# 	   cluster-command/cluster-command.sh   add git-TEST-commit-automation 
# 	cluster-command/cluster-command.sh  2.108.385  2019-12-02T12:37:22.679518-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  uadmin  five-rpi3b.cptx86.com 2.107  
# 	   cluster-command/cluster-command.sh   add reboot user hint to dist-upgrade 
# 	cluster-command/cluster-command.sh  2.107.384  2019-12-02T12:30:20.247306-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  uadmin  five-rpi3b.cptx86.com 2.106  
# 	   cluster-command/cluster-command.sh   added color in reboot user hint 
# 	cluster-command/cluster-command.sh  2.105.382  2019-11-20T22:14:06.745343-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  uadmin  five-rpi3b.cptx86.com 2.104-2-ge97d7cd  
# 	   cluster-command/cluster-command.sh   add DEBUG line and update EXAMPLES 
# 	cluster-command/cluster-command.sh  2.104.379  2019-10-22T12:03:43.784055-05:00 (CDT)  https://github.com/BradleyA/Linux-admin.git  uadmin  five-rpi3b.cptx86.com 2.103  
# 	   cluster-command/cluster-command.sh   add color to hostname and command syntax 
# 	cluster-command/cluster-command.sh  2.103.378  2019-10-21T21:15:40.076465-05:00 (CDT)  https://github.com/BradleyA/Linux-admin.git  uadmin  five-rpi3b.cptx86.com 2.102  
# 	   cluster-command/cluster-command.sh   added color to command output 
# 	cluster-command/cluster-command.sh  2.102.377  2019-10-21T20:19:59.927128-05:00 (CDT)  https://github.com/BradleyA/Linux-admin.git  uadmin  five-rpi3b.cptx86.com 2.101  
# 	   cluster-command/cluster-command.sh   upgrade or add  1.3.531 DEBUG variable, 8.3.530 --usage, 0.3.214 --help, 4.3.534 Documentation Language, 9.3.513 Parse CLI options and arguments, 7.0 Default variable value 
# 	cluster-command/cluster-command.sh  2.101.376  2019-09-04T14:39:38.663368-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.100-2-g16a6f72  
# 	   cluster-command.sh  upgrade to Production standard 1.3.496 DEBUG variable ; shellcheck version section corrected 
# 	cluster-command/cluster-command.sh  2.43.203  2019-06-19T12:25:28.056430-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  one-rpi3b.cptx86.com 2.42  
# 	   add bold around reboot required or not required 
# 	cluster-command/cluster-command.sh  2.42.202  2019-06-07T17:09:06.723711-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.41-4-g2dee103  
# 	   ready for production 
# 	cluster-command/cluster-command.sh  2.40.196  2019-06-07T16:46:37.648780-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.39
# 	   cluster-command.sh - rename several docker sub commands close #27 
# 	cluster-command/cluster-command.sh  2.39.195  2019-06-07T15:34:17.498890-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.38
# 	   cluster-command.sh - add support for production standard 8.0 --usage close #28 
#86# cluster-command/cluster-command.sh - remote cluster system adminstration tool
###  Production standard 3.0 shellcheck
###  Production standard 5.1.160 Copyright
#    Copyright (c) 2019 Bradley Allen
#    MIT License is in the online DOCUMENTATION, DOCUMENTATION URL defined below.
###  Production standard 1.3.531 DEBUG variable
#    Order of precedence: environment variable, default code
if [[ "${DEBUG}" == ""  ]] ; then DEBUG="0" ; fi   # 0 = debug off, 1 = debug on, 'export DEBUG=1', 'unset DEBUG' to unset environment variable (bash)
if [[ "${DEBUG}" == "2" ]] ; then set -x    ; fi   # Print trace of simple commands before they are executed
if [[ "${DEBUG}" == "3" ]] ; then set -v    ; fi   # Print shell input lines as they are read
if [[ "${DEBUG}" == "4" ]] ; then set -e    ; fi   # Exit immediately if non-zero exit status
if [[ "${DEBUG}" == "5" ]] ; then set -e -o pipefail ; fi   # Exit immediately if non-zero exit status and exit if any command in a pipeline errors
#
BOLD=$(tput -Txterm bold)
NORMAL=$(tput -Txterm sgr0)
RED=$(tput    setaf 1)
GREEN=$(tput  setaf 2)
YELLOW=$(tput setaf 3)
PURPLE=$(tput setaf 5)
CYAN=$(tput   setaf 6)
WHITE=$(tput  setaf 7)

###  Production standard 7.0 Default variable value
DEFAULT_REMOTE_COMMAND=""
DEFAULT_REMOTE_COMMAND_OPTION=""
DEFAULT_CLUSTER="us-tx-cluster-1/"
DEFAULT_DATA_DIR="/usr/local/data/"
DEFAULT_SYSTEMS_FILE="SYSTEMS"

###  Production standard 8.3.530 --usage
display_usage() {
COMMAND_NAME=$(echo "${0}" | sed 's/^.*\///')
echo -e "\n${NORMAL}${COMMAND_NAME}\n   remote cluster system adminstration tool"
echo -e "\n${BOLD}USAGE${NORMAL}"
echo    "   ${YELLOW}Positional Arguments${NORMAL}"
echo    "   ${COMMAND_NAME} [<PREDEFINED-COMMAND>]"
echo -e "   ${COMMAND_NAME}  <PREDEFINED-COMMAND> [<REMOTE_COMMAND_OPTION>]\n"
echo    "   ${YELLOW}Positional Arguments${NORMAL}"
echo -e "   ${COMMAND_NAME}  special|root-special  <REMOTE_COMMAND_OPTION>\n"
echo    "   ${COMMAND_NAME} [--help | -help | help | -h | h | -?]"
echo    "   ${COMMAND_NAME} [--usage | -usage | -u]"
echo    "   ${COMMAND_NAME} [--version | -version | -v]"
}

###  Production standard 0.3.214 --help
display_help() {
display_usage
#    Displaying help DESCRIPTION in English en_US.UTF-8
echo -e "\n${BOLD}DESCRIPTION${NORMAL}"
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

###  Production standard 1.3.531 DEBUG variable
echo -e "\nThe DEBUG environment variable can be set to '', '0', '1', '2', '3', '4' or"
echo    "'5'.  The setting '' or '0' will turn off all DEBUG messages during execution of"
echo    "this script.  The setting '1' will print all DEBUG messages during execution of"
echo    "this script.  The setting '2' (set -x) will print a trace of simple commands"
echo    "before they are executed in this script.  The setting '3' (set -v) will print"
echo    "shell input lines as they are read.  The setting '4' (set -e) will exit"
echo    "immediately if non-zero exit status is recieved with some exceptions.  The"
echo    "setting '5' (set -e -o pipefail) will do setting '4' and exit if any command in"
echo    "a pipeline errors.  For more information about any of the set options, see"
echo    "man bash."

###  Production standard 4.3.534 Documentation Language
#    Displaying help DESCRIPTION in French fr_CA.UTF-8, fr_FR.UTF-8, fr_CH.UTF-8
if [[ "${LANG}" == "fr_CA.UTF-8" ]] || [[ "${LANG}" == "fr_FR.UTF-8" ]] || [[ "${LANG}" == "fr_CH.UTF-8" ]] ; then
  echo -e "\n--> ${LANG}"
  echo    "<votre aide va ici>" # your help goes here
  echo    "Souhaitez-vous traduire la section description?" # Do you want to translate the description section?
elif ! [[ "${LANG}" == "en_US.UTF-8" ]] ; then
  new_message "${LINENO}" "${YELLOW}INFO${WHITE}" "  Your language, ${LANG}, is not supported.  Would you like to translate the description section?" 1>&2
fi

echo -e "\n${BOLD}ENVIRONMENT VARIABLES${NORMAL}"
echo    "If using the bash shell, enter; 'export DEBUG=1' on the command line to set"
echo    "the environment variable DEBUG to '1' (0 = debug off, 1 = debug on).  Use the"
echo    "command, 'unset DEBUG' to remove the exported information from the environment"
echo    "variable DEBUG.  You are on your own defining environment variables if"
echo    "you are using other shells."
echo    "   DEBUG                   (default off '0')"
echo    "   CLUSTER                 Cluster name (default '${DEFAULT_CLUSTER}')"
echo    "   DATA_DIR                Data directory (default '${DEFAULT_DATA_DIR}')"
echo    "   SYSTEMS_FILE            Hosts in cluster (default '${DEFAULT_SYSTEMS_FILE}')"
echo -e "   REMOTE_COMMAND_OPTION   Commands with '+' support options\n"
if ! [ "${REMOTE_COMMAND_OPTION}" == "" ] ; then echo -e "\n   ${BOLD}[INFO]${NORMAL}  Environment Variable ${BOLD}REMOTE_COMMAND_OPTION${NORMAL} is set to >${BOLD}${REMOTE_COMMAND_OPTION}${NORMAL}<"  ; else echo -e "   PREDEFINED-COMMAND that support environment variable ${BOLD}REMOTE_COMMAND_OPTION${NORMAL} are\n   marked with ${BOLD}+${NORMAL}" ; fi

echo -e "\n${BOLD}OPTIONS${NORMAL}"
echo -e "Order of precedence: CLI options, environment variable, default code.\n"
echo    "   REMOTE_COMMAND_OPTION   Commands with '+' support options"

###  Production standard 6.1.177 Architecture tree
echo -e "\n${BOLD}ARCHITECTURE TREE${NORMAL}"  # STORAGE & CERTIFICATION
echo    "/usr/local/data/                           <-- <DATA_DIR>"
echo    "└── <CLUSTER>/                             <-- <CLUSTER>"
echo    "   └── SYSTEMS                             <-- List of hosts in cluster"

echo -e "\n${BOLD}PREDEFINED-COMMAND${NORMAL}"  # 
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
echo    "                       echo '${BOLD}reboot required${NORMAL}' ; else"
echo    "                       echo '${BOLD}no reboot required${NORMAL}' ; fi"
echo    "      dist-upgrade   - sudo apt-get dist-upgrade --assume-yes ;"
echo    "                       if [ -f /var/run/reboot-required ] ; then"
echo    "                       echo '${BOLD}reboot required${NORMAL}' ; else"
echo    "                       echo '${BOLD}no reboot required${NORMAL}' ; fi"
echo    "      autoremove     - sudo apt-get autoremove --assume-yes"
echo    "      showhold       - apt-mark showhold"
echo    "      unhold         - apt-mark unhold"
echo    "      hold           - apt-mark hold"
echo    "      require-reboot - if [ -f /var/run/reboot-required ]; then echo '${BOLD}reboot"
echo    "                       required${NORMAL}' ; else echo '${BOLD}no reboot required${NORMAL}' ; fi"
echo    "      require-upgrade - /usr/lib/update-notifier/apt-check --human-readable" # >>> not sure this is the correct command becasue one-rpi3b stated no upgrade but then did eight upgrades #12
echo    "      upgrade-package - apt-get upgrade --simulate | grep -vE 'Conf|Inst'"
echo    "                        apt list --upgradeable -> does not work on Ubuntu 14.04"
echo    "      disable-user   + sudo usermod --expiredate 1"  # disable user from logging in (including ssh)
echo    "      enable-user    + sudo usermod --expiredate ''" # enable user to login that was disabled
echo    "      special        + <REMOTE_COMMAND_OPTION>"
echo    "      root-special   + sudo <REMOTE_COMMAND_OPTION>"

echo -e "\n${BOLD}DOCUMENTATION${NORMAL}"
echo    "   https://github.com/BradleyA/Linux-admin/blob/master/cluster-command/README.md"

echo -e "\n${BOLD}EXAMPLES${NORMAL}"
echo -e "   Resynchronize package index files from their sources\n\t${BOLD}${COMMAND_NAME} update${NORMAL}"
echo -e "   Shutdown hosts in clusters\n\t${BOLD}${COMMAND_NAME} shutdown${NORMAL}"
echo -e "   Display disk space available on file system /tmp\n\t${BOLD}export REMOTE_COMMAND_OPTION=\"/tmp\"\n\t${COMMAND_NAME} df${NORMAL}\n   or\n\t${BOLD}${COMMAND_NAME} df /tmp${NORMAL}"
echo -e "   Remove log file that includes remote hostname\n\t${BOLD}export REMOTE_COMMAND_OPTION='rm  /usr/local/data/us-tx-cluster-1/log/\`hostname -f\`-crontab'\n\t${COMMAND_NAME} special${NORMAL}"
echo -e "   List files in /usr/local/bin directory\n\t${BOLD}${COMMAND_NAME} special 'ls -l /usr/local/bin/*'${NORMAL}"
echo -e "   Check public, private keys, and CA for hosts in cluster\n\t${BOLD}${COMMAND_NAME} root-special check-host-tls.sh${NORMAL}"
}

#    Date and time function ISO 8601
get_date_stamp() {
  DATE_STAMP=$(date +%Y-%m-%dT%H:%M:%S.%6N%:z)
  TEMP=$(date +%Z)
  DATE_STAMP="${DATE_STAMP} (${TEMP})"
}

#    Fully qualified domain name FQDN hostname
LOCALHOST=$(hostname -f)

#    Version
#    Assumptions for the next two lines of code:  The second line in this script includes the script path & name as the second item and
#    the script version as the third item separated with space(s).  The tool I use is called 'markit'. See example line below:
#       template/template.sh  3.517.783  2019-09-13T18:20:42.144356-05:00 (CDT)  https://github.com/BradleyA/user-files.git  uadmin  one-rpi3b.cptx86.com 3.516  
SCRIPT_NAME=$(head -2 "${0}" | awk '{printf $2}')  #  Different from ${COMMAND_NAME}=$(echo "${0}" | sed 's/^.*\///'), SCRIPT_NAME = Git repository directory / COMMAND_NAME (for dev, test teams)
SCRIPT_VERSION=$(head -2 "${0}" | awk '{printf $3}')
if [[ "${SCRIPT_NAME}" == "" ]] ; then SCRIPT_NAME="${0}" ; fi
if [[ "${SCRIPT_VERSION}" == "" ]] ; then SCRIPT_VERSION="v?.?" ; fi

#    GID
GROUP_ID=$(id -g)

###  Production standard 2.3.529 log format (WHEN WHERE WHAT Version Line WHO UID:GID [TYPE] Message)
new_message() {  #  $1="${LINENO}"  $2="DEBUG INFO ERROR WARN"  $3="message"
  get_date_stamp
  echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${SCRIPT_NAME}[$$] ${SCRIPT_VERSION} ${1} ${USER} ${UID}:${GROUP_ID} ${BOLD}[${2}]${NORMAL}  ${3}"
}

#    INFO
new_message "${LINENO}" "${YELLOW}INFO${WHITE}" "  Started..." 1>&2

#    Added following code because USER is not defined in crobtab jobs
if ! [[ "${USER}" == "${LOGNAME}" ]] ; then  USER=${LOGNAME} ; fi
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  Setting USER to support crobtab...  USER >${USER}<  LOGNAME >${LOGNAME}<" 1>&2 ; fi

#    DEBUG
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  Name_of_command >${SCRIPT_NAME}< Name_of_arg1 >${1}< Name_of_arg2 >${2}< Name_of_arg3 >${3}<  Version of bash ${BASH_VERSION}" 1>&2 ; fi

###  Production standard 9.3.513 Parse CLI options and arguments
while [[ "${#}" -gt 0 ]] ; do
  case "${1}" in
    --help|-help|help|-h|h|-\?)  display_help | more ; exit 0 ;;
    --usage|-usage|usage|-u)  display_usage ; exit 0  ;;
    --version|-version|version|-v)  echo "${SCRIPT_NAME} ${SCRIPT_VERSION}" ; exit 0  ;;
    *) break ;;
  esac
done

###

###  Production standard 7.0 Default variable value
#    Order of precedence: CLI argument, environment variable, default code
REMOTE_COMMAND=${1:-${DEFAULT_REMOTE_COMMAND}}
REMOTE_COMMAND_OPTION=${2:-${DEFAULT_REMOTE_COMMAND_OPTION}}
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  CLUSTER >${CLUSTER}<  DATA_DIR >${DATA_DIR}<  SYSTEMS_FILE >${SYSTEMS_FILE}< REMOTE_COMMAND >${REMOTE_COMMAND}< REMOTE_COMMAND_OPTION >${REMOTE_COMMAND_OPTION}< Number of options >$#<" 1>&2 ; fi
if [[ "${CLUSTER}" == "" ]] ; then CLUSTER=${DEFAULT_CLUSTER} ; fi
if [[ "${DATA_DIR}" == "" ]] ; then DATA_DIR=${DEFAULT_DATA_DIR} ; fi
if [[ "${SYSTEMS_FILE}" == "" ]] ; then SYSTEMS_FILE=${DEFAULT_SYSTEMS_FILE} ; fi
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  CLUSTER >${CLUSTER}<  DATA_DIR >${DATA_DIR}<  SYSTEMS_FILE >${SYSTEMS_FILE}< REMOTE_COMMAND >${REMOTE_COMMAND}< REMOTE_COMMAND_OPTION >${REMOTE_COMMAND_OPTION}< Number of options >$#<" 1>&2 ; fi

if [[ "$1" == "special" ]] || [[ "$1" == "root-special" ]] && ! [[ $# == "2" ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  Command not found after special|root-special." 1>&2
  exit 1
fi

#    Check if ${SYSTEMS_FILE} file is on system, one FQDN or IP address per line for all hosts in cluster
if ! [[ -e ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE} ]] || ! [[ -s ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE} ]] ; then
  new_message "${LINENO}" "${YELLOW}WARN${WHITE}" "  ${BOLD}${SYSTEMS_FILE} file missing or empty, creating ${SYSTEMS_FILE} file with local host.  Edit ${DATA_DIR}/${CLUSTER}/${SYSTEMS_FILE} file and add additional hosts that are in the cluster.${NORMAL}" 1>&2
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
  shutdown) REMOTE_COMMAND="sudo shutdown -f now" ;;
  reboot) REMOTE_COMMAND="sudo reboot ${REMOTE_COMMAND_OPTION}" ;;
  OS|os) REMOTE_COMMAND="lsb_release -d" ;;
  CPU|cpu) REMOTE_COMMAND="lscpu" ;;
  date) REMOTE_COMMAND="date ${REMOTE_COMMAND_OPTION}" ;;
  df) REMOTE_COMMAND="df ${REMOTE_COMMAND_OPTION}" ;;
  last) REMOTE_COMMAND="lastlog | grep -v '**Never logged in**'" ;;
  who) REMOTE_COMMAND="who ${REMOTE_COMMAND_OPTION}" ;;
  ip) REMOTE_COMMAND="ip a" ;;
  netstat) REMOTE_COMMAND="sudo netstat -natup" ;;
  uptime) REMOTE_COMMAND="uptime ${REMOTE_COMMAND_OPTION}" ;;
  docker-version) REMOTE_COMMAND="docker version | grep 'Version:'" ;;
  docker-release) REMOTE_COMMAND="grep docker /etc/apt/sources.list" ;;
  docker-df) REMOTE_COMMAND="docker system df" ;;
  docker-df-v) REMOTE_COMMAND="docker system df --verbose" ;;
  docker-info) REMOTE_COMMAND="docker system info ${REMOTE_COMMAND_OPTION}" ;;
  docker-info-con) REMOTE_COMMAND="docker system info | head -6" ;;
  docker-info-swarm) REMOTE_COMMAND="docker system info | grep -i swarm" ;;
  docker-con-ls) REMOTE_COMMAND="docker container ls ${REMOTE_COMMAND_OPTION}" ;;
  docker-ima-ls) REMOTE_COMMAND="docker images ${REMOTE_COMMAND_OPTION}" ;;
  docker-net-ls) REMOTE_COMMAND="docker network ls ${REMOTE_COMMAND_OPTION}" ;;
  docker-vol-ls) REMOTE_COMMAND="docker volume ls ${REMOTE_COMMAND_OPTION}" ;;
  docker-ima-clean) REMOTE_COMMAND="docker image rm \$(docker image ls --filter='dangling=true' -q)" ;;
  docker-vol-clean) REMOTE_COMMAND="docker volume rm \$(docker volume ls --filter dangling=true -q)" ;;
  docker-net-prune) REMOTE_COMMAND="docker network prune ${REMOTE_COMMAND_OPTION}" ;;
  docker-vol-prune) REMOTE_COMMAND="docker volume prune ${REMOTE_COMMAND_OPTION}" ;;
  docker-all-prune) REMOTE_COMMAND="docker system prune ${REMOTE_COMMAND_OPTION}" ;;
  update) REMOTE_COMMAND="sudo apt-get update ; /usr/lib/update-notifier/apt-check --human-readable" ;;
  upgrade) REMOTE_COMMAND="sudo apt-get upgrade --assume-yes ; if [[ -f /var/run/reboot-required ]] ; then echo -e '\t${BOLD}${RED}reboot required${PURPLE}' ; else echo -e '\t${BOLD}${GREEN}no reboot required${NORMAL}' ; fi" ;;
  dist-upgrade) REMOTE_COMMAND="sudo apt-get dist-upgrade --assume-yes ; if [[ -f /var/run/reboot-required ]] ; then echo -e '\t${BOLD}${RED}reboot required${PURPLE}' ; else echo -e '\t${BOLD}${GREEN}no reboot required${NORMAL}' ; fi" ;;
  autoremove) REMOTE_COMMAND="sudo apt-get autoremove  --assume-yes" ;;
  showhold) REMOTE_COMMAND="apt-mark showhold" ;;
  unhold) REMOTE_COMMAND="apt-mark unhold ${REMOTE_COMMAND_OPTION}" ;;
  hold) REMOTE_COMMAND="apt-mark hold ${REMOTE_COMMAND_OPTION}" ;;
  require-reboot) REMOTE_COMMAND="if [ -f /var/run/reboot-required ]; then echo '${BOLD}${RED}reboot required${PURPLE}' ; else echo '${BOLD}${GREEN}no reboot required${NORMAL}' ; fi" ;;
  require-upgrade|require-update) REMOTE_COMMAND="/usr/lib/update-notifier/apt-check --human-readable" ;;
  upgrade-package) REMOTE_COMMAND="apt-get upgrade --simulate  | grep -vE 'Conf|Inst'" ;;
  disable-user) echo -e "\n\tEnter user login name to disable" ; read USER_LOGIN : REMOTE_COMMAND="sudo usermod --expiredate 1 ${USER_LOGIN}" ;;
  enable-user) echo -e "\n\tEnter user login name to re-enable" ; read USER_LOGIN ; REMOTE_COMMAND="sudo usermod --expiredate '' ${USER_LOGIN}" ;;
  special) REMOTE_COMMAND="${REMOTE_COMMAND_OPTION}" ;;
  root-special) REMOTE_COMMAND="sudo ${REMOTE_COMMAND_OPTION}" ;;
  *)  new_message "${LINENO}" "${YELLOW}INFO${NORMAL}" "  ${REMOTE_COMMAND} - NOT a supported command" 1>&2
    exit 0
    ;;
esac

if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  REMOTE_HOST >${REMOTE_HOST}<" 1>&2 ; fi

#    is LOCALHOST included in ${REMOTE_HOST} list #26
CHECK_LOCALHOST=0
#
for NODE in ${REMOTE_HOST} ; do
  if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  NODE  >${NODE}<" 1>&2 ; fi
  if [[ "${LOCALHOST}" != "${NODE}" ]] ; then
    echo -e "\n${BOLD}  =-->  ${CYAN}${NODE}${WHITE}	->${PURPLE}${REMOTE_COMMAND}${WHITE}<-" 
    ssh -t "${USER}"@"${NODE}" "echo -n ${BOLD} ${YELLOW} ; ${REMOTE_COMMAND} ; echo -n ${WHITE}"
  else
    CHECK_LOCALHOST=1
  fi
done
if [[ "${CHECK_LOCALHOST}" == "1" ]] ; then
  echo -e "\n${BOLD}  -->  ${CYAN}${LOCALHOST}${WHITE}	->${PURPLE}${REMOTE_COMMAND}${WHITE}<-${YELLOW}"
  eval "${REMOTE_COMMAND}"
  echo -n "${NORMAL}"
fi

#
new_message "${LINENO}" "${YELLOW}INFO${WHITE}" "  Operation finished..." 1>&2
###
