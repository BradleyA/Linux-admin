#!/bin/bash
# 	github-repository/setup.github.repository.sh  2.89.315  2019-08-06T23:29:02.911113-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.88-4-gce2f912  
# 	   github-repository/parse.repository.data.sh github-repository/setup.github.repository.sh updated user hint with ticvket information I need to enter 
# 	github-repository/setup.github.repository.sh  2.80.291  2019-08-05T10:49:54.851588-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.79-1-g07eb720  
# 	   github-repository/setup.github.repository.sh add code for clone.heading & view.heading 
# 	github-repository/setup.github.repository.sh  2.75.282  2019-08-04T22:48:18.336006-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.74  
# 	   github-repository/setup.github.repository.sh mv -f cause more indidents than cp -p 
# 	github-repository/setup.github.repository.sh  2.74.281  2019-08-04T22:42:37.034053-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.73  
# 	   github-repository/setup.github.repository.sh added -f force to me to stop error message are the same file 
# 	github-repository/setup.github.repository.sh  2.73.280  2019-08-04T22:37:07.714409-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.72-1-g8f5b689  
# 	   github-repository/setup.github.repository.sh comment out Check if github.repository.sh file size>0 execute 
# 	github-repository/setup.github.repository.sh  2.48.214  2019-07-30T14:06:39.571375-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.47  
# 	   github-repository/setup.github.repository.sh added requirements checking with help if not met 
# 	github-repository/setup.github.repository.sh  2.45.209  2019-07-29T22:54:36.803070-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.44  
# 	   github-repository/setup.github.repository.sh making this up as I go . . . 
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
DEFAULT_DATA_GITHUB_DIR="/usr/local/data/github/"

###	setup.github.repository.sh
#       Order of precedence: CLI argument, environment variable
if [ $# -ge  1 ]  ; then GITHUB_OWNER=${1} ; elif [ "${GITHUB_OWNER}" == "" ] ; then 
        echo -e "\n\tGithub owner is required to make this work.  Either as the first argument on the command line or defined as GITHUB_OWNER environment variable   << BUT I HAVE NOT coded that yet >>>.  Try again."
        exit 1
fi

#	Create log directory for crontab ${GITHUB_OWNER} jobs
mkdir -p ${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}/log
#       Check if <DEFAULT_DATA_GITHUB_DIR> directory
if [ ! -d "${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}" ] ; then
        echo -e "\n\t${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER} was not created maybe permission incident."
        exit 1
fi

#	#       Check if github.repository.sh file size>0 execute
#	if [ ! -s "github.repository.sh" ] && [ ! -e "github.repository.sh"  ] ; then
#	        echo -e "\n\tgithub.repository.sh file does not exist in directory or is not size>0 or is not executable."
#	        exit 1
#	fi
#	cp -p github.repository.sh "${DEFAULT_DATA_GITHUB_DIR}"

#       Check if github.repository.list file size>0 read
if [ ! -s "github.repository.list" ] && [ -r "github.repository.list"  ] ; then
        echo -e "\n\tgithub.repository.list file does not exist in directory or is not size>0 or is not readable"
	echo -e "\tgithub.repository.list file should include Github owner's repository names, one per line."
        exit 1
fi
cp -p  github.repository.list "${DEFAULT_DATA_GITHUB_DIR}"

#       Check if owner.repository file size>0 read
if [ ! -s "owner.repository" ] && [ -r "owner.repository"  ] ; then
        echo -e "\n\towner.repository file does not exist in directory or is not size>0 or is not readable"
        exit 1
fi
cp -p  owner.repository "${DEFAULT_DATA_GITHUB_DIR}"

#       Check if setup.github.repository.sh file size>0 execute
if [ ! -s "setup.github.repository.sh" ] && [ -e "setup.github.repository.sh"  ] ; then
        echo -e "\n\tsetup.github.repository.sh file does not exist in directory or is not size>0 or is not executable."
fi
cp -p  setup.github.repository.sh "${DEFAULT_DATA_GITHUB_DIR}"

#       Check if parse.repository.data.sh file size>0 execute
if [ ! -s "parse.repository.data.sh" ] && [ -e "parse.repository.data.sh"  ] ; then
        echo -e "\n\tparse.repository.data.sh file does not exist in directory or is not size>0 or is not executable"
        exit 1
fi
cp -p  parse.repository.data.sh "${DEFAULT_DATA_GITHUB_DIR}"

#       Check if clone.heading file size>0 read
if [ ! -s "clone.heading" ] && [ -r "clone.heading"  ] ; then
        echo -e "\n\tclone.heading file does not exist in directory or is not size>0 or is not readable"
        exit 1
fi
cp -p  clone.heading "${DEFAULT_DATA_GITHUB_DIR}"

#       Check if view.heading file size>0 read
if [ ! -s "view.heading" ] && [ -r "view.heading"  ] ; then
        echo -e "\n\tview.heading file does not exist in directory or is not size>0 or is not readable"
        exit 1
fi
cp -p  view.heading "${DEFAULT_DATA_GITHUB_DIR}"

cd "${DEFAULT_DATA_GITHUB_DIR}"
echo "Add the follow line(s) to crontab using crontab -e	----->"
#	Loop through repository names in github.repository.list	
for REPOSITORY in $(cat "${DEFAULT_DATA_GITHUB_DIR}"/github.repository.list | grep -v "#" ); do
	#   create symbolic link owner.repository <-- for(repository.list) to BradleyA.Start-registry-v2-script.1.0
	ln -sf ../owner.repository "${GITHUB_OWNER}/${GITHUB_OWNER}.${REPOSITORY}"
	echo "20 12 * * MON   ${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}/${GITHUB_OWNER}.${REPOSITORY}  >>  ${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}/log/${GITHUB_OWNER}.${REPOSITORY}-crontab" 2>&1

done

###
