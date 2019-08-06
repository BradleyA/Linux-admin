#!/bin/bash
# 	github-repository/parse.repository.data.sh  2.87.309  2019-08-06T16:07:34.514840-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.86  
# 	   github-repository/parse.repository.data.sh check if {clone,view}.data.* was created before creating table and total file 
# 	github-repository/parse.repository.data.sh  2.86.308  2019-08-06T15:44:15.911300-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.85  
# 	   github-repository/parse.repository.data.sh check arg 1 
# 	github-repository/parse.repository.data.sh  2.85.307  2019-08-06T15:26:04.837936-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.84-4-g21f8ab2  
# 	   github-repository/parse.repository.data.sh add missing code from last night 
###
#       need to write a parser
#               push files/README.md/images to github owner/repository/images/(clones,views, NOT popular.referrers.list, popular.paths.list)
#               link images to github owner/repository/README.md page
#        .... NOTE to self need data first and dont want to waste time creating test data
#
#	column -t -s' ' filename
#	soffice --convert-to png ./clones
#	display ./clones.png
###
### production standard 3.0 shellcheck
### production standard 5.1.160 Copyright
#	Copyright (c) 2019 Bradley Allen
#	MIT License is in the online DOCUMENTATION, DOCUMENTATION URL defined below.
###
###     parse.repository.data.sh

DATA_GITHUB_DIR="/usr/local/data/github/"

#       Order of precedence: CLI argument, environment variable
if [ $# -ge  1 ]  ; then FILE_ORG_NAME=${1} ; elif [ "${FILE_ORG_NAME}" == "" ] ; then
        echo -e "\n\t:OWNER.:REPO.DATE is required to make this work.  Either as the first argument on the command line or defined as FILE_ORG_NAME environment variable.  Try again."
        exit 1
fi

#	Parse relevant data from ${FILE_ORG_NAME} GitHub Owner Repository data
grep -e clones -e timestamp -e count -e uniques -e views -e /popular/paths -e path -e title -e /popular/referrers -e '\]' -e '\['  ${FILE_ORG_NAME} | sed -e 's/"//g' -e 's/,//g' -e 's/T.*Z//' -e 's/[ \t]*//g' > ${FILE_ORG_NAME}.no-headers

#	Parse clones data from ${FILE_ORG_NAME}.no-headers
cat  ${FILE_ORG_NAME}.no-headers | sed -e '1,/views>>>/!d' -e '1,/clones:\[/d' -e '/^\]/,$d'  > ${FILE_ORG_NAME}.tmp
#	Loop through ${FILE_ORG_NAME}.tmp and create clone.data.$timestamp files
while read line; do
	FIRST_LINE_STRING=$(echo ${line} | cut -d: -f 1)
	if [ "${FIRST_LINE_STRING}" == "timestamp" ] ;  then
		SECOND_LINE_STRING=$(echo ${line} | cut -d: -f 2)
		CLONE_FILE_NAME="clone.data.${SECOND_LINE_STRING}"
                tmp=$(echo ${line} | cut -d: -f 2 | cut -d\- -f 2-3)
                echo "| ${tmp}" > ${CLONE_FILE_NAME}
                echo "|:---:" >> ${CLONE_FILE_NAME}
	else
                AMOUNT=$(echo ${line} | cut -d: -f 2)
                echo "| ${AMOUNT}" >> ${CLONE_FILE_NAME}
	fi
done < ${FILE_ORG_NAME}.tmp
rm  ${FILE_ORG_NAME}.tmp
#
if [ "clone.data.*" -s ] ; then
	awk 'FNR == 3 {total+=$2} END {print total}'  clone.data.* > clone.total
	paste -d ' ' ../../clone.heading clone.data.* | column -t -s' ' > clone.table
fi

#	Parse vistors (views) data from ${FILE_ORG_NAME}.no-headers
cat  ${FILE_ORG_NAME}.no-headers | sed -e '1,/\/popular\/paths>>>/!d' -e '1,/views:\[/d' -e '/^\]/,$d'  > ${FILE_ORG_NAME}.tmp 
#	Loop through ${FILE_ORG_NAME}.tmp and create clone.data.$timestamp files
while read line; do
	FIRST_LINE_STRING=$(echo ${line} | cut -d: -f 1)
	if [ "${FIRST_LINE_STRING}" == "timestamp" ] ;  then
		SECOND_LINE_STRING=$(echo ${line} | cut -d: -f 2)
		CLONE_FILE_NAME="view.data.${SECOND_LINE_STRING}"
                tmp=$(echo ${line} | cut -d: -f 2 | cut -d\- -f 2-3)
                echo "| ${tmp}" > ${CLONE_FILE_NAME}
                echo "|:---:" >> ${CLONE_FILE_NAME}
	else
                AMOUNT=$(echo ${line} | cut -d: -f 2)
                echo "| ${AMOUNT}" >> ${CLONE_FILE_NAME}
	fi
done < ${FILE_ORG_NAME}.tmp
rm  ${FILE_ORG_NAME}.tmp
#
if [ "view.data.*" -s ] ; then
	awk 'FNR == 3 {total+=$2} END {print total}'  view.data.*     > view.total
	paste -d ' ' ../../view.heading view.data.* | column -t -s' ' > view.table
fi

rm  ${FILE_ORG_NAME}.no-headers

#       column -t -s' ' filename
#       soffice --convert-to png ./clones
#       display ./clones.png
#
#	<img alt="Steam Views" src="https://img.shields.io/steam/views/100">
#
#	cd ~/github/BradleyA/automate/:repo
#	git pull
#	git commit -m '$DATE: automation the update of README table' README.md
#	git push README.md
#
###
