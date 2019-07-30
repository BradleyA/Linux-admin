#!/bin/bash
# 	github-repository/github.repository.sh  2.46.211  2019-07-29T23:01:30.583156-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.45-1-gf0b02ec  
# 	   initial commit 
### production standard 3.0 shellcheck
### production standard 5.1.160 Copyright
#       Copyright (c) 2019 Bradley Allen
#       MIT License is in the online DOCUMENTATION, DOCUMENTATION URL defined below.
### production standard 7.0 Default variable value
COMMAND_NAME=$(echo "${0}" | sed 's/^.*\///')
DEFAULT_REPOSITORY_OWNER=$(echo "${COMMAND_NAME}" | cut -d '.' -f 1)
DEFAULT_REPOSITORY=$(echo "${COMMAND_NAME}" | sed "s/^${DEFAULT_REPOSITORY_OWNER}\.//")
TODAY=$(date +%Y-%m-%d)
DEFAULT_DATA_DIR="/usr/local/data/github"
###
mkdir -p ${DEFAULT_DATA_DIR}
#	Get the total number of clones over the last 14 days. 
echo "cLones >>>" > ${DEFAULT_DATA_DIR}/${COMMAND_NAME}-${TODAY}
curl -ni https://api.github.com/repos/"${DEFAULT_REPOSITORY_OWNER}"/"${DEFAULT_REPOSITORY}"/traffic/clones?per=week  >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}-${TODAY}
#	Get the total number of views over the last 14 days. 
echo "views >>>" >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}-${TODAY}
curl -ni https://api.github.com/repos/"${DEFAULT_REPOSITORY_OWNER}"/"${DEFAULT_REPOSITORY}"/traffic/views?per=week  >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}-${TODAY}
#	Get the top 10 popular contents over the last 14 days.
echo "/popular/paths >>>" >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}-${TODAY}
curl -ni https://api.github.com/repos/"${DEFAULT_REPOSITORY_OWNER}"/"${DEFAULT_REPOSITORY}"/traffic/popular/paths  >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}-${TODAY}
#	Get the top 10 referrers over the last 14 days.
echo "/popular/referrers >>>" >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}-${TODAY}
curl -ni https://api.github.com/repos/"${DEFAULT_REPOSITORY_OWNER}"/"${DEFAULT_REPOSITORY}"/traffic/popular/referrers  >> ${DEFAULT_DATA_DIR}/${COMMAND_NAME}-${TODAY}
#
###
