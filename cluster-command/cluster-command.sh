#!/bin/bash
# 	cluster-command.sh	1.2.30	2018-02-21_13:36:37_CST uadmin six-rpi3b.cptx86.com 1.1 
# 	   comment out x86 hosts so I will not shutdown production cluster during testing; supports #1 
# 	cluster-shutdown.sh	1.0.22	2018-02-21_12:28:36_CST uadmin six-rpi3b.cptx86.com v0.1-21-g8174b37 
# 	   remove comment for enhancements and move to issues in github 
#
#	set -x
#	set -v
#
#	administration cluster comment for Raspberry Pi and x86 clusters
#	   ssh $USER@rpi3b-$NODE.$DOMAIN 'sudo shutdown -f now';
###		
display_help() {
echo -e "\n${0} - >>> NEED TO COMPLETE THIS SOON, ONCE i KNOW HOW IT IS GOING TO WORK :-) <<<"
echo -e "\nUSAGE\n   ${0}"
echo    "   ${0} [--help | -help | help | -h | h | -? | ?] [--version | -v]"
echo -e "\nDESCRIPTION\nsudo shutdown -f now"
echo -e "\nOPTIONS "
echo -e "\nDOCUMENTATION\n   https://github.com/BradleyA/pi-scripts/tree/master/cluster-shutdown"
echo -e "\nEXAMPLES\n   Shutdown raspberry pi clusters\n\t${0}\n"
}
if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] || [ "$1" == "?" ] ; then
        display_help
        exit 0
fi
if [ "$1" == "--version" ] || [ "$1" == "-v" ] ; then
        head -2 ${0} | awk {'print$2"\t"$3'}
        exit 0
fi
###
REMOTECOMMAND=${1:-"shutdown -f now"}
LOCALHOST=`hostname -f`
#
for NODE in one two three four five six ; do
	echo ${NODE}-rpi3b.${DOMAIN};
	if [ "${LOCALHOST}" != " ${NODE}-rpi3b.${DOMAIN}" ]; then
		ssh -tt ${USER}@${NODE}-rpi3b.${DOMAIN} 'stty raw -echo;sudo shutdown -f now';
	fi
done
echo "${LOCALHOST}"
sudo ${REMOTECOMMAND}
###
        case ${FILE_EXTENSION} in
                shutdown)
                        REMOTECOMMAND="shutdown -f now"
                        ;;
                c|h|H|hpp|hxx|Hxx|HXX)
#               c(c) C header(h|H|hpp) C++ header(hxx|Hxx|HXX) 
                        BEGIN_COMMENT_CHAR="/* "
                        END_COMMENT_CHAR=" */"
                        ;;
                cc|cpp|c++|cxx|go|java|class|jar|js|kt|kts|p|pp|pas|rs|rlib|scala|sc)
#               C++(cc|cpp|c++|cxx) Go(go) Java(java|class|jar) JavaScript(js) Kotlin(kt|kts) Pascal (p|pp|paa) Rust(rs|rlib) Scala(scala|sc)
                        BEGIN_COMMENT_CHAR="// "
                        END_COMMENT_CHAR=""
                        ;;
                xml|html|htm)
#               XML(xml) HTML (html|htm) 
                        BEGIN_COMMENT_CHAR="<!-- "
                        END_COMMENT_CHAR=" -->"
                        ;;
                *)
#                       Prompt for single-line beginning comment character(s)
                        echo -e "\nEnter single-line  BEGINNING  comment character(s) for ${FILE_NAME}\n   (example: # // -- ' ! C !* -- // % ;;  ||  /* <!-- <!--- {- /** --[[ %{ (* <# )"
                        read BEGIN_COMMENT_CHAR
                        if [ -z ${BEGIN_COMMENT_CHAR} ] ; then
                                display_help
                                echo -e "${0} ${LINENO} [ERROR]:        Single-line comment character(s) is required.\n"       1>&2
                                exit 1
                        fi
                        echo -e "\nEnter single-line  ENDING  comment character(s) for ${FILE_NAME}.\nPress enter for none.\n (example: */ --> ---> -} */ --]] %} *) #> )"
                        read END_COMMENT_CHAR
                        ;;
        esac

