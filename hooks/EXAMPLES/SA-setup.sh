#!/bin/bash
# 	hooks/EXAMPLES/SA-setup.sh  2.139.788  2019-09-27T17:14:37.351295-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.138  
# 	   remove #34 for is command 
# 	hooks/EXAMPLES/SA-setup.sh  2.138.787  2019-09-27T12:34:20.801732-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.137  
# 	   close #34    EXAMPLES/SA-* FVT-*   added NO -x ${1} exit ERROR 126 
#86# hooks/EXAMPLES/SA-setup.sh - This script is optional.  It is for 
#    'Production standard 10.0 TESTing' test cases.  Copy it to TEST/<file_name>/.
#    If SA-setup.sh is found in TEST/<file_name>/ post-commit executes it.
#    Static Analysis (SA) - examination of code prior to the program’s execution
#    SA is code analysis, syntax, permission, code inspection, code review, etc
###  Production standard 3.0 shellcheck
###  Production standard 5.1.160 Copyright
#    Copyright (c) 2019 Bradley Allen
#    MIT License is in the online DOCUMENTATION, DOCUMENTATION URL defined below.
###  Production standard 1.3.496 DEBUG variable
#    Order of precedence: environment variable, default code
if [[ "${DEBUG}" == ""  ]] ; then DEBUG="0" ; fi   # 0 = debug off, 1 = debug on, 'export DEBUG=1', 'unset DEBUG' to unset environment variable (bash)
if [[ "${DEBUG}" == "2" ]] ; then set -x    ; fi   # Print trace of simple commands before they are executed
if [[ "${DEBUG}" == "3" ]] ; then set -v    ; fi   # Print shell input lines as they are read
if [[ "${DEBUG}" == "4" ]] ; then set -e    ; fi   # Exit command has a non-zero exit status
#
BOLD=$(tput -Txterm bold)
NORMAL=$(tput -Txterm sgr0)
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
SCRIPT_NAME=$(head -2 "${0}" | awk '{printf $2}')
SCRIPT_VERSION=$(head -2 "${0}" | awk '{printf $3}')
if [[ "${SCRIPT_NAME}" == "" ]] ; then SCRIPT_NAME="${0}" ; fi
if [[ "${SCRIPT_VERSION}" == "" ]] ; then SCRIPT_VERSION="v?.?" ; fi

#    UID and GID
USER_ID=$(id -u)
GROUP_ID=$(id -g)

###  Production standard 2.3.512 log format (WHEN WHERE WHAT Version Line WHO UID:GID [TYPE] Message)
new_message() {  #  $1="${SCRIPT_NAME}"  $2="${LINENO}"  $3="DEBUG INFO ERROR WARN"  $4="message"
  get_date_stamp
  echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${1}[$$] ${SCRIPT_VERSION} ${2} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[${3}]${NORMAL}  ${4}"
}

if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Started..." 1>&2 ; fi

###  Production standard 10.0 TESTing 

if [[ ! -z "${1}" ]] ; then  # post-commit must pass REPOSITORY_DIR because post-commit is executed in .git/hooks/ which is not in the repository
  REPOSITORY_DIR=${1}
else
  REPOSITORY_DIR=$(git rev-parse --show-toplevel)  #  not called by post-commit
  if [[ "${0}" != $(basename "${0}") ]] ; then  #  script must executed in TEST/<COMMIT_FILE_NAME>/ directory
    cd "$(dirname "${0}")"
  fi
fi

#    Uncomment shared TEST cases for command
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-exit-code-error-124-001"   SA-exit-code-error-124-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-exit-code-error-124-002"   SA-exit-code-error-124-002
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-exit-code-error-2-001"     SA-exit-code-error-2-001
#
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-400-001"        SA-permission-400-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-440-001"        SA-permission-440-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-444-001"        SA-permission-444-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-640-001"        SA-permission-640-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-644-001"        SA-permission-644-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-664-001"        SA-permission-664-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-600-001"        SA-permission-600-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-660-001"        SA-permission-660-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-666-001"        SA-permission-666-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-750-001"        SA-permission-750-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-755-001"        SA-permission-755-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-700-001"        SA-permission-700-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-770-001"        SA-permission-770-001
ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-775-001"        SA-permission-775-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-777-001"        SA-permission-777-001
#
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-dir-001"        SA-permission-dir-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-grp-10000-001"  SA-permission-grp-10000-001
#  ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-permission-own-10000-001"  SA-permission-own-10000-001
#
ln -fs "${REPOSITORY_DIR}/hooks/EXAMPLES/SA-shellcheck-001"            SA-shellcheck-001
#

if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Operation finished..." 1>&2 ; fi
###
