#!/bin/bash
# 	cluster-command.sh  1.18.103  2018-07-30_12:14:43_CDT  https://github.com/BradleyA/Linux-admin  uadmin  three-rpi3b.cptx86.com 1.17-2-g679ac99  
# 	   #11 changed order of options, updated help, added poweroff 
# 	cluster-command.sh  1.17.100  2018-07-27_18:33:29_CDT  https://github.com/BradleyA/Linux-admin  uadmin  three-rpi3b.cptx86.com 1.16-8-g6229d6b  
# 	   change default directory name to /usr/local/data/us-tx-cluster-1/SYSTEMS to support scaling this process 
# 	cluster-command.sh  1.16.91  2018-03-18_13:17:40_CDT  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 1.15  
# 	   added require-update to require-upgrade 
# 	cluster-command.sh  1.15.90  2018-03-14_21:05:05_CDT  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 1.14-12-g2c16a3b  
# 	   modify command download in README 
# 	cluster-command.sh  1.14.77  2018-03-10_20:54:45_CST  https://github.com/BradleyA/Linux-admin  uadmin  six-rpi3b.cptx86.com 1.13-16-gd9756b6  
# 	   cluster-command.txt mv to SYSTEMS file and change location to /usr/local/data/cluster-1 closes #9 
#
#	set -x
#	set -v
#
#	administration cluster commands for Raspberry Pi and x86 clusters
#	   ssh $USER@rpi3b-$NODE.$DOMAIN 'sudo shutdown -f now';
###		
display_help() {
echo -e "\n${0} - remote cluster system adminstration tool"
echo -e "\nUSAGE\n   ${0} [<PREDEFINED-COMMAND>] [<SSHPORT>] [<path>/<HOSTFILE>]"
echo    "   ${0} [--help | -help | help | -h | h | -? | ?] [--version | -v]"
echo -e "\nDESCRIPTION\nThis script runs a command from a set of predefined commands on hosts."
echo    "The hostnames of the hosts are found in a file with one FQDN or IP address per"
echo    "line for all hosts in a cluster.  Lines in SYSTEMS file that begin with a # are"
echo    "comments.  The defualt location for this cluster command host file, SYSTEMS, is"
echo    "/usr/local/data/us-tx-cluster-1/SYSTEMS.  The SYSTEMS file is used by"
echo    "Linux-admin/cluster-command.sh & pi-display/create-message.sh.  A different"
echo    "path and cluster command host file can be entered on the command line as the"
echo    "second argument."
echo -e "\nOPTIONS "
echo    "   PREDEFINED-COMMAND"
echo    "      shutdown       - sudo shutdown -f now"
echo    "      reboot         - sudo reboot"
echo -e "      poweroff       - wall 'System power off, now';sync;sync;sync;sudo poweroff\n"
echo    "      os             - lsb_release -d"
echo    "      cpu            - lscpu"
echo    "      date           - date"
echo    "      df             - df"
echo    "      last           - lastlog | grep -v '**Never logged in**'"
echo    "      who            - who"
echo    "      ip             - ip a"
echo    "      netstat        - sudo netstat -natup"
echo    "      uptime         - uptime"
echo -e "      showhold       - apt-mark showhold\n"
echo    "      docker-version - docker version | grep -m 1 'Version:'"
echo    "      docker-release - grep docker /etc/apt/sources.list"
echo    "      docker-df      - docker system df"
echo    "      docker-df-v    - docker system df --verbose"
echo    "      docker-info    - docker system info | head -6"
echo    "      ls-docker-con  - docker container ls"
echo    "      ls-docker-ima  - docker images"
echo    "      ls-docker-net  - docker network ls"
echo    "      ls-docker-vol  - docker volume ls"
echo    "      clean-docker-ima	- docker image rm \$(docker image ls --filter='dangling=true' -q)"
echo    "      clean-docker-vol	- docker volume rm \$(docker volume ls --filter dangling=true -q)"
echo    "      prune-docker-net	- docker network prune"
echo    "      prune-docker-vol	- docker volume prune"
echo -e "      prune-docker-all	- docker system prune\n"
echo    "      update         - sudo apt-get update"
echo    "      upgrade        - sudo apt-get upgrade --assume-yes"
echo    "      dist-upgrade   - sudo apt-get dist-upgrade --assume-yes"
echo    "      autoremove     - sudo apt-get autoremove --assume-yes"
echo    "      require-reboot - if [ -f /var/run/reboot-required ]; then echo 'reboot"
echo    "                       required' ; else echo 'no reboot required' ; fi"
echo    "      require-upgrade - /usr/lib/update-notifier/apt-check --human-readable" # not sure this is the correct command becasue one-rpi3b stated no upgrade but then did eight upgrades
echo    "      upgrade-package - apt-get upgrade --simulate | grep -vE 'Conf|Inst'"
echo    "                        apt list --upgradeable -> does not work on Ubuntu 14.04"
echo    "   SSHPORT      SSH server port, default is port 22"
echo    "   HOSTFILE     File with hostnames, default /usr/local/data/us-tx-cluster-1/SYSTEMS"
echo -e "\nDOCUMENTATION\n   https://github.com/BradleyA/pi-scripts/tree/master/cluster-command"
echo -e "\nEXAMPLES\n   Shutdown raspberry pi clusters\n\t${0} shutdown\n"
}
if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] || [ "$1" == "?" ] ; then
        display_help
        exit 0
