#!/bin/bash
# 	github-repository-traffic/parse.repository.data.sh  2.117.523  2020-02-08T21:41:08.858633-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.116-11-gef74032  
# 	   github-repository-traffic/parse.repository.data.sh    check if filename not found; ERROR; exit 1; exit 1 close #35 
# 	github-repository-traffic/parse.repository.data.sh  2.116.511  2020-02-08T12:24:01.364285-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.115-2-g9edbebe  
# 	   github-repository-traffic/parse.repository.data.sh   Upgrade all Production standards close #33 
# 	github-repository-traffic/parse.repository.data.sh  2.114.497  2020-02-06T22:58:58.814782-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.113-1-g9797258  
# 	   github-repository-traffic/parse.repository.data.sh   update display_help and ARCHITECTURE TREE 
# 	github-repository-traffic/parse.repository.data.sh  2.113.495  2020-02-06T00:06:05.666514-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.112  
# 	   github-repository-traffic/parse.repository.data.sh   create display_help description #33 
# 	github-repository/parse.repository.data.sh  2.98.370  2019-08-08T23:47:37.538761-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.97  
# 	   github-repository/parse.repository.data.sh design complete, ready to create test cases 
### >>> Need to move this design information into the documentation and then remove from here <<<
# >>>	Remove when complete
#               push files to images/clone.table.md images/view.table.md to github owner/repository/images/(clones,views, NOT popular.referrers.list, popular.paths.list)
#               link *.table.md to README.md badges
#        .... NOTE to self ..... need data first and do'nt want to waste time creating test data ....  come back in a month or six
#
#	column -t -s' ' filename
#	soffice --convert-to png ./clones
#	display ./clones.png
#
#       <img alt="Steam Views" src="https://img.shields.io/steam/views/100">
#
#       cd ~/github/BradleyA/automate/:repo
#       git pull
#       git commit -m '$DATE: automation the update of README table' README.md
#       git push README.md
###
# >>>	Remove when complete
#86# github-repository-data/parse.repository.data.sh
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
GREEN=$(tput  setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput   setaf 6)
WHITE=$(tput  setaf 7)

###  Production standard 7.0 Default variable value
DEFAULT_DATA_GITHUB_DIR="/usr/local/data/github/"
GITHUB_OWNER="BradleyA"
GITHUB_REPOSITORY_TRAFFIC_DATA=""
YEAR=$(date +%G)  #  short and long term stroage strategy
TODAY=$(date +%Y-%m-%d)

###  Production standard 8.3.541 --usage
COMMAND_NAME=$(echo "${0}" | sed 's/^.*\///')                                               # 3.541
display_usage() {
echo -e "\n${NORMAL}${COMMAND_NAME}\n   Parse relevant data from owner.repository output"
echo -e "\n${BOLD}USAGE${NORMAL}"
echo    "   ${YELLOW}Positional Arguments${NORMAL}"
echo -e "   ${COMMAND_NAME}  <GITHUB_REPOSITORY_TRAFFIC_DATA>\n"
echo    "   ${COMMAND_NAME} [--help | -help | help | -h | h | -?]"
echo    "   ${COMMAND_NAME} [--usage | -usage | -u]"
echo    "   ${COMMAND_NAME} [--version | -version | -v]"
}

