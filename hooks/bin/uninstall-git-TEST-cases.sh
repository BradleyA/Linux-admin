#!/bin/bash
# 	hooks/bin/uninstall-git-TEST-cases.sh  2.124.642  2019-09-21T18:04:40.873567-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.123-14-gda8ab89  
# 	   #15   hooks/bin/uninstall-git-TEST-cases.sh  change tmp.*.tar location 
# 	hooks/bin/uninstall-git-TEST-cases.sh  2.115.616  2019-09-20T20:24:59.499282-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.114  
# 	   close #15   hooks/bin/uninstall-git-TEST-cases.sh   added message about location of tmp backup of all test cases 
#86# hooks/bin/uninstall-git-TEST-cases.sh - uninstall git TEST cases in current repository
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

#    INFO
if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "INFO" "  Started..." 1>&2 1>&2 ; fi

###

if git -C . rev-parse 2> /dev/null ; then  #  currect directory in a git repository
  cd "$(git rev-parse --show-toplevel || echo '.')"  #  change to top git repository directory 
  #    Tar copy of ./hooks into /tmp after a day should auto delete . . . someday I will want this back and  quick! where is it ?
  TMP_FILE_1=$(mktemp)    #  create temporary file
  TMP_FILE_2=$(mktemp)    #  create temporary file
  TMP_FILE_3=$(mktemp)    #  create temporary file
  TMP_FILE_2s=$(mktemp)   #  create temporary file
  TMP_FILE_3s=$(mktemp)   #  create temporary file
  find . -path '*TEST'   | grep -v './hooks' >  "${TMP_FILE_2}"  #  All TEST directores not under hooks directory #20
  find . -path '*TEST/*' | grep -v './hooks' >> "${TMP_FILE_2}"  #  ALL TEST directory subdirectories and files not under hooks directory
  if [[ -d hooks ]] ; then 
    find ./hooks  >  "${TMP_FILE_3}"  #  ALL files and directories under hooks
  fi
  #    Backup TEST directories, subdirectories, and files
  tar -rf "${TMP_FILE_1}.tar" --files-from "${TMP_FILE_2}" --files-from "${TMP_FILE_3}"

  #    Remove TEST directories, subdirectories, and files not under hooks directory
  sort -r "${TMP_FILE_2}" > "${TMP_FILE_2s}"  #  remove files before directories
  while read -r name ; do
    if git ls-files --error-unmatch "$name" 2> /dev/null ; then
      git rm -f "$name"   #  Remove tracked file
    else
      if [[ -d "${name}" ]] ; then 
        rmdir "${name}"   #  Remove untracked directory
      else
        rm -f "${name}"   #  Remove untracked file
      fi 
    fi
  done <  "${TMP_FILE_2s}"

  #    Remove hooks/ directory, subdirectories, and files
  sort -r "${TMP_FILE_3}" > "${TMP_FILE_3s}"  # remove files before directories
  while read -r name ; do
    if git ls-files --error-unmatch "${name}" 2> /dev/null ; then
      git rm -f "${name}" #  Remove tracked file
    else
      if [[ -d "${name}" ]] ; then 
        rmdir "${name}"   #  Remove untracked directory
      else
        rm -f "${name}"   #  Remove untracked file
      fi 
    fi
  done <  "${TMP_FILE_3s}"
  #
  rm -f  .git/hooks/pre-commit
  rm -f  .git/hooks/post-commit
  rm -f  /usr/local/bin/git-TEST-cases.sh
  rm -f  /usr/local/bin/setup-git-TEST-cases.sh
  rm -f  /usr/local/bin/uninstall-git-TEST-cases.sh
  mv "${TMP_FILE_1}.tar" .  #  #20   place the tar file in the repository top directory not /tmp
  git commit -m 'remove git-TEST-commit-automation  hooks recursively'
  #>>>  need a ticket to add an options for git push with environment variable
  #>>>  git push
  #
else
  EXIT_CODE=${?}
  new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  The current directory, ($(pwd)), is Not a git repository (or any of the parent directories)." 1>&2
  exit ${EXIT_CODE}
fi

echo    "    A copy of files can be found in ${TMP_FILE_1}.tar in the top directory of the Git repository." #  #15

#		
if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "INFO" "  Operation finished..." 1>&2 ; fi
###
