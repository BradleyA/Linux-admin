#!/bin/bash
# 	hooks/bin/git-TEST-cases.sh  2.210.907  2019-10-12T17:03:10.071096-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.209-1-g2049da8  
# 	   hooks/bin/git-TEST-cases.sh   working on removing SA & FVT linked test cases 
# 	hooks/bin/git-TEST-cases.sh  2.208.904  2019-10-12T16:36:32.359495-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.207-1-ga99b68e  
# 	   close #40    git-TEST-cases.sh   - add git add & commit when creating default test case 
# 	hooks/bin/git-TEST-cases.sh  2.203.883  2019-10-04T16:44:11.823322-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.202-1-gc957c0b  
# 	   hooks/bin/git-TEST-cases.sh   updated display_help 
# 	hooks/bin/git-TEST-cases.sh  2.201.880  2019-10-04T16:30:30.883149-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.200-17-g1efed2b  
# 	   close #21   hooks/bin/git-TEST-cases.sh   finish display_help 
# 	hooks/bin/git-TEST-cases.sh  2.185.843  2019-10-01T21:47:23.836868-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.184  
# 	   hooks/bin/git-TEST-cases.sh    testing #35 #37 
# 	hooks/bin/git-TEST-cases.sh  2.122.626  2019-09-21T15:39:47.409524-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.121  
# 	   close #29   hooks/bin/git-TEST-cases.sh   add option --add - Add default test case directory (TEST/<FILE_NAME>/) and files SA-setup.sh, SA-cleanup.sh, SA-shellcheck-001.expected 
# 	hooks/bin/git-TEST-cases.sh  2.112.613  2019-09-20T19:29:27.300829-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.111-1-g7eba63e  
# 	   close #22   hooks/bin/git-TEST-cases.sh   updated your hint, usage, options in display_help #21 
# 	hooks/bin/git-TEST-cases.sh  2.94.553  2019-09-17T12:16:59.374340-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.93  
# 	   close #18 close #19  hooks/bin/git-TEST-cases.sh   done with testing ready for production 
# 	hooks/bin/git-TEST-cases.sh  2.92.550  2019-09-17T10:54:54.644826-05:00 (CDT)  https://github.com/BradleyA/git-TEST-commit-automation.git  uadmin  five-rpi3b.cptx86.com 2.91  
# 	   close #3   hooks/bin/git-TEST-cases.sh 
#86# hooks/bin/git-TEST-cases.sh -  search from top of repository to list TEST directory test cases
#       git-TEST-cases.sh all - runs FVT-setup.sh and SA-setup.sh to create symbolic links to EXAMPLES before listing all test cases
#       git-TEST-cases.sh clean - remove symbolic links from TEST/<command>/ directories
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
GREEN=$(tput  setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput   setaf 6)
###  Production standard 7.0 Default variable value
DEFAULT_ALL_TEST_CASES="NO"
DEFAULT_ADD_TEST_CASE="NO"
###  Production standard 8.3.214 --usage
display_usage() {
COMMAND_NAME=$(echo "${0}" | sed 's/^.*\///')
echo -e "\n${NORMAL}${COMMAND_NAME}\n   lists and manages files in TEST case directories"
echo -e "\n${BOLD}USAGE${NORMAL}"
echo    "   ${COMMAND_NAME} [-a | --all | -c | --clean | -n | --none | -f <FILE_NAME>"
echo    "                    | --filename <FILE_NAME>]"
echo    "                     [--hooks]"
echo -e "                     [--filename <FILE_NAME> --add]\n"
echo    "   ${COMMAND_NAME} [--help | -help | help | -h | h | -?]"
echo    "   ${COMMAND_NAME} [--usage | -usage | -u]"
echo    "   ${COMMAND_NAME} [--version | -version | -v]"
}
###  Production standard 0.3.214 --help
display_help() {
display_usage
#    Displaying help DESCRIPTION in English en_US.UTF-8
echo -e "\n${BOLD}DESCRIPTION${NORMAL}"
echo    "${COMMAND_NAME} is a bash script that lists and manages files in TEST"
echo    "case directories in the current Git repository.  It supports adding (-a) and"
echo    "removing (-c) symbolic links to default test cases found in the EXAMPLES"
echo    "directory.  It supports locating (-n) which files in a Git repository do not"
echo    "have test cases.  It supports listing (--filename) the test cases for a file in"
echo    "a Git repository.  It supports adding (--add) default SA test cases for a file."
echo    "a Git repository."
###  Production standard 1.3.516 DEBUG variable
echo -e "\nThe DEBUG environment variable can be set to '', '0', '1', '2', '3', or '4'."
echo    "The setting '' or '0' will turn off all DEBUG messages during execution of this"
echo    "script.  The setting '1' will print all DEBUG messages during execution of this"
echo    "script.  The setting '2' (set -x) will print a trace of simple commands before"
echo    "they are executed in this script.  The setting '3' (set -v) will print shell"
echo    "input lines as they are read.  The setting '4' (set -e) will exit immediately"
echo    "if non-zero exit status is recieved with some exceptions.  For more information"
echo    "about any of the set options, see man bash."
###  Production standard 4.0 Documentation Language
#    Displaying help DESCRIPTION in French fr_CA.UTF-8, fr_FR.UTF-8, fr_CH.UTF-8
if [[ "${LANG}" == "fr_CA.UTF-8" ]] || [[ "${LANG}" == "fr_FR.UTF-8" ]] || [[ "${LANG}" == "fr_CH.UTF-8" ]] ; then
  echo -e "\n--> ${LANG}"
  echo    "<votre aide va ici>" # your help goes here
  echo    "Souhaitez-vous traduire la section description?" # Do you want to translate the description section?
elif ! [[ "${LANG}" == "en_US.UTF-8" ]] ; then
  get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[WARN]${NORMAL}  Your language, ${LANG}, is not supported.  Would you like to translate the description section?" 1>&2
fi
echo -e "\n${BOLD}ENVIRONMENT VARIABLES${NORMAL}"
echo    "If using the bash shell, enter; 'export DEBUG=1' on the command line to set"
echo    "the environment variable DEBUG to '1' (0 = debug off, 1 = debug on).  Use the"
echo    "command, 'unset DEBUG' to remove the exported information from the environment"
echo    "variable DEBUG.  You are on your own defining environment variables if"
echo    "you are using other shells."
echo    "   DEBUG           (default off '0')"
echo    "   ALL_TEST_CASES  Include hooks/ directory (default ${DEFAULT_ALL_TEST_CASES})"
echo -e "\n${BOLD}OPTIONS${NORMAL}"
echo -e "Order of precedence: CLI options, environment variable, default code.\n"
echo    "   -a, --all"
echo -e "\tPrint all test case files after running FVT-setup.sh and SA-setup.sh"
echo -e "\texcluding hooks/ directory unless --hooks option is used."
echo    "   -c, --clean"
echo -e "\tRun FVT-cleanup.sh & SA-cleanup.sh to remove linked TEST cases and"
echo -e "\ttest files and directories excluding hooks/ directory unless --hooks"
echo -e "\toption is used."
echo    "   -f <FILE_NAME>, --filename <FILE_NAME>"
echo -e "\tPrint all test case files for <FILE_NAME> after running FVT-setup.sh"
echo -e "\tand SA-setup.sh excluding hooks/ directory unless --hooks option is used."  #  #29  --add option add default test cases
echo    "        --add"
echo -e "\t     Add default test case directory (TEST/<FILE_NAME>/) and files"
echo -e "\t     SA-setup.sh, SA-cleanup.sh, & SA-shellcheck-001.expected to"
echo -e "\t     -f <FILE_NAME>."
echo    "   --hooks"
echo -e "\tInclude files and test cases in hooks/ directory.  This option can"
echo -e "\tbe used with one of these options -a, -c, -n, or -f.  It can be set"
echo -e "\tby using the environment variable, ALL_TEST_CASES."
echo    "   -n, --none"
echo -e "\tPrint all files that do NOT have TEST cases except hooks/ directory"
echo -e "\tunless --hooks option is used."
###  Production standard 6.1.177 Architecture tree
echo -e "\n${BOLD}ARCHITECTURE TREE${NORMAL}"  # STORAGE & CERTIFICATION

echo -e "\n${BOLD}DOCUMENTATION${NORMAL}"
echo    "   https://github.com/BradleyA/git-TEST-commit-automation/blob/master/hooks/README.md"
echo -e "\n${BOLD}EXAMPLES${NORMAL}"
echo -e "   List files in TEST case directories including hooks/ directory\n\t${BOLD}${COMMAND_NAME} --hooks${NORMAL}"
echo -e "   <<your code examples description goes here>>\n\t${BOLD}${COMMAND_NAME}${NORMAL}"
echo -e "   <<your code examples description goes here>>\n\t${BOLD}${COMMAND_NAME}${NORMAL}"
echo -e "   <<your code examples description goes here>>\n\t${BOLD}${COMMAND_NAME}${NORMAL}"
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
if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "INFO" "  Started..." 1>&2 ; fi

#    Added following code because USER is not defined in crobtab jobs
if ! [[ "${USER}" == "${LOGNAME}" ]] ; then  USER=${LOGNAME} ; fi
if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Setting USER to support crobtab...  USER >${USER}<  LOGNAME >${LOGNAME}<" 1>&2 ; fi

#    DEBUG
if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "INFO" "  Name_of_command >${SCRIPT_NAME}< Name_of_arg1 >${1}< Name_of_arg2 >${2}< Name_of_arg3 >${3}<  Version of bash ${BASH_VERSION}" 1>&2 ; fi

###  Production standard 7.0 Default variable value
#    Order of precedence: CLI argument, environment variable, default code
if [[ "${ALL_TEST_CASES}" == "" ]] ; then ALL_TEST_CASES=${DEFAULT_ALL_TEST_CASES} ; fi

###

###  Production standard 9.3.513 Parse CLI options and arguments #19
while [[ "${#}" -gt 0 ]] ; do
  case "${1}" in
    --help|-help|help|-h|h|-\?)  display_help | more ; exit 0 ;;
    --usage|-usage|usage|-u)  display_usage ; exit 0  ;;
    --version|-version|version|-v)  echo "${SCRIPT_NAME} ${SCRIPT_VERSION}" ; exit 0  ;;
    -a|--all)   if [[ "${CLI_OPTION}" != "" ]] ; then
        new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  Only one of these option -a, --all, -c, --clean, -f, --filename, -n, or --none can be selected." 1>&2 ; exit 1
      else
        CLI_OPTION="a" ; shift
      fi ;;
    --add) DEFAULT_ADD_TEST_CASE="YES" ; shift ;;  #  #29
    -c|--clean) if [[ "${CLI_OPTION}" != "" ]] ; then
        new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  Only one of these option -a, --all, -c, --clean, -f, --filename, -n, or --none can be selected." 1>&2 ; exit 1
      else
        CLI_OPTION="c" ; shift 
      fi ;;
    -f|--filename) if [[ "${CLI_OPTION}" != "" ]] ; then
        new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  Only one of these option -a, --all, -c, --clean, -f, --filename, -n, or --none can be selected." 1>&2 ; exit 1
      else
        CLI_OPTION="f" ; if [[ "${2}" == "" ]] ; then
          display_usage ; new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  Argument for ${1} is not found on command line" 1>&2 ; exit 1
        fi
        FILE_NAME=${2} ; shift 2
      fi ;;
    --hooks|-hooks) ALL_TEST_CASES="YES" ; shift ;;
    -n|--none) if [[ "${CLI_OPTION}" != "" ]] ; then  #  #18
        new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  Only one of these option -a, --all, -c, --clean, -f, --filename, -n, or --none can be selected." 1>&2 ; exit 1
      else
        CLI_OPTION="n" ; shift 
      fi ;;
    *)  new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  Option, ${1}, entered on the command line is not supported." 1>&2 ; display_usage ; exit 1 ; ;;
  esac