###  Production standard 0.3.572 --help                                                     # 3.572
display_help() {
display_usage
#    Displaying help DESCRIPTION in English en_US.UTF-8, en.UTF-8, C.UTF-8                  # 3.550
echo -e "\n${BOLD}DESCRIPTION${NORMAL}"
echo -e "\nParse relevant data from owner.repository (cron) output data file to create"
echo    "[clone,view].table.md, [clone,view].total, and [clone,view].<DATE> files."
echo    "These files ([clone,view].table.md, [clone,view].total) are used to update"
echo    "your <GITHUB_OWNER>/<REPOSITORY>/README.md file on GitHub.   A copy of the"
echo    "[clone,view].table.md file will be copied to <GITHUB_OWNER>/<REPOSITORY>/images"
echo    "directory in future automation upgrades.  The [clone,view].<DATE> file contains"
echo    "one column of formated data to be used in [clone,view].table.md file."
echo -e "\nThe default cron output data file is ${DEFAULT_DATA_GITHUB_DIR}<GITHUB_OWNER>/"
echo    "<REPOSITORY>/<GITHUB_OWNER>.<REPOSITORY>.<date>.  This cron output data file is"
echo    "created with owner.repository script linked to <GITHUB_OWNER>.<REPOSITORY>.  It"
echo    "is scheduled to run once a week using crontab but can be scheduled more or less"
echo    "often."

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

# >>>	Remove when complete
echo    ">>> NEED TO COMPLETE THIS SOON, ONCE I KNOW HOW IT IS GOING TO WORK :-) <<<    |"

echo    "   CLONE_FILE_NAME Cron job data file"
echo    "                   (default ${DEFAULT_DATA_GITHUB_DIR}<GITHUB_OWNER>/<REPOSITORY>/<GITHUB_OWNER>.<REPOSITORY>.<date>)"
echo    "   GITHUB_REPOSITORY_TRAFFIC_DATA"
echo    "                   X"
# >>>	Remove when complete

echo -e "\n${BOLD}OPTIONS${NORMAL}"
echo -e "Order of precedence: CLI options, environment variable, default value.\n"     # 3.572
echo    "   --help, -help, help, -h, h, -?"                                            # 3.572
echo -e "\tOn-line brief reference manual\n"                                           # 3.572
echo    "   --usage, -usage, -u"                                                       # 3.572
echo -e "\tOn-line command usage\n"                                                    # 3.572
echo    "   --version, -version, -v]"                                                  # 3.572
echo -e "\tOn-line command version"                                                  # 3.572
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
echo    "   https://github.com/BradleyA/Linux-admin/tree/master/github-repository-traffic#github-repository-traffic"

echo -e "\n${BOLD}EXAMPLES${NORMAL}"
echo -e "   Parse relevant data from cron output data file." # 3.550
echo -e "\t${BOLD}${COMMAND_NAME} ../../<GITHUB_OWNER>.<REPOSITORY>.${TODAY}${NORMAL}" # 3.550

echo -e "\n${BOLD}SEE ALSO${NORMAL}"                                                        # 3.550
echo    "   ${BOLD}setup.github.repository.sh${NORMAL} (https://github.com/BradleyA/Linux-admin/tree/master/github-repository-traffic#install)"

# >>>	Remove when complete
echo    ">>> NEED TO COMPLETE THIS SOON, ONCE I KNOW HOW IT IS GOING TO WORK :-) <<<    |"
echo    "   ${BOLD}owner.repository${NORMAL} (URL)"
echo    "   ${BOLD}<command>${NORMAL} (URL)"
# >>>	Remove when complete

echo -e "\n${BOLD}AUTHOR${NORMAL}"                                                          # 3.550
echo    "   ${COMMAND_NAME} was written by Bradley Allen <allen.bradley@ymail.com>"         # 3.550

echo -e "\n${BOLD}REPORTING BUGS${NORMAL}"                                                  # 3.550
echo    "   Report ${COMMAND_NAME} bugs https://github.com/BradleyA/Linux-admin/issues/new?assignees=BradleyA&labels=bug&template=incident-report.md&title=%5Benter+command+causing+incident%5D+-+%5Benter+brief+description%5D"  # 3.550

###  Production standard 5.3.559 Copyright                                            # 3.559
echo -e "\n${BOLD}COPYRIGHT${NORMAL}"                                                       # 3.550
echo    "   Copyright (c) 2020 Bradley Allen"                                               # 3.550
echo    "   MIT License is online in the repository as a file named LICENSE"          # 3.559
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

###  Production standard 2.3.529 Log format (WHEN WHERE WHAT Version Line WHO UID:GID [TYPE] Message)
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

###  Production standard 9.3.562 Parse CLI options and arguments
while [[ "${#}" -gt 0 ]] ; do
  case "${1}" in
    --help|-help|help|-h|h|-\?)  display_help | more ; exit 0 ;;
    --usage|-usage|usage|-u)  display_usage ; exit 0  ;;
    --version|-version|version|-v)  echo "${SCRIPT_NAME} ${SCRIPT_VERSION}" ; exit 0  ;;
#    echo -e "\n${BOLD}    Option, ${YELLOW}${1}${WHITE}, is not supported.  Try  ${YELLOW}${COMMAND_NAME} --usage${NORMAL}\n" ; exit 1 ; ;;
# OR
    *) break ;;
  esac
done
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  Variable... ADMUSER >${ADMUSER}< CLUSTER >${CLUSTER}< DATA_DIR >${DATA_DIR}< FILE_NAME >${FILE_NAME}< SSH_USER >${SSH_USER}< USER_HOME >${USER_HOME}<" 1>&2 ; fi


