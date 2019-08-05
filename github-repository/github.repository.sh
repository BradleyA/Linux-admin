#!/bin/bash
# 	github-repository/github.repository.sh  2.70.276  2019-08-04T21:38:48.401007-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.69-30-g11a23d8  
# 	   github-repository/. . .  changed default output file for github data 
# 	github-repository/github.repository.sh  2.50.216  2019-07-30T15:12:40.368075-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.49  
# 	   new directory structure to ${DEFAULT_DATA_GITHUB_DIR}/${GITHUB_OWNER}/{log,data} to manage data & commands #29 
### production standard 3.0 shellcheck
### production standard 5.1.160 Copyright
#       Copyright (c) 2019 Bradley Allen
#       MIT License is in the online DOCUMENTATION, DOCUMENTATION URL defined below.
### production standard 7.0 Default variable value
COMMAND_NAME=$(echo "${0}" | sed 's/^.*\///')
DEFAULT_REPOSITORY_OWNER=$(echo "${COMMAND_NAME}" | cut -d '.' -f 1)
DEFAULT_REPOSITORY=$(echo "${COMMAND_NAME}" | sed "s/^${DEFAULT_REPOSITORY_OWNER}\.//")
TODAY=$(date +%Y-%m-%d)
DEFAULT_DATA_DIR="/usr/local/data/github/${DEFAULT_REPOSITORY_OWNER}/${DEFAULT_REPOSITORY}"
###
mkdir -p ${DEFAULT_DATA_DIR}
#	Get the total number of clones over the last 14 days. 
echo "clones >>>" > ${DEFAULT_DATA_DIR}/${COMMAND_NAME}.${TODAY}
curl -ni https://api.github.com/repos/"${DEFAULT_REPOSITORY_OWNER}"/"${DEFAULT_REPOSITORY}"/traffic/clones?per=week  >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}.${TODAY}
#	Get the total number of views over the last 14 days. 
echo "views >>>" >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}.${TODAY}
curl -ni https://api.github.com/repos/"${DEFAULT_REPOSITORY_OWNER}"/"${DEFAULT_REPOSITORY}"/traffic/views?per=week  >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}.${TODAY}
#	Get the top 10 popular contents over the last 14 days.
echo "/popular/paths >>>" >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}.${TODAY}
curl -ni https://api.github.com/repos/"${DEFAULT_REPOSITORY_OWNER}"/"${DEFAULT_REPOSITORY}"/traffic/popular/paths  >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}.${TODAY}
#	Get the top 10 referrers over the last 14 days.
echo "/popular/referrers >>>" >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}.${TODAY}
curl -ni https://api.github.com/repos/"${DEFAULT_REPOSITORY_OWNER}"/"${DEFAULT_REPOSITORY}"/traffic/popular/referrers  >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}.${TODAY}
#
###