done
if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Variable... CLI_OPTION >${CLI_OPTION}< FILE_NAME >${FILE_NAME}< ALL_TEST_CASES >${ALL_TEST_CASES}<" 1>&2 ; fi

###  Production standard 10.0 TESTing
REPOSITORY_DIR=$(git rev-parse --show-toplevel)
cd "${REPOSITORY_DIR}"
if [[ "${CLI_OPTION}" == "f" ]]  ; then
  if [[ "${FILE_NAME}" =~ / ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  Filename ${FILE_NAME}, contains '/'" 1>&2 ; exit 1 ; fi
  if [[ "${DEFAULT_ADD_TEST_CASE}" == "YES" ]] ; then  #  #29  --add default SA files
    TMP1=$(find . -type f -name "${FILE_NAME}")
    if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Directory with FILE_NAME >${TMP1}< FILE_NAME >${FILE_NAME}<" 1>&2 ; fi
    if [[ "${TMP1}" == "" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "ERROR" "  Filename ${FILE_NAME}, NOT found" 1>&2 ; exit 1 ; fi
    DIR_COUNT=$(awk -F'/' '{print NF-2}' <<< $TMP1)
    cd "$(dirname "${TMP1}")"  #  change to directory with ${FILE_NAME}
    mkdir -p TEST/"${FILE_NAME}"/
    EXAMPLE_DIR="../../hooks/EXAMPLES"
    if [[ ${DIR_COUNT} != 0 ]] ; then
      while [[ ${DIR_COUNT} != 0 ]] ; do DIR_COUNT=$((DIR_COUNT - 1)) ; EXAMPLE_DIR="../${EXAMPLE_DIR}" ; done
    fi
    if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  EXAMPLE_DIR >${EXAMPLE_DIR}<" 1>&2 ; fi
    ln -sf "${EXAMPLE_DIR}/SA-setup.sh"   "TEST/${FILE_NAME}/SA-setup.sh"
    ln -sf "${EXAMPLE_DIR}/SA-cleanup.sh" "TEST/${FILE_NAME}/SA-cleanup.sh"
    touch "TEST/${FILE_NAME}/SA-shellcheck-001.expected"
    git add "TEST/${FILE_NAME}/SA-shellcheck-001.expected" "TEST/${FILE_NAME}/SA-setup.sh" "TEST/${FILE_NAME}/SA-cleanup.sh"
    git commit -m 'initial commit' "TEST/${FILE_NAME}/SA-shellcheck-001.expected" "TEST/${FILE_NAME}/SA-setup.sh" "TEST/${FILE_NAME}/SA-cleanup.sh"
  fi  #  #29
  cd "$(find . -type d -name "${FILE_NAME}")"
  if [[ -x "FVT-setup.sh" ]]  ; then ./FVT-setup.sh ; fi
  if [[ -x "SA-setup.sh"  ]]  ; then ./SA-setup.sh  ; fi
  cd "${REPOSITORY_DIR}"
  if [[ "${ALL_TEST_CASES}" == "YES" ]] ; then
    echo "${NORMAL}    INFO:  If file not found, check spelling." 1>&2
    find . -print | grep --color=auto "${FILE_NAME}"
  else
    echo "${NORMAL}    INFO:  If file not found, check spelling or including ${BOLD}--hooks${NORMAL} option." 1>&2
    find . -print | grep -v 'hooks/' | grep --color=auto "${FILE_NAME}"
  fi
  cd "$(find . -type d -name "${FILE_NAME}")"
  if [[ -x "FVT-cleanup.sh" ]]  ; then ./FVT-cleanup.sh ; fi
  if [[ -x "SA-cleanup.sh"  ]]  ; then ./SA-cleanup.sh  ; fi
else
  if [[ "${CLI_OPTION}" == "n" ]] ; then  #  #18
    TMP_GITALLFILES=$(mktemp /tmp/GITALLFILESXXXXXX)                       #  create temporary file for all files in repository
    TMP_GITALLFILES_NO_TESTDIR=$(mktemp /tmp/GITALLFILES_NOTESTDIRXXXXXX)  #  create temporary file for all files in repository that have a /TEST/<filename>/ directory
    TMP_GITALL_TEST_CASE_LIST=$(mktemp /tmp/GIT_TEST_CASE_LISTXXXXXX)      #  create temporary file for all files in repository that do have test cases
    if [[ "${ALL_TEST_CASES}" == "YES" ]] ; then
      find . -type f | grep -v './\.git/*\|./*/images/*\|./*/TEST/*\|./*.md' | sed 's!.*/!!' > "${TMP_GITALLFILES}"
      find . -type d -name TEST -exec ls -1 {} \; > "${TMP_GITALLFILES_NO_TESTDIR}"
      TMP_GITALL_TEST_CASE_LIST=$(cat "${TMP_GITALLFILES}"  "${TMP_GITALLFILES_NO_TESTDIR}" | sort | uniq -u)
    else
      find . -type f | grep -v './\.git/*\|./*/images/*\|./*/TEST/*\|./*.md\|hooks/' | sed 's!.*/!!' > "${TMP_GITALLFILES}"
      find . -path ./hooks -prune -o -type d -name TEST -exec ls -1 {} \; > "${TMP_GITALLFILES_NO_TESTDIR}"
      TMP_GITALL_TEST_CASE_LIST=$(cat "${TMP_GITALLFILES}"  "${TMP_GITALLFILES_NO_TESTDIR}" | sort | uniq -u)
    fi
    for l in ${TMP_GITALL_TEST_CASE_LIST} ; do
      find . -name "${l}"
    done
    rm /tmp/GITALL*
  else
    DIR_LIST=$(find . -type d -name TEST)  #  create list of TEST directories
    if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  \${DIR_LIST} >${DIR_LIST=}<" 1>&2 ; fi
    for i in $DIR_LIST ; do
      if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  TEST directory >${i}<" 1>&2 ; fi
      if [[ ! $(ls -1A "${i}") ]] ; then continue ; fi  #  Skip no test case in directoy 
      TEST_CASE_DIR_LIST=$(ls -1d "${i}"/* | cut -c 3-)
      for j in ${TEST_CASE_DIR_LIST} ; do 
        if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Directory >${j}<" 1>&2 ; fi
        if [[ $j == *"hooks"* ]] && [[ "${ALL_TEST_CASES}" == "NO" ]] ; then continue ; fi  #  Skip to the next j in for loop
        TEST_CASE_DIR_END=$(echo "${j}" | rev | cut -d '/' -f 1 | rev)
        TEST_CASE_DIR_START="${j//${TEST_CASE_DIR_END}/}"
        printf "${TEST_CASE_DIR_START}${BOLD}${YELLOW}${TEST_CASE_DIR_END}${NORMAL}\n"
        cd "${REPOSITORY_DIR}/${j}"
        if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "DEBUG" "  Run FVT-setup.sh and SA-setup.sh if -a or --all" 1>&2 ; fi
        if [[ "${CLI_OPTION}" == "a" ]] && [[ -x "FVT-setup.sh" ]]  ; then ./FVT-setup.sh  "${REPOSITORY_DIR}" ; fi
        if [[ "${CLI_OPTION}" == "a" ]] && [[ -x "SA-setup.sh"  ]]  ; then ./SA-setup.sh   "${REPOSITORY_DIR}" ; fi
        if [[ "${CLI_OPTION}" == "c" ]]  ; then
          if [[ -x "FVT-cleanup.sh" ]]  ; then ./FVT-cleanup.sh ; fi
          if [[ -x "SA-cleanup.sh"  ]]  ; then ./SA-cleanup.sh  ; fi
        fi
        cd "${REPOSITORY_DIR}"
        printf "${BOLD}${GREEN} $(ls -1  "${j}" | grep -v "\." | sed 's/^/\t/')${NORMAL}\n"
        printf "${BOLD}${CYAN} $(ls -1  "${j}" | grep "cleanup.sh" | sed 's/^/\t/')${NORMAL}\n"
        printf "${BOLD}${CYAN} $(ls -1  "${j}" | grep "setup.sh" | sed 's/^/\t/')${NORMAL}\n"
      done
    done
  fi
fi

if [[ "${DEBUG}" == "1" ]] ; then new_message "${SCRIPT_NAME}" "${LINENO}" "INFO" "  Operation finished..." 1>&2 ; fi
###
