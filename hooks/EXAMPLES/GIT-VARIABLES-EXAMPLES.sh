#!/bin/bash
# 	hooks/EXAMPLES/GIT-VARIABLES-EXAMPLES.sh  3.486.741  2019-08-31T21:21:03.826987-05:00 (CDT)  https://github.com/BradleyA/user-files.git  uadmin  one-rpi3b.cptx86.com 3.485  
# 	   hooks/EXAMPLES/GIT-VARIABLES-EXAMPLES.sh   typo 
###  I use this file to help debug hooks during development
###  Production standard 3.0 shellcheck
###  Production standard 5.1.160 Copyright
#    Copyright (c) 2019 Bradley Allen
#    MIT License is in the online DOCUMENTATION
###
echo "GIT_AUTHOR_DATE >${GIT_AUTHOR_DATE}<"
echo "GIT_AUTHOR_NAME >${GIT_AUTHOR_NAME}<"
echo "GIT_AUTHOR_EMAIL >${GIT_AUTHOR_EMAIL}<"
echo "GIT_REFLOG_ACTION >${GIT_REFLOG_ACTION}<"
echo "GIT_INDEX_FILE >${GIT_INDEX_FILE}<"
echo "\$GIT_DIR >${GIT_DIR}<"
echo "\$(git rev-parse --git-dir) >$(git rev-parse --git-dir)<"
echo "\$(git rev-parse --show-toplevel) >$(git rev-parse --show-toplevel)<"
echo "pwd >$(pwd)<"
echo "GIT_WORK_TREE >${GIT_WORK_TREE}<"
hook="$(git rev-parse --git-path hooks/post-commit)"
echo "hook >${hook}<"
