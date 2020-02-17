#!/bin/bash
# 	github-repository-traffic/parse.repository.data.sh  3.1.1.628  2020-02-16T21:26:27.185252-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.131  
# 	   Include GitHub repository traffic data in README close #29 
# 	github-repository-traffic/parse.repository.data.sh  2.130.624  2020-02-16T17:37:37.704997-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.129-16-g9f56c17 
# 	   github-repository-traffic/parse.repository.data.sh   Complete display_help ENVIRONMENT VARIABLES close #37 
# 	github-repository-traffic/parse.repository.data.sh  2.127.550  2020-02-12T14:12:16.766170-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.126  
# 	   github-repository-traffic/parse.repository.data.sh   [clone,view].data.* files exists and size greater than zero close #39 
# 	github-repository-traffic/parse.repository.data.sh  2.125.540  2020-02-12T12:13:22.621530-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.124-2-g74d5be4  
# 	   github-repository-traffic/parse.repository.data.sh   complete display_help SEE ALSO close #38 
# 	github-repository-traffic/parse.repository.data.sh  2.118.524  2020-02-08T21:50:46.421564-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.117  
# 	   github-repository-traffic/parse.repository.data.sh   add DEBUG around rm to preventing from being removed when DEBUG is not equal to 0  close #36 
# 	github-repository-traffic/parse.repository.data.sh  2.117.523  2020-02-08T21:41:08.858633-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.116-11-gef74032  
# 	   github-repository-traffic/parse.repository.data.sh    check if filename not found; ERROR; exit 1; exit 1 close #35 
# 	github-repository-traffic/parse.repository.data.sh  2.116.511  2020-02-08T12:24:01.364285-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.115-2-g9edbebe  
# 	   github-repository-traffic/parse.repository.data.sh   Upgrade all Production standards close #33 
# 	github-repository-traffic/parse.repository.data.sh  2.113.495  2020-02-06T00:06:05.666514-06:00 (CST)  https://github.com/BradleyA/Linux-admin.git  master  uadmin  five-rpi3b.cptx86.com 2.112  
# 	   github-repository-traffic/parse.repository.data.sh   create display_help description #33 
# 	github-repository/parse.repository.data.sh  2.98.370  2019-08-08T23:47:37.538761-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.97  
# 	   github-repository/parse.repository.data.sh design complete, ready to create test cases 
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
YELLOW=$(tput setaf 3)
WHITE=$(tput  setaf 7)

###  Production standard 7.0 Default variable value
DEFAULT_GITHUB_TRAFFIC_DIR="/usr/local/data/github/"
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
echo -e "\nParse output from owner.repository script to create [clone,view].table.md,"
echo    "[clone,view].total, and [clone,view].<DATE> files.  [clone,view].table.md is a"
echo    "markdown table organized in two rows; [Clones,Views] and [Unique clones,Unique"
echo    "vistors], with dated columns.  [clone,view].total file includes the total only."
echo    "[clone,view].<DATE> contains one column of markdown formated table data to be"
echo    "used in [clone,view].table.md file.  You can use the data in these files any"
echo    "way you want.  I have used them in my <GITHUB_OWNER>/<REPOSITORY>/README.md"
echo    "file and copied some files to <GITHUB_OWNER>/<REPOSITORY>/images directory.  In"
echo    "the future I want to automate a push of this data to GitHub repositories but"
echo    "that has many challenges (which branch, how much of a repository needs to be"
echo    "cloned to make a git push with new files, is someone editing README.md, etc)."
echo -e "\nThe output from owner.repository script that this script parses is located in"
echo    "${DEFAULT_GITHUB_TRAFFIC_DIR}/<GITHUB_OWNER>/<REPOSITORY>/"
echo    "<GITHUB_OWNER>.<REPOSITORY>.<date>."

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
echo    "   GITHUB_TRAFFIC_DIR GitHub long term traffic solution directory"
echo    "                   (default ${DEFAULT_GITHUB_TRAFFIC_DIR})"

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
echo    "   ${BOLD}github.repository.list${NORMAL} (https://github.com/BradleyA/Linux-admin/blob/master/github-repository-traffic/README.md#download-files)"
echo    "   ${BOLD}owner.repository${NORMAL} (https://github.com/BradleyA/Linux-admin/blob/master/github-repository-traffic/README.md#download-files)"
echo    "   ${BOLD}setup.github.repository.sh${NORMAL} (https://github.com/BradleyA/Linux-admin/tree/master/github-repository-traffic#install)"

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

