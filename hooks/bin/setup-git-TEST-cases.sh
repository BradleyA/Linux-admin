#!/bin/bash
# 	hooks/bin/setup-git-TEST-cases.sh  2.205.900  2019-10-09T21:23:23.251203-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.205-13-g9e8b43b  
# 	   hooks/bin/setup-git-TEST-cases.sh   added color 
# 	hooks/bin/setup-git-TEST-cases.sh  2.120.624  2019-09-21T11:07:01.734932-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.119  
# 	   close #14    hooks/bin/setup-git-TEST-cases.sh    removed git-TEST-cases.sh --clean --hooks and added user hint to next step 
# 	hooks/bin/setup-git-TEST-cases.sh  2.117.621  2019-09-20T22:02:03.774879-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.116-1-g58bd437  
# 	   close #2   hooks/bin/setup-git-TEST-cases.sh  met all four objectives
#86# hooks/bin/setup-git-TEST-cases.sh - setup git TEST cases in current repository
#    copy commands to /usr/local/bin
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
YELLOW=$(tput setaf 3)

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

#    INFO
if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Started..." 1>&2 ; fi

###

if git -C . rev-parse 2> /dev/null ; then  #  currect directory in a git repository
  cd "$(git rev-parse --show-toplevel || echo '.')"  #  change to top git repository directory 
  REPOSITORY_NAME=$(git rev-parse --show-toplevel | rev | cut -d / -f 1 | rev)
  curl -L https://api.github.com/repos/BradleyA/git-TEST-commit-automation/tarball | tar -xzf - --wildcards BradleyA-git-TEST-commit-automation-*/hooks
  cd ./BradleyA-git-TEST-commit-automation-*
  tar -cf - ./hooks/ | (cd .. && tar -xf -)
  cd ..
  rm -rf  BradleyA-git-TEST-commit-automation-*
  cd hooks
  if [[ -x "post-commit" ]] && [[ -x "pre-commit" ]]  ; then  # do files exist and execute permission
    if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Link pre-commit and post-commit" 1>&2 ; fi
    ln -fs ../../hooks/pre-commit  ../.git/hooks/pre-commit
    ln -fs ../../hooks/post-commit ../.git/hooks/post-commit
  else
    new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  ${BOLD}Unable to link ${YELLOW}${REPOSITORY_NAME}/hooks/{pre-commit,post-commit}${NORMAL}${BOLD} to ${REPOSITORY_NAME}/.git/hooks/{pre-commit,post-commit} because {pre-commit,post-commit} is NOT found in current directory ($(pwd)) or does not have execute permission.${NORMAL}" 1>&2
    exit 2
  fi
  if [[ -x "bin/git-TEST-cases.sh" ]] && [[ -x bin/setup-git-TEST-cases.sh ]]  && [[ -x bin/uninstall-git-TEST-cases.sh ]] && [[ -w /usr/local/bin ]]  ; then
    if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Copy git-TEST-cases.sh, setup-git-TEST-cases.sh, & uninstall-git-TEST-cases.sh to /usr/local/bin" 1>&2 ; fi
    cp -f -p bin/git-TEST-cases.sh            /usr/local/bin/git-TEST-cases.sh
    cp -f -p bin/setup-git-TEST-cases.sh      /usr/local/bin/setup-git-TEST-cases.sh
    cp -f -p bin/uninstall-git-TEST-cases.sh  /usr/local/bin/uninstall-git-TEST-cases.sh
  else
    new_message "${SCRIPT_NAME}" "${LINENO}" "WARN" "  Copy ${REPOSITORY_NAME}/hooks/bin/{git-TEST-cases.sh,setup-git-TEST-cases.sh,uninstall-git-TEST-cases.sh} to /usr/local/bin because git-TEST-cases.sh or setup-git-TEST-cases.sh or uninstall-git-TEST-cases.sh is NOT found or does not have execute permission or /usr/local/bin is not writable." 1>&2
  fi
else
  EXIT_CODE=${?}
  new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  The current directory, ${BOLD}${YELLOW}$(pwd)${NORMAL}, is Not a git repository or any of the parent directories." 1>&2
  exit ${EXIT_CODE}
fi

#>>>  other than create output and change the status of all test case directories
#>>>  I do not understand the value of running the following two lines, thus comment out next two lines
#	cd "$(git rev-parse --show-toplevel || echo '.')"  #  change to top git repository directory
#	git-TEST-cases.sh --clean --hooks

# >>>    git add hooks  #  these steps would be my default most of the time but I would prefer to enter this manually until it is determined this is default .. reasons are sometime I would like to just test the code  ---- sometimes want to get latest test cases
#    git commit -m 'install latest git-TEST-commit-automation/hooks'
#    git push   #28
#>>>

# >>>  consider adding a user hint and include link to README.md  . . .  to answer that question, what now (WTF)  . . .  shit I forgot, hadn't done this in six months, quick!  . . . . . .

echo -e "    For more information:\n${BOLD}${YELLOW}    https://github.com/BradleyA/git-TEST-commit-automation#steps-to-evaluate-git-test-commit-automation-solution\n${NORMAL}"
new_message "${SCRIPT_NAME}" "${LINENO}" "INFO" "  Operation finished..." 1>&2
###