#    Order of precedence: CLI argument, environment variable
if [[ $# -ge  1 ]]  ; then GITHUB_REPOSITORY_TRAFFIC_DATA=${1} ; elif [[ "${GITHUB_REPOSITORY_TRAFFIC_DATA}" == "" ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "<GITHUB_OWNER>.<REPOSITORY>.<date> is required to make this work.  Either as the first argument on the command line or defined as GITHUB_REPOSITORY_TRAFFIC_DATA environment variable."
  exit 1
fi

#    GITHUB_REPOSITORY_TRAFFIC_DATA FILE exists and read permission && exists and has a size greater than zero
if [[ ! -r "${GITHUB_REPOSITORY_TRAFFIC_DATA}" ]] || [[ ! -s "${GITHUB_REPOSITORY_TRAFFIC_DATA}"  ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  ${GITHUB_REPOSITORY_TRAFFIC_DATA} file does not exist, or does not have read permission, or has size of zero."
  exit 1
fi

#    Parse relevant data out of ${GITHUB_REPOSITORY_TRAFFIC_DATA}
grep -e clones -e timestamp -e count -e uniques -e views -e /popular/paths -e path -e title -e /popular/referrers -e '\]' -e '\['  "${GITHUB_REPOSITORY_TRAFFIC_DATA}" | sed -e 's/"//g' -e 's/,//g' -e 's/T.*Z//' -e 's/[ \t]*//g' > "${GITHUB_REPOSITORY_TRAFFIC_DATA}.no-headers"

#    Parse clones data from ${GITHUB_REPOSITORY_TRAFFIC_DATA}.no-headers
cat  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.no-headers" | sed -e '1,/views>>>/!d' -e '1,/clones:\[/d' -e '/^\]/,$d'  > "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp"
#    Loop through ${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp and create clone.data.$timestamp files
while read line; do
  FIRST_WORD=$(echo "${line}" | cut -d: -f 1)
  if [[ "${FIRST_WORD}" == "timestamp" ]] ;  then
    SECOND_WORD=$(echo "${line}" | cut -d: -f 2)
    CLONE_FILE_NAME="clone.data.${SECOND_WORD}"
    tmp=$(echo "${line}" | cut -d: -f 2 | cut -d\- -f 2-3)
    echo "| ${tmp}" > "${CLONE_FILE_NAME}"
    echo "|:---:" >> "${CLONE_FILE_NAME}"
  else
    AMOUNT=$(echo "${line}" | cut -d: -f 2)
    echo "| ${AMOUNT}" >> "${CLONE_FILE_NAME}"
  fi
done < "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp"
#if [[ "${DEBUG}" == "0" ]] ; then rm  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp" ; fi  #  Remove file if DEBUG is not set
rm  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp"
CLONE_TOTAL=0
# >>>	Do clone.data.* files exists and size greater than zero
# >>>	need to test this create an empty file in a repository that has many data file ????
if ls clone.data.* 1>/dev/null 2>&1 ; then
#    Total third line of clone.data.* files
  CLONE_TOTAL=$(awk 'FNR == 3 {total+=$2} END {print total}'  clone.data.*)
  echo "${CLONE_TOTAL}" > clone.total
  paste -d ' ' ../../clone.heading clone.data.* | column -t -s' ' > clone.table.md
  sed -i '1 i\#### Git clones' clone.table.md
fi
echo -e "\nTotal clones: ${CLONE_TOTAL}\n###### Updated: $(date +%Y-%m-%d)"  >> clone.table.md

#    Parse vistors (views) data from ${GITHUB_REPOSITORY_TRAFFIC_DATA}.no-headers
cat  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.no-headers" | sed -e '1,/\/popular\/paths>>>/!d' -e '1,/views:\[/d' -e '/^\]/,$d'  > "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp"
#    Loop through ${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp and create clone.data.$timestamp files
while read line; do
  FIRST_WORD=$(echo "${line}" | cut -d: -f 1)
  if [[ "${FIRST_WORD}" == "timestamp" ]] ;  then
    SECOND_WORD=$(echo "${line}" | cut -d: -f 2)
    VIEW_FILE_NAME="view.data.${SECOND_WORD}"
    tmp=$(echo "${line}" | cut -d: -f 2 | cut -d\- -f 2-3)
    echo "| ${tmp}" > "${VIEW_FILE_NAME}"
   echo "|:---:" >> "${VIEW_FILE_NAME}"
  else
   AMOUNT=$(echo "${line}" | cut -d: -f 2)
   echo "| ${AMOUNT}" >> "${VIEW_FILE_NAME}"
  fi
done < "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp"
#	if [[ "${DEBUG}" == "0" ]] ; then rm  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp" ; fi  #  Remove file if DEBUG is not set
rm  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp"
VIEW_TOTAL=0
# >>>	Do view.data.* files exists and size greater than zero
# >>>   need to test this create an empty file in a repository that has many data file ????
if ls view.data.* 1>/dev/null 2>&1 ; then
#    Total third line of view.data.* files
  VIEW_TOTAL=$(awk 'FNR == 3 {total+=$2} END {print total}'  view.data.*)
  echo "${VIEW_TOTAL}"  > view.total
  paste -d ' ' ../../view.heading view.data.* | column -t -s' ' > view.table.md
  sed -i '1 i\#### Visitors' view.table.md
fi
echo -e "\nTotal views: ${VIEW_TOTAL}\n###### Updated: $(date +%Y-%m-%d)"  >> view.table.md
#	if [[ "${DEBUG}" == "0" ]] ; then rm  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.no-headers" ; fi  #  Remove file if DEBUG is not set
rm  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.no-headers"

#
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  Operation finished..." 1>&2 ; fi
###
