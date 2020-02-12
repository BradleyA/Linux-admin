#!/bin/bash
# 	github-repository-traffic/setup.github.repository.sh  2.126.549  2020-02-12T12:38:21.881162-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.125-8-gf0169cc  
# 	   github-repository-traffic/setup.github.repository.sh   Upgrade all Production standards close #42 
# 	github-repository-traffic/setup.github.repository.sh  2.125.540  2020-02-12T12:13:22.720817-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.124-2-g74d5be4  
# 	   github-repository-traffic/parse.repository.data.sh   complete display_help SEE ALSO close #38 
# 	github-repository-traffic/setup.github.repository.sh  2.124.537  2020-02-11T23:17:01.593001-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.123-3-g9a8c5b4  
# 	   github-repository-traffic/setup.github.repository.sh   update display_help  close #41 
# 	github-repository-traffic/setup.github.repository.sh  2.123.533  2020-02-10T16:54:57.222050-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.122-1-g3700670  
# 	   github-repository-traffic/setup.github.repository.sh   setup GITHUB_OWNER environment variable close #34 
# 	github-repository-traffic/setup.github.repository.sh  2.114.497  2020-02-06T22:58:58.962412-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.113-1-g9797258  
# 	   github-repository-traffic/parse.repository.data.sh   update display_help and ARCHITECTURE TREE 
# 	github-repository-traffic/setup.github.repository.sh  2.110.422  2020-01-02T14:29:22.707637-06:00 (CST)  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 2.109-32-gf918a75  
# 	   github-repository-traffic/setup.github.repository.sh   upgrade script Production standards 
# 	github-repository/setup.github.repository.sh  2.80.291  2019-08-05T10:49:54.851588-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.79-1-g07eb720  
# 	   github-repository/setup.github.repository.sh add code for clone.heading & view.heading 
# 	github-repository/setup.github.repository.sh  2.45.209  2019-07-29T22:54:36.803070-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.44  
# 	   github-repository/setup.github.repository.sh making this up as I go . . . 
##########
###	https://github.com/isaacs/github/issues/399	###
##########
###  Production standard 3.0 shellcheck
###  Production standard 5.3.559 Copyright                                    # 3.559
#    Copyright (c) 2020 Bradley Allen                                                # 3.555
#    MIT License is online in the repository as a file named LICENSE"         # 3.559
###  Production standard 1.3.550 DEBUG variable                                             # 3.550
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
YELLOW=$(tput setaf 3)
CYAN=$(tput   setaf 6)
WHITE=$(tput  setaf 7)

### production standard 7.0 Default variable value
DEFAULT_DATA_GITHUB_DIR="/usr/local/data/github/"
DEFAULT_GITHUB_OWNER="BradleyA"  #  Required for this script to work.  Either as the first argument on the command line or defined as GITHUB_OWNER environment variable or hard coded here #34

###  Production standard 8.3.541 --usage
COMMAND_NAME=$(echo "${0}" | sed 's/^.*\///')                                               # 3.541
display_usage() {
echo -e "\n${NORMAL}${COMMAND_NAME}\n   Setup github repository traffic scripts"
echo -e "\n${BOLD}USAGE${NORMAL}"
echo -e "   ${COMMAND_NAME} [<GITHUB_OWNER>]\n"
echo    "   ${COMMAND_NAME} [--help | -help | help | -h | h | -?]"
echo    "   ${COMMAND_NAME} [--usage | -usage | -u]"
echo    "   ${COMMAND_NAME} [--version | -version | -v]"
}