fi
if [ "$1" == "--version" ] || [ "$1" == "-v" ] ||  [ "$1" == "version" ]  ; then
        head -2 ${0} | awk {'print$2"\t"$3'}
        exit 0
fi
###
#	execpt only commands in case statement
REMOTECOMMAND=${1:-""}
#	open issues :add argument or flag argument for a single host and not use SYSTEMS file to execute a new command or a commad defined in this file
SSHPORT=${2:-22}
HOSTFILE=${3:-"/usr/local/data/us-tx-cluster-1/SYSTEMS"}
LOCALHOST=`hostname -f`
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
#       Check for ${HOSTFILE} file
if [ ! -e ${HOSTFILE} ] ; then
        echo -e "${0} ${LINENO} [WARN]:        ${HOSTFILE} NOT found"   1>&2
        exit 0
fi
REMOTEHOST=`grep -v "#" ${HOSTFILE}`
###
case ${REMOTECOMMAND} in
	shutdown)
		REMOTECOMMAND="sudo shutdown -f now"
		;;
	reboot)
		REMOTECOMMAND="sudo reboot"
		;;
	poweroff)
		REMOTECOMMAND="wall 'System power off, now';sync;sync;sync;sudo poweroff"
		;;
	OS|os)
		REMOTECOMMAND="lsb_release -d"
		;;
	CPU|cpu)
		REMOTECOMMAND="lscpu"
		;;
	date)
		REMOTECOMMAND="date"
		;;
	df)
		REMOTECOMMAND="df"
		;;
	last)
		REMOTECOMMAND="lastlog | grep -v '**Never logged in**'"
		;;
	who)
		REMOTECOMMAND="who"
		;;
	ip)
		REMOTECOMMAND="ip a"
		;;
	netstat)
		REMOTECOMMAND="sudo netstat -natup"
		;;
	uptime)
		REMOTECOMMAND="uptime"
		;;
	showhold)
		REMOTECOMMAND="apt-mark showhold"
		;;
	docker-version)
		REMOTECOMMAND="docker version | grep -m 1 'Version:'"
		;;
	docker-release)
		REMOTECOMMAND="grep docker /etc/apt/sources.list"
		;;
	docker-df)
		REMOTECOMMAND="docker system df"
		;;
	docker-df-v)
		REMOTECOMMAND="docker system df --verbose"
		;;
	docker-info)
		REMOTECOMMAND="docker system info | head -6"
		;;
	ls-docker-con)
		REMOTECOMMAND="docker container ls"
		;;
	ls-docker-ima)
		REMOTECOMMAND="docker images"
		;;
	ls-docker-net)
		REMOTECOMMAND="docker network ls"
		;;
	ls-docker-vol)
		REMOTECOMMAND="docker volume ls"
		;;
	clean-docker-vol)
		REMOTECOMMAND="docker volume rm \$(docker volume ls --filter dangling=true -q)"
		;;
	clean-docker-ima)
		REMOTECOMMAND="docker image rm \$(docker image ls --filter='dangling=true' -q)"
		;;
	prune-docker-net)
		REMOTECOMMAND="docker network prune"
		;;
	prune-docker-vol)
		REMOTECOMMAND="docker volume prune"
		;;
	prune-docker-all)
		REMOTECOMMAND="docker system prune"
		;;
	update)
		REMOTECOMMAND="sudo apt-get update"
		;;
	upgrade)
		REMOTECOMMAND="sudo apt-get upgrade --assume-yes"
		;;
	dist-upgrade)
		REMOTECOMMAND="sudo apt-get dist-upgrade --assume-yes"
		;;
	autoremove)
		REMOTECOMMAND="sudo apt-get autoremove  --assume-yes"
		;;
	require-reboot)
		REMOTECOMMAND="if [ -f /var/run/reboot-required ]; then echo 'reboot required' ; else echo 'no reboot required' ; fi"
		;;
	require-upgrade|require-update)
		REMOTECOMMAND="/usr/lib/update-notifier/apt-check --human-readable"
		;;
	upgrade-package)
		REMOTECOMMAND="apt-get upgrade --simulate  | grep -vE 'Conf|Inst'"
		;;
	*)
		echo -e "\n${NORMAL}${0} ${LINENO} [${BOLD}INFO${NORMAL}]:	${REMOTECOMMAND} - NOT a supported command"
		exit 0
		;;
esac
#
for NODE in ${REMOTEHOST} ; do
	echo -e "\n${BOLD}  -->  ${NODE}${NORMAL}	->${REMOTECOMMAND}<-" 
	if [ "${LOCALHOST}" != "${NODE}" ] ; then
#       Check if ${REMOTEHOST} is available on port ${SSHPORT}
		if $(nc -z  ${NODE} ${SSHPORT} >/dev/null) ; then
			ssh -t ${USER}@${NODE} ${REMOTECOMMAND} 
		else
        		echo -e "${NORMAL}${0} ${LINENO} [${BOLD}WARN${NORMAL}]:	${NODE} not responding on port ${SSHPORT}.\n"	1>&2
		fi
	else
		eval ${REMOTECOMMAND}
	fi
done
echo -e "\n${NORMAL}${0} ${LINENO} [${BOLD}INFO${NORMAL}]:	Done.\n"	1>&2
###
