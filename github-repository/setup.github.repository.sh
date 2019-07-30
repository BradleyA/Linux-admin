#!/bin/bash
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
DEFAULT_DATA_DIR="/usr/local/data/github"

###	setup.github.repository.sh

#       Check if github.repository.sh file size>0 execute
if [ ! -s "github.repository.sh" ] && [ ! -e "github.repository.sh"  ] ; then
        echo -e "\n\tgithub.repository.sh file does not exist or is not size>0 or github.repository.sh is not executable"
        exit 1
fi

#       Check if github.repository.list file size>0 read
if [ ! -s "github.repository.list" ] && [ -r "github.repository.list"  ] ; then
        echo -e "\n\tgithub.repository.list file does not exist or is not size>0 or github.repository.sh is not readable"
        exit 1
fi

#       Check if <DEFAULT_DATA_DIR> directory
if [ ! -d "${DEFAULT_DATA_DIR}" ] ; then
        echo -e "\n\t${DEFAULT_DATA_DIR} not found "
        exit 1
	#	. . . some would say just mkdir, others would say does the user have permission to mkdir or poor planning for not having a data directory or not knowing where your data directory is
fi

#	read <GITHUB_OWNER> from CLI or environment_variable only
#   create symbolic link owner.repository <-- for(repository.list) to BradleyA.Start-registry-v2-script.1.0

# for loop through github.repository.list
#	ln -s ./owner.repository BradleyA.Start-registry-v2-script.1.0


# echo syntax to add to crontab -e ' ' ; Monday noon CST
# */2 * * * *      /usr/local/bin/create-display-message.sh >> /usr/local/data/us-tx-cluster-1/log/six-rpi3b.cptx86.com-crontab 2>&1


need to write a parser
	to parse data/owner.repositry-date files into a comma separated values text files (.csv) in /usr/local/data/github/owner/repository/RAW/
	use .csv data to create cart image
	push images to github owner/repository/images/(clones.png,views.png, popular.referrers.list, popular.paths.list)
	link images to github owner/repository/README.md page
 .... NOTE to self need data first and dont want to waste time creating test data


###