###  Production standard 0.3.572 --help                                                     # 3.572
display_help() {
display_usage
#    Displaying help DESCRIPTION in English en_US.UTF-8, en.UTF-8, C.UTF-8                  # 3.550
echo -e "\n${BOLD}DESCRIPTION${NORMAL}"
echo -e "\nThis script works for the local host only.  This script creates directories"  #41
echo    "and copies github-repository-traffic files into those directories (see"
echo    "ARCHITECTURE TREE).  It reads github.repository.list file for your list of"
echo    "repositories that you want GitHub traffic.  It creates a symbolic link from"
echo    "<GITHUB_OWNER>.<REPOSITORY> to the script ../owner.repository and prints the"
echo    "lines to add to crontab."
echo -e "\nGitHub owner and github.repository.list are required for this script to work."
echo    "<GITHUB_OWNER> can be the first argument on the command line or defined as"
echo    "GITHUB_OWNER environment variable."
echo -e "\nData storage is required for this solution, so you need to have permission"
echo    "to create /usr/local/data/github for short and long term storage.  To use"
echo    "a different directory export DATA_GITHUB_DIR environment variable."
echo -e "\nIn the future, this printed crontab list will be appended to a crontab file."
echo    "The crontab command normally only manages a single crontab per user.  Need a"
echo    "method for multiple SRE team members to manage one crontab."

###  Production standard 4.3.550 Documentation Language                                     # 3.550
#    Displaying help DESCRIPTION in French fr_CA.UTF-8, fr_FR.UTF-8, fr_CH.UTF-8
if [[ "${LANG}" == "fr_CA.UTF-8" ]] || [[ "${LANG}" == "fr_FR.UTF-8" ]] || [[ "${LANG}" == "fr_CH.UTF-8" ]] ; then
  echo -e "\n--> ${LANG}"
  echo    "<votre aide va ici>" # your help goes here
  echo    "Souhaitez-vous traduire la section description?" # Do you want to translate the description section?
elif ! [[ "${LANG}" == "en_US.UTF-8" ||  "${LANG}" == "en.UTF-8" || "${LANG}" == "C.UTF-8" ]] ; then  # 3.550
  new_message "${LINENO}" "${YELLOW}INFO${WHITE}" "  Your language, ${LANG}, is not supported.  Would you like to translate the description section?" 1>&2
fi

echo -e "\n${BOLD}ENVIRONMENT VARIABLES${NORMAL}"
echo    "If using the bash shell, enter; 'export DEBUG=1' on the command line to set"
echo    "the environment variable DEBUG to '1' (0 = debug off, 1 = debug on).  Use the"
echo    "command, 'unset DEBUG' to remove the exported information from the environment"
echo    "variable DEBUG.  You are on your own defining environment variables if"
echo    "you are using other shells."

###  Production standard 1.3.550 DEBUG variable                                             # 3.550
echo    "   DEBUG           (default off '0')  The DEBUG environment variable can be set"   # 3.550
echo    "                   to 0, 1, 2, 3, 4 or 5.  The setting '' or 0 will turn off"      # 3.550
echo    "                   all DEBUG messages during execution of this script.  The"       # 3.550
echo    "                   setting 1 will print all DEBUG messages during execution."      # 3.550
echo    "                   Setting 2 (set -x) will print a trace of simple commands"       # 3.550
echo    "                   before they are executed.  Setting 3 (set -v) will print"       # 3.550
echo    "                   shell input lines as they are read.  Setting 4 (set -e) will"   # 3.550
echo    "                   exit immediately if non-zero exit status is recieved with"      # 3.550
echo    "                   some exceptions.  Setting 5 (set -e -o pipefail) will do"       # 3.550
echo    "                   setting 4 and exit if any command in a pipeline errors.  For"   # 3.550
echo    "                   more information about the set options, see man bash."          # 3.550
#
echo    "   GITHUB_OWNER    Github repository account name (default ${DEFAULT_GITHUB_OWNER})" #34
echo    "   DATA_GITHUB_DIR GitHub long term traffic solution directory"
echo    "                   (default ${DEFAULT_DATA_GITHUB_DIR})"

echo -e "\n${BOLD}OPTIONS${NORMAL}"
echo -e "Order of precedence: CLI options, environment variable, default value.\n"     # 3.572
echo    "   --help, -help, help, -h, h, -?"                                            # 3.572
echo -e "\tOn-line brief reference manual\n"                                           # 3.572
echo    "   --usage, -usage, -u"                                                       # 3.572
echo -e "\tOn-line command usage\n"                                                    # 3.572
echo    "   --version, -version, -v]"                                                  # 3.572
echo -e "\tOn-line command version"                                                    # 3.572
#

###  Production standard 6.3.547  Architecture tree
echo -e "\n${BOLD}ARCHITECTURE TREE${NORMAL}"  # STORAGE & CERTIFICATION
echo    "/usr/local/data/                           <-- <DATA_DIR>"
echo    "└── github                                 <-- GitHub long term traffic solution"
echo    "    ├── clone.heading                      <-- Clone table headings"
echo    "    ├── github.repository.list             <-- GitHub repository names"
echo    "    ├── owner.repository                   <-- Default cron job for repository"
echo    "    │                                          download of GitHub traffic data"
echo    "    ├── parse.repository.data.sh           <-- Parse relevant data out of cron"
echo    "    │                                          job data file"
echo    "    ├── setup.github.repository.sh         <-- Setup GitHub long term traffic"
echo    "    │                                          solution"
echo    "    ├── view.heading                       <-- View table headings"
echo    "    ├── <GITHUB_OWNER>                     <-- Links to ../owner.repository"
echo    "    │   ├── <REPOSITORY-1>                 <-- Current year of GitHub repository"
echo    "    │   │   │                                  traffic data"
echo    "    │   │   └── <YEAR>                     <-- Previous years of GitHub"
echo    "    │   │                                      repository traffic data"
echo    "    │   └── <REPOSITORY-2>                 <-- Current year of GitHub repository"
echo    "    │                                          traffic data"
echo    "    └── <GITHUB_OWNER>                     <-- Links to ../owner.repository"

echo -e "\n${BOLD}DOCUMENTATION${NORMAL}"
echo    "   https://github.com/BradleyA/Linux-admin/blob/master/github-repository-traffic/README.md#github-repository-traffic"

echo -e "\n${BOLD}EXAMPLES${NORMAL}"
echo -e "   Setup the GitHub repository traffic on this system\n\t${BOLD}${COMMAND_NAME} <GITHUB_OWNER>${NORMAL}\n" # 3.550

echo -e "\n${BOLD}SEE ALSO${NORMAL}"                                                        # 3.550
echo    "   ${BOLD}github.repository.list${NORMAL} (https://github.com/BradleyA/Linux-admin/blob/master/github-repository-traffic/README.md#download-files)"
echo    "   ${BOLD}owner.repository${NORMAL} (https://github.com/BradleyA/Linux-admin/blob/master/github-repository-traffic/README.md#download-files)"
echo    "   ${BOLD}parse.repository.data.sh${NORMAL} (https://github.com/BradleyA/Linux-admin/tree/master/github-repository-traffic#install)"

echo -e "\n${BOLD}AUTHOR${NORMAL}"                                                          # 3.550
echo    "   ${COMMAND_NAME} was written by Bradley Allen <allen.bradley@ymail.com>"         # 3.550

echo -e "\n${BOLD}REPORTING BUGS${NORMAL}"                                                  # 3.550
echo    "   Report ${COMMAND_NAME} bugs https://github.com/BradleyA/Linux-admin/issues/new/choose"  # 3.550

###  Production standard 5.3.550 Copyright                                                  # 3.550
echo -e "\n${BOLD}COPYRIGHT${NORMAL}"                                                       # 3.550
echo    "   Copyright (c) 2020 Bradley Allen"                                               # 3.550
echo    "   MIT License https://github.com/BradleyA/user-files/blob/master/LICENSE"         # 3.550
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
SCRIPT_NAME=$(head -2 "${0}" | awk '{printf $2}')  #  Different from ${COMMAND_NAME}=$(echo "${0}" | sed 's/^.*\///'), SCRIPT_NAME = includes Git repository directory and can be used any where in script (for dev, test teams)
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
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "${YELLOW}INFO${WHITE}" "  Started..." 1>&2 ; fi

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

###  Setup.github.repository.sh

###  production standard 7.0 Default variable value
#    Order of precedence: CLI argument, environment variable, default code
if [[ $# -ge  1 ]]  ; then GITHUB_OWNER=${1} ; elif [[ "${GITHUB_OWNER}" == "" ]] ; then GITHUB_OWNER=${DEFAULT_GITHUB_OWNER} ; fi #34
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  Variable... GITHUB_OWNER >${GITHUB_OWNER}<" 1>&2 ; fi
#    Order of precedence: environment variable, default code
if [[ "${DATA_GITHUB_DIR}" == "" ]] ; then DATA_GITHUB_DIR=${DEFAULT_DATA_GITHUB_DIR} ; fi
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  Variable... DATA_GITHUB_DIR >${DATA_GITHUB_DIR}<" 1>&2 ; fi

#    Create log directory for crontab ${GITHUB_OWNER} jobs
mkdir -p "${DATA_GITHUB_DIR}/${GITHUB_OWNER}/log" || { new_message "${LINENO}" "${RED}ERROR${WHITE}" "  ${DATA_GITHUB_DIR}/${GITHUB_OWNER} was not created maybe permission incident." 1>&2 ; exit 1; }

#    Check if github.repository.list file size>0 and the file is readable
if [[ ! -s "github.repository.list" ]] && [[ -r "github.repository.list" ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  github.repository.list file does not exist in directory or is not size>0 or is not readable.  github.repository.list file should include Github owner's repository names, one per line." 1>&2
  exit 1
fi
cp -p  github.repository.list "${DATA_GITHUB_DIR}"

#    Check if owner.repository file size>0 and the file is readable
if [[ ! -s "owner.repository" ]] && [[ -r "owner.repository" ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  owner.repository file does not exist in directory or is not size>0 or is not readable" 1>&2
  exit 1
fi
cp -p  owner.repository "${DATA_GITHUB_DIR}"
cp -p  setup.github.repository.sh "${DATA_GITHUB_DIR}"

#    Check if parse.repository.data.sh file size>0 and the file has execute permission
if [[ ! -s "parse.repository.data.sh" ]] && [[ -x "parse.repository.data.sh" ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  parse.repository.data.sh file does not exist in directory or is not size>0 or is not executable" 1>&2
  exit 1
fi
cp -p  parse.repository.data.sh "${DATA_GITHUB_DIR}"

#    Check if clone.heading file size>0 and the file is readable
if [[ ! -s "clone.heading" ]] && [[ -r "clone.heading" ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  clone.heading file does not exist in directory or is not size>0 or is not readable" 1>&2
  exit 1
fi
cp -p  clone.heading "${DATA_GITHUB_DIR}"

#    Check if view.heading file size>0 and the file is readable
if [[ ! -s "view.heading" ]] && [[ -r "view.heading" ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  view.heading file does not exist in directory or is not size>0 or is not readable" 1>&2
  exit 1
fi
cp -p  view.heading "${DATA_GITHUB_DIR}"

cd "${DATA_GITHUB_DIR}"
echo    "${BOLD}${YELLOW}Add the follow line(s) to crontab using crontab -e	----->${CYAN}"
#    Loop through repository names in github.repository.list	
for REPOSITORY in $(cat "${DATA_GITHUB_DIR}"/github.repository.list | grep -v "#" ); do
  #  Create symbolic link owner.repository <-- for(repository.list) to BradleyA.Start-registry-v2-script.1.0
  ln -sf ../owner.repository "${GITHUB_OWNER}/${GITHUB_OWNER}.${REPOSITORY}"
  echo    "20 12 * * MON   ${DATA_GITHUB_DIR}/${GITHUB_OWNER}/${GITHUB_OWNER}.${REPOSITORY}  >>  ${DATA_GITHUB_DIR}/${GITHUB_OWNER}/log/${GITHUB_OWNER}.${REPOSITORY}-crontab" 2>&1

# >>>	Remove when complete		#40
#	  tmp_file=$(mktemp repository.data.crontab.XXX)  ####	add before for loop
#	  crontab -l > tmp_file   #  Write out current crontab to a temp file  ####	add before for loop
#	  echo "00 09 * * 1-5 echo hello" >> tmp_file  #  Echo new cron lines into temp file  ####      add IN for loop
#	  crontab tmp_file  #  Install new cron file  ####	add after for loop
#	  rm tmp_file  ####      add after for loop
# >>>	Remove when complete		#40

done

# >>>	Remove when complete		#
#	add user hint about token so crontab will work
# >>>	Remove when complete		#

if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "${YELLOW}INFO${WHITE}" "  Operation finished..." 1>&2 ; fi
###