#    Order of precedence: CLI argument, environment variable
if [[ $# -ge  1 ]]  ; then GITHUB_REPOSITORY_TRAFFIC_DATA=${1} ; else
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  <GITHUB_OWNER>.<REPOSITORY>.<date> as the first argument on the command line was not found.."
  exit 1
fi
if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  Variable...  GITHUB_REPOSITORY_TRAFFIC_DATA >${GITHUB_REPOSITORY_TRAFFIC_DATA}<" 1>&2 ; fi
GITHUB_OWNER=$(echo "${1}" | cut -d. -f 1)
REPOSITORY=$(echo "${1}" | cut -d. -f 2)
#    Order of precedence: environment variable, default code
if [[ "${GITHUB_TRAFFIC_DIR}" == "" ]] ; then GITHUB_TRAFFIC_DIR=${DEFAULT_GITHUB_TRAFFIC_DIR} ; fi

cd "${GITHUB_TRAFFIC_DIR}/${GITHUB_OWNER}/${REPOSITORY}"

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
    CLONE_DATA_DATE="clone.data.${SECOND_WORD}"
    tmp=$(echo "${line}" | cut -d: -f 2 | cut -d\- -f 2-3)
    echo "| ${tmp}" > "${CLONE_DATA_DATE}"
    echo "|:---:" >> "${CLONE_DATA_DATE}"
  else
    AMOUNT=$(echo "${line}" | cut -d: -f 2)
    echo "| ${AMOUNT}" >> "${CLONE_DATA_DATE}"
  fi
  if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  Variable... FIRST_WORD >${FIRST_WORD}< SECOND_WORD >${SECOND_WORD}< CLONE_DATA_DATE >${CLONE_DATA_DATE}< AMOUNT >${AMOUNT}<" 1>&2 ; fi
done < "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp"
if [[ "${DEBUG}" == "0" ]] ; then rm  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp" ; fi  #  Remove file only if DEBUG is set to zero
CLONE_TOTAL=0
#    ${CLONE_DATA_DATE} exists and read permission && exists and has a size greater than zero  #39
if [[ ! -r "${CLONE_DATA_DATE}" ]] || [[ ! -s "${CLONE_DATA_DATE}"  ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  ${CLONE_DATA_DATE} file does not exist, or does not have read permission, or has size of zero."
  exit 1
fi
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
    VIEW_DATA_DATE="view.data.${SECOND_WORD}"
    tmp=$(echo "${line}" | cut -d: -f 2 | cut -d\- -f 2-3)
    echo "| ${tmp}" > "${VIEW_DATA_DATE}"
    echo "|:---:" >> "${VIEW_DATA_DATE}"
  else
    AMOUNT=$(echo "${line}" | cut -d: -f 2)
    echo "| ${AMOUNT}" >> "${VIEW_DATA_DATE}"
  fi
  if [[ "${DEBUG}" == "1" ]] ; then new_message "${LINENO}" "DEBUG" "  Variable... FIRST_WORD >${FIRST_WORD}< SECOND_WORD >${SECOND_WORD}< VIEW_DATA_DATE >${VIEW_DATA_DATE}< AMOUNT >${AMOUNT}<" 1>&2 ; fi
done < "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp"
if [[ "${DEBUG}" == "0" ]] ; then rm  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.tmp" ; fi  #  Remove file only if DEBUG is set to zero
VIEW_TOTAL=0
#    ${VIEW_DATA_DATE} exists and read permission && exists and has a size greater than zero  #39
if [[ ! -r "${VIEW_DATA_DATE}" ]] || [[ ! -s "${VIEW_DATA_DATE}"  ]] ; then
  new_message "${LINENO}" "${RED}ERROR${WHITE}" "  ${VIEW_DATA_DATE} file does not exist, or does not have read permission, or has size of zero."
  exit 1
fi
if ls view.data.* 1>/dev/null 2>&1 ; then
#    Total third line of view.data.* files
  VIEW_TOTAL=$(awk 'FNR == 3 {total+=$2} END {print total}'  view.data.*)
  echo "${VIEW_TOTAL}"  > view.total
  paste -d ' ' ../../view.heading view.data.* | column -t -s' ' > view.table.md
  sed -i '1 i\#### Visitors' view.table.md
fi
echo -e "\nTotal views: ${VIEW_TOTAL}\n###### Updated: $(date +%Y-%m-%d)"  >> view.table.md
if [[ "${DEBUG}" == "0" ]] ; then rm  "${GITHUB_REPOSITORY_TRAFFIC_DATA}.no-headers" ; fi  #  Remove file only if DEBUG is set to zero

#
new_message "${LINENO}" "INFO" "  Operation finished..."
###
