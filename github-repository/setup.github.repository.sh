#!/bin/bash
# 	github-repository/setup.github.repository.sh  2.58.227  2019-08-01T14:35:38.574365-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.57  
# 	   github-repository/setup.github.repository.sh cleanup debug code 
# 	github-repository/setup.github.repository.sh  2.57.226  2019-08-01T14:23:05.112592-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.56  
# 	   setup.github.repository.sh change ln -s 
# 	github-repository/setup.github.repository.sh  2.55.224  2019-08-01T14:04:14.284414-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.54  
# 	   add code to test exit 1 
# 	github-repository/setup.github.repository.sh  2.54.223  2019-08-01T12:49:53.657953-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.52-3-g9d61059  
# 	   move location of setup.github.repository.sh when running cd /tmp 
# 	github-repository/setup.github.repository.sh  2.51.218  2019-08-01T12:24:04.340061-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.50-1-ga153d99  
# 	   changed permission setup.github.repository.sh 
# 	github-repository/setup.github.repository.sh  2.50.216  2019-07-30T15:12:40.471109-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.49  
# 	   new directory structure to ${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}/{log,data} to manage data & commands #29 
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
        echo -e "\n\tGithub owner is required to make this work.  Either as the first argument on the command line or defined as GITHUB_OWNER environment variable.  Try again."
        exit 1
fi

mkdir -p ${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}/{log,data}
#       Check if <DEFAULT_DATA_GITHUB_DIR> directory
if [ ! -d "${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}" ] ; then
        echo -e "\n\t${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER} was not created maybe permission incident."
        exit 1
fi

#       Check if github.repository.sh file size>0 execute
if [ ! -s "github.repository.sh" ] && [ ! -e "github.repository.sh"  ] ; then
        echo -e "\n\tgithub.repository.sh file does not exist in directory or is not size>0 or is not executable."
        exit 1
fi
cp -p github.repository.sh "${DEFAULT_DATA_GITHUB_DIR}"

#       Check if github.repository.list file size>0 read
if [ ! -s "github.repository.list" ] && [ -r "github.repository.list"  ] ; then
        echo -e "\n\tgithub.repository.list file does not exist in directory or is not size>0 or is not readable"
	echo -e "\tgithub.repository.list file should include Github owner's repository names, one per line."
        exit 1
fi
cp -p github.repository.list "${DEFAULT_DATA_GITHUB_DIR}"

#       Check if owner.repository file size>0 read
if [ ! -s "owner.repository" ] && [ -r "owner.repository"  ] ; then
        echo -e "\n\towner.repository file does not exist in directory or is not size>0 or is not readable"
        exit 1
fi
cp -p owner.repository "${DEFAULT_DATA_GITHUB_DIR}"

#       Check if setup.github.repository.sh file size>0 execute
if [ ! -s "setup.github.repository.sh" ] && [ -e "setup.github.repository.sh"  ] ; then
        echo -e "\n\tsetup.github.repository.sh file does not exist in directory or is not size>0 or is not executable."
fi
cp -p setup.github.repository.sh "${DEFAULT_DATA_GITHUB_DIR}/.."

cd "${DEFAULT_DATA_GITHUB_DIR}"
echo "Add the follow line(s) to crontab using crontab -e	----->"
#	Loop through repository names in github.repository.list	
for REPOSITORY in $(cat "${DEFAULT_DATA_GITHUB_DIR}"/github.repository.list | grep -v "#" ); do
	#   create symbolic link owner.repository <-- for(repository.list) to BradleyA.Start-registry-v2-script.1.0
	ln -s ../owner.repository "${GITHUB_OWNER}/${GITHUB_OWNER}.${REPOSITORY}"
	echo " 0 0 * * MON   ${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}/${GITHUB_OWNER}.${REPOSITORY}  >>  ${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}/log/${GITHUB_OWNER}.${REPOSITORY}-crontab" 2>&1

done

#	
#	need to write a parser
#		to parse data/owner.repositry-date files into a comma separated values text files (.csv) in /usr/local/data/github/owner/repository/RAW/
#		use .csv data to create cart image
#		push images to github owner/repository/images/(clones.png,views.png, popular.referrers.list, popular.paths.list)
#		link images to github owner/repository/README.md page
#	 .... NOTE to self need data first and dont want to waste time creating test data

###
