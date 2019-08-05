#!/bin/bash
# 	github-repository/parse.repository.data.sh  2.70.276  2019-08-04T21:39:10.622934-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.69-30-g11a23d8  
# 	   github-repository/. . .  changed default output file for github data 
# 	github-repository/parse.repository.data.sh  2.69.245  2019-08-02T15:52:23.366053-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.68  
# 	   github-repository/parse.repository.data.sh updating parse notes 
# 	github-repository/parse.repository.data.sh  2.68.244  2019-08-02T14:48:41.130377-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.67  
# 	   github-repository/parse.repository.data.sh add template.sh code, the to edit first draft 
#       github-repository/parse.repository.data.sh  2.65.240  2019-08-01T23:26:27.358500-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.64  
#          github-repository/parse.repository.data.sh added design notes 
#       github-repository/parse.repository.data.sh  2.64.239  2019-08-01T23:19:27.795284-05:00 (CDT)  https://github.com/BradleyA/Linux-admin  uadmin  two-rpi3b.cptx86.com 2.63  
#          github-repository/parse.repository.data.sh added file 
###
#       need to write a parser
#               to parse data/owner.repositry.date files into a comma separated values text files (.csv) in /usr/local/data/github/owner/repository/
#               use .csv data or somthing to create an image or .png file <<<< NOT SURE THIS IS A GOOD IDEA >>>>
#               push files/README.md/images to github owner/repository/images/(clones.png,views.png, popular.referrers.list, popular.paths.list)
#               link images to github owner/repository/README.md page
#        .... NOTE to self need data first and dont want to waste time creating test data
#
#	clone.json
#	grep -e clones -e timestamp -e count -e uniques -e referrer -e title -e path -e views clones.json > clones.json-1
#	cat clones.json-1 | sed -e 's/"//g' -e 's/,//g' -e 's/T.*Z//' > clones.json-2
#
#	column -t -s' ' filename
#	soffice --convert-to png ./clones
#	display ./clones.png
#
#	also look at 'paste file1 file2 file3'
###
# %%%	### production standard 3.0 shellcheck
# %%%	### production standard 5.1.160 Copyright
# %%%	#	Copyright (c) 2019 Bradley Allen
# %%%	#	MIT License is in the online DOCUMENTATION, DOCUMENTATION URL defined below.
# %%%	### production standard 1.0 DEBUG variable
# %%%	#       Order of precedence: environment variable, default code
# %%%	if [ "${DEBUG}" == "" ] ; then DEBUG="0" ; fi   # 0 = debug off, 1 = debug on, 'export DEBUG=1', 'unset DEBUG' to unset environment variable (bash)
# %%%	#	set -x
# %%%	#	set -v
# %%%	BOLD=$(tput -Txterm bold)
# %%%	NORMAL=$(tput -Txterm sgr0)
# %%%	### production standard 7.0 Default variable value
# %%%	DEFAULT_USER="${USER}"
# %%%	DEFAULT_SSH_USER="${USER}"
# %%%	DEFAULT_TLS_USER="${USER}"
# %%%	DEFAULT_ADM_TLS_USER="${USER}"
# %%%	DEFAULT_USER_HOME=$(echo ~ | sed s/"${USER}"//)
# %%%	DEFAULT_DATA_DIR="/usr/local/data/"
# %%%	DEFAULT_CLUSTER="us-tx-cluster-1/"
# %%%	DEFAULT_SYSTEMS_FILE="SYSTEMS"
# %%%	DEFAULT_CERT_DIR="${HOME}/.docker"
# %%%	DEFAULT_CERT_DAEMON_DIR="/etc/docker/certs.d/daemon/"
# %%%	DEFAULT_CA_CERT="ca.pem"
# %%%	DEFAULT_CA_PRIVATE_CERT="ca-priv-key.pem"
# %%%	DEFAULT_NUMBER_DAYS="730"
# %%%	DEFAULT_REMOTE_COMMAND=""
# %%%	DEFAULT_REMOTE_COMMAND_OPTION=""
# %%%	DEFAULT_WORKING_DIRECTORY="$(echo ~/.docker/docker-ca)"
# %%%	DEFAULT_FQDN="$(hostname -f)"		# local host
# %%%	DEFAULT_REMOTE_HOST="$(hostname -f)"    # local host
# %%%	DEFAULT_REGISTRY_HOST="$(hostname -f)"    # local host
# %%%	DEFAULT_REGISTRY_PORT="5000"
# %%%	### production standard 8.3.214 --usage
# %%%	display_usage() {
# %%%	COMMAND_NAME=$(echo "${0}" | sed 's/^.*\///')
# %%%	echo -e "\n${NORMAL}${COMMAND_NAME}\n   brief description . . ."
# %%%	echo -e "\n${BOLD}USAGE${NORMAL}"
# %%%	echo -e "   ${COMMAND_NAME} [-c <CLUSTER>] [-d <DATA_DIR>] [-a <ADMUSER>] [-f <PATH>/<FILE_NAME>]\n"
# %%%	echo    "   ${COMMAND_NAME} [--help | -help | help | -h | h | -?]"
# %%%	echo    "   ${COMMAND_NAME} [--usage | -usage | -u]"
# %%%	echo    "   ${COMMAND_NAME} [--version | -version | -v]"
# %%%	}
# %%%	### production standard 0.3.214 --help
# %%%	display_help() {
# %%%	display_usage
# %%%	#	Displaying help DESCRIPTION in English en_US.UTF-8
# %%%	echo -e "\n${BOLD}DESCRIPTION${NORMAL}"
# %%%	echo    "<your help goes here>"
# %%%	echo    ">>> NEED TO COMPLETE THIS SOON, ONCE I KNOW HOW IT IS GOING TO WORK :-) <<<    |"
# %%%	
# %%%	echo -e "\n<<Paragraph two>>"
# %%%	
# %%%	echo -e "\nThe <DATA_DIR>/<CLUSTER>/<SYSTEMS_FILE> includes one FQDN or IP address per"
# %%%	echo    "line for all hosts in the cluster.  Lines in <SYSTEMS_FILE> that begin with a"
# %%%	echo    "'#' are comments.  The <SYSTEMS_FILE> is used by markit/find-code.sh,"
# %%%	echo    "Linux-admin/cluster-command/cluster-command.sh, docker-TLS/copy-registry-tls.sh,"
# %%%	echo    "pi-display/create-message/create-display-message.sh, and other scripts.  A"
# %%%	echo    "different <SYSTEMS_FILE> can be entered on the command line or environment"
# %%%	echo    "variable."
# %%%	
# %%%	echo -e "\nThis script works for the local host only.  To use check-host-tls.sh on a"
# %%%	echo    "remote hosts (one-rpi3b.cptx86.com) with ssh port of 12323 as uadmin user;"
# %%%	echo -e "\t${BOLD}ssh -tp 12323 uadmin@one-rpi3b.cptx86.com 'sudo check-host-tls.sh'${NORMAL}"
# %%%	
# %%%	echo    "To loop through a list of hosts in the cluster use,"
# %%%	echo    "https://github.com/BradleyA/Linux-admin/tree/master/cluster-command"
# %%%	echo -e "\t${BOLD}cluster-command.sh special 'sudo check-host-tls.sh'${NORMAL}"
# %%%	
# %%%	echo -e "\nThe administration user may receive password and/or passphrase prompts from a"
# %%%	echo    "remote systen; running the following may stop the prompts in your cluster."
# %%%	echo -e "\t${BOLD}ssh-copy-id <TLS_USER>@<REMOTE_HOST>${NORMAL}"
# %%%	echo    "or"
# %%%	echo -e "\t${BOLD}ssh-copy-id <TLS_USER>@<192.168.x.x>${NORMAL}"
# %%%	echo    "If that does not resolve the prompting challenge then review the man pages for"
# %%%	echo    "ssh-agent and ssh-add before entering the following in a terminal window."
# %%%	echo -e "\t${BOLD}eval \$(ssh-agent)${NORMAL}"
# %%%	echo -e "\t${BOLD}ssh-add${NORMAL}"
# %%%	
# %%%	### production standard 4.0 Documentation Language
# %%%	#	Displaying help DESCRIPTION in French fr_CA.UTF-8, fr_FR.UTF-8, fr_CH.UTF-8
# %%%	if [ "${LANG}" == "fr_CA.UTF-8" ] || [ "${LANG}" == "fr_FR.UTF-8" ] || [ "${LANG}" == "fr_CH.UTF-8" ] ; then
# %%%		echo -e "\n--> ${LANG}"
# %%%		echo    "<votre aide va ici>" # your help goes here
# %%%		echo    "Souhaitez-vous traduire la section description?" # Do you want to translate the description section?
# %%%	elif ! [ "${LANG}" == "en_US.UTF-8" ] ; then
# %%%		get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[WARN]${NORMAL}  Your language, ${LANG}, is not supported.  Would you like to translate the description section?" 1>&2
# %%%	fi
# %%%	echo -e "\n${BOLD}ENVIRONMENT VARIABLES${NORMAL}"
# %%%	echo    "If using the bash shell, enter; 'export DEBUG=1' on the command line to set"
# %%%	echo    "the DEBUG environment variable to '1' (0 = debug off, 1 = debug on).  Use the"
# %%%	echo    "command, 'unset DEBUG' to remove the exported information from the DEBUG"
# %%%	echo    "environment variable.  You are on your own defining environment variables if"
# %%%	echo    "you are using other shells."
# %%%	echo    "   DEBUG           (default off '0')"
# %%%	echo    "   CLUSTER         Cluster name (default '${DEFAULT_CLUSTER}')"
# %%%	echo    "   DATA_DIR        Data directory (default '${DEFAULT_DATA_DIR}')"
# %%%	echo    "   SYSTEMS_FILE    Hosts in cluster (default '${DEFAULT_SYSTEMS_FILE}')"
# %%%	echo -e "\n${BOLD}OPTIONS${NORMAL}"
# %%%	echo -e "Order of precedence: CLI options, environment variable, default code.\n"
# %%%	echo    "   -c, --cluster, -c=, --cluster=<CLUSTER>"
# %%%	echo -e "\tCluster name (default '${DEFAULT_CLUSTER}')\n"
# %%%	echo    "   -d, --datadir, -d=, --datadir=<DATA_DIR>"
# %%%	echo -e "\tData directory (default '${DEFAULT_DATA_DIR}')\n"
# %%%	echo    "   -a, --admuser, -a=, --admuser=<ADMUSER>"
# %%%	echo -e "\tSite SRE administrator, default is user running script\n"
# %%%	echo    "   -f, --file, -f=, --filename=<FILENAME>"
# %%%	echo -e "\tPath and file on system '<path>/<file_name>'\n"
# %%%	echo    "   -S, --ssh_user, -S=, --ssh_user=<SSH_USER>"
# %%%	echo -e "\tLocation of user home directory (default ${DEFAULT_USER_HOME})\n"
# %%%	echo    "   -U, --user_home, -U=, --user_home=<USER_HOME>"
# %%%	echo -e "   "
# %%%	### production standard 6.1.177 Architecture tree
# %%%	echo -e "\n${BOLD}ARCHITECTURE TREE${NORMAL}"	# STORAGE & CERTIFICATION
# %%%	echo    "/usr/local/data/                           <-- <DATA_DIR>"
# %%%	echo    "├── <CLUSTER>/                             <-- <CLUSTER>"
# %%%	echo    "│   ├── docker/                            <-- Root directory of persistent"
# %%%	echo    "│   │   │                                      Docker state files; (images)"
# %%%	echo    "│   │   └── ######.######/                 <-- Root directory of persistent"
# %%%	echo    "│   │                                          Docker state files; (images)"
# %%%	echo    "│   │                                          when using user namespace"
# %%%	echo    "│   ├── SYSTEMS                            <-- List of hosts in cluster"
# %%%	echo    "│   ├── log/                               <-- Host log directory"
# %%%	echo    "│   ├── logrotate/                         <-- Host logrotate directory"
# %%%	echo    "│   ├── docker-accounts/                   <-- Docker TLS certs"
# %%%	echo    "│   │   ├── <HOST-1>/                      <-- Host in cluster"
# %%%	echo    "│   │   │   ├── ssh/"
# %%%	echo    "│   │   │   │   ├── AllowUsers             <-- User name patterns allowed"
# %%%	echo    "│   │   │   │   ├── ssh_host_ed25519_fingerprint <-- XXXX think about only having one finger print file for all called fingerprint keytype"
# %%%	echo    "│   │   │   │   ├── ssh_host_rsa_fingerprint <-- "
# %%%	echo    "│   │   │   │   ├── ssh_known_hosts        <-- Host public keys for all"
# %%%	echo    "│   │   │   │   │                              known hosts in cluster"
# %%%	echo    "│   │   │   │   ├── shosts.equiv           <-- "
# %%%	echo    "│   │   │   │   ├── ssh_host_rsa_key       <-- OpenSSH host private key"
# %%%	echo    "│   │   │   │   ├── ssh_host_rsa_key.pub   <-- OpenSSH host public key"
# %%%	echo    "│   │   │   │   ├── ssh_host_ed25519_key   <-- OpenSSH host private key"
# %%%	echo    "│   │   │   │   ├── ssh_host_ed25519_key.pub <-- OpenSSH host public key"
# %%%	echo    "│   │   │   │   └── keys/"
# %%%	echo    "│   │   │   │       ├── <USER-1>/"
# %%%	echo    "│   │   │   │       │   └── authorized_keys"
# %%%	echo    "│   │   │   │       └── <USER-2>/"
# %%%	echo    "│   │   │   ├── <USER-1>/                  <-- User TLS certs directory"
# %%%	echo    "│   │   │   │   ├── docker         FUTURE  <-- User tlscacert"
# %%%	echo    "│   │   │   │   │   ├── ca.pem     FUTURE  <-- User tlscacert"
# %%%	echo    "│   │   │   │   │   ├── cert.pem   FUTURE  <-- User tlscert"
# %%%	echo    "│   │   │   │   │   ├── key.pem    FUTURE  <-- User tlskey"
# %%%	echo    "│   │   │   │   │   └── trust/             <-- Backup of Docker Content Trust"
# %%%	echo    "│   │   │   │   │                              (DCT) keys"
# %%%	echo    "│   │   │   │   └── ssh/"
# %%%	echo    "│   │   │   │       ├── authorized_keys    <-- SSH user public keys for login 644"
# %%%	echo    "│   │   │   │       └── inventory/ FUTURE  <-- SSH user inventory"
# %%%	echo    "│   │   │   └── <USER-2>/                  <-- User TLS certs directory"
# %%%	echo    "│   │   └── <HOST-2>/                      <-- Host in cluster"
# %%%	echo    "│   └── docker-registry/                   <-- Docker registry directory"
# %%%	echo    "│       ├── <REGISTRY_HOST>-<REGISTRY_PORT>/ < Registry container mount"
# %%%	echo    "│       │   ├── certs/                     <-- Registry cert directory"
# %%%	echo    "│       │   │   ├── domain.crt             <-- Registry cert"
# %%%	echo    "│       │   │   └── domain.key             <-- Registry private key"
# %%%	echo    "│       │   └── docker/                    <-- Registry storage directory"
# %%%	echo    "│       ├── <REGISTRY_HOST>-<REGISTRY_PORT>/ < Registry container mount"
# %%%	echo    "│       └── <REGISTRY_HOST>-<REGISTRY_PORT>/ < Registry container mount"
# %%%	echo    "└── <STANDALONE>/                          <-- <STANDALONE> Architecture tree"
# %%%	echo    "                                               is the same as <CLUSTER> TREE but"
# %%%	echo -e "                                               the systems are not in a cluster\n"
# %%%	echo    "<USER_HOME>/                               <-- Location of user home directory"
# %%%	echo    "├── <USER-1>/.docker/                      <-- User docker cert directory"
# %%%	echo    "│   ├── ca.pem                             <-- User tlscacert or symbolic link"
# %%%	echo    "│   ├── cert.pem                           <-- Symbolic link to user tlscert"
# %%%	echo    "│   ├── key.pem                            <-- Symbolic link to user tlskey"
# %%%	echo    "│   ├── docker-ca/                         <-- Working directory to create certs"
# %%%	echo    "│   ├── trust/                             <-- Docker Content Trust (DCT)"
# %%%	echo    "│   │   ├── private/                       <-- Notary Canonical Root Key ID"
# %%%	echo    "│   │   │                                      (DCT Root Key)"
# %%%	echo    "│   │   ├── trusted_certificates/          <-- Docker Content Trust (DCT) keys"
# %%%	echo    "│   │   └── tuf/                           <-- Update Framework (TUF)"
# %%%	echo    "│   ├── registry-certs-<REGISTRY_HOST>-<REGISTRY_PORT>/ <-- Working directory"
# %%%	echo    "│   │   │                                      to create registory certs"
# %%%	echo    "│   │   ├── ca.crt                         <-- Daemon registry domain cert"
# %%%	echo    "│   │   ├── domain.crt                     <-- Registry cert"
# %%%	echo    "│   │   └── domain.key                     <-- Registry private key"
# %%%	echo    "│   ├── registry-certs-<REGISTRY_HOST>-<REGISTRY_PORT>/ <-- Working directory"
# %%%	echo    "│   │                                          to create registory certs"
# %%%	echo    "│   └── registry-certs-<REGISTRY_HOST>-<REGISTRY_PORT>/ <-- Working directory"
# %%%	echo    "│                                              to create registory certs"
# %%%	echo    "└── <USER-1>/.ssh/                         <-- Secure Socket Shell directory"
# %%%	echo    "    ├── authorized_keys                    <-- SSH keys for logging into account"
# %%%	echo    "    ├── config                             <-- SSH user configuration file"
# %%%	echo    "    ├── id_rsa                             <-- SSH private key"
# %%%	echo    "    ├── id_rsa.pub                         <-- SSH public key"
# %%%	echo -e "    └── known_hosts                        <-- Systems previously connected to\n"
# %%%	echo    "/etc/ "
# %%%	echo    "├── docker/ "
# %%%	echo    "│   ├── certs.d/                           <-- Host docker cert directory"
# %%%	echo    "│   │   ├── daemon/                        <-- Daemon cert directory"
# %%%	echo    "│   │   │   ├── ca.pem                     <-- Daemon tlscacert"
# %%%	echo    "│   │   │   ├── cert.pem                   <-- Daemon tlscert"
# %%%	echo    "│   │   │   └── key.pem                    <-- Daemon tlskey"
# %%%	echo    "│   │   ├── <REGISTRY_HOST>:<REGISTRY_PORT>/ < Registry cert directory"
# %%%	echo    "│   │   │   └── ca.crt                     <-- Daemon registry domain cert"
# %%%	echo    "│   │   ├── <REGISTRY_HOST>:<REGISTRY_PORT>/ < Registry cert directory"
# %%%	echo    "│   │   └── <REGISTRY_HOST>:<REGISTRY_PORT>/ < Registry cert directory"
# %%%	echo    "│   ├── daemon.json                        <-- Daemon configuration file"
# %%%	echo    "│   ├── key.json                           <-- Automatically generated dockerd"
# %%%	echo    "│   │                                          key for TLS connections to other"
# %%%	echo    "│   │                                          TLS servers"
# %%%	echo    "│   ├── 10-override.begin                  <-- docker.service.d default lines"
# %%%	echo    "│   ├── dockerd-configuration-file         <-- Daemon configuration"
# %%%	echo    "│   ├── dockerd-configuration-file.service <- runs start-dockerd-with-systemd.sh"
# %%%	echo    "│   │                                          during boot"
# %%%	echo    "│   ├── docker.org                         <-- Copy of /etc/default/docker"
# %%%	echo    "│   ├── README.md"
# %%%	echo    "│   ├── setup-dockerd.sh                   <-- moves and creates files"
# %%%	echo    "│   ├── start-dockerd-with-systemd.begin   <-- Beginning default lines"
# %%%	echo    "│   ├── start-dockerd-with-systemd.end     <-- Ending default lines"
# %%%	echo    "│   ├── start-dockerd-with-systemd.sh"
# %%%	echo    "│   └── uninstall-dockerd-scripts.sh       <-- Removes files and scripts"
# %%%	echo    "├── systemd/system/                        <-- Local systemd configurations"
# %%%	echo    "│   ├── dockerd-configuration-file.service <-- Runs start-dockerd-with-systemd.sh"
# %%%	echo    "│   ├── docker.service.d/"
# %%%	echo    "│   │   └── 10-override.conf               <-- Override configutation file"
# %%%	echo    "│   └── docker.service.wants/              <-- Dependencies"
# %%%	echo    "├── default/"
# %%%	echo    "│   └── docker                             <-- Docker daemon Upstart and"
# %%%	echo    "│                                              SysVinit configuration file"
# %%%	echo    "├── ssl/"
# %%%	echo    "│   └── openssl.cnf                        <-- OpenSSL configuration file"
# %%%	echo    "├── ssh/"
# %%%	echo    "│   ├── moduli                             <-- Diffie-Hellman moduli"
# %%%	echo    "│   ├── shosts.equiv                       <-- host-based authentication"
# %%%	echo    "│   ├── ssh_config                         <-- OpenSSH systemwide configuration"
# %%%	echo    "│   │                                          file"
# %%%	echo    "│   ├── sshd_config                        <-- OpenSSH daemon configuration"
# %%%	echo    "│   │                                          file"
# %%%	echo    "│   ├── ssh_host_rsa_key                   <-- OpenSSH host private key"
# %%%	echo    "│   ├── ssh_host_rsa_key.pub               <-- OpenSSH host public key"
# %%%	echo    "│   ├── ssh_host_ed25519_key               <-- OpenSSH host private key"
# %%%	echo    "│   ├── ssh_host_ed25519_key.pub           <-- OpenSSH host public key"
# %%%	echo    ">>> NEED TO COMPLETE THIS SOON, ONCE I KNOW HOW IT IS GOING TO WORK :-) <<<    |"
# %%%	echo    "│   ├── ssh_known_hosts                    <-- OpenSSH systemwide list of known"
# %%%	echo    "│   │                                          public host keys"
# %%%	echo    "│   └── keys                               <-- Support SSH remote login when"
# %%%	echo    "│       │                                      user home directory encrypted"
# %%%	echo    "│       ├── <USER-1>/                      <-- User SSH authorized_keys directory 755"
# %%%	echo    "│       │   └── authorized_keys            <-- SSH user public keys for login 644"
# %%%	echo    "│       └── <USER-2>/                      <-- User systemwide SSH directory"
# %%%	echo -e "└── hosts.equiv                            <-- host-based authentication\n"
# %%%	echo    "/var/"
# %%%	echo    "├── lib/docker/                            <-- Root directory of persistent"
# %%%	echo    "│                                              Docker state files; (images)"
# %%%	echo    "│                                              changed to symbolic link pointing"
# %%%	echo    "│                                              to <DATA_DIR>/<CLUSTER>/docker"
# %%%	echo    "└── run/"
# %%%	echo    "    ├── docker/                            <-- Root directory for Docker"
# %%%	echo    "    │                                          execution state files"
# %%%	echo    "    ├── docker.pid                         <-- Docker daemon PID file"
# %%%	echo    "    └── docker.######.######/              <-- Root directory for Docker"
# %%%	echo    "                                               execution state files using"
# %%%	echo    "                                               user namespace"
# %%%	echo -e "\n${BOLD}DOCUMENTATION${NORMAL}"
# %%%	echo    "   https://github.com/BradleyA/   <<URL to online repository README>>"
# %%%	echo -e "\n${BOLD}EXAMPLES${NORMAL}"
# %%%	echo -e "   <<your code examples description goes here>>\n\t${BOLD}${COMMAND_NAME} <<code example goes here>>${NORMAL}"
# %%%	echo -e "   <<your code examples description goes here>>\n\t${BOLD}${COMMAND_NAME}${NORMAL}"
# %%%	}
# %%%	
# %%%	#	Date and time function ISO 8601
# %%%	get_date_stamp() {
# %%%	DATE_STAMP=$(date +%Y-%m-%dT%H:%M:%S.%6N%:z)
# %%%	TEMP=$(date +%Z)
# %%%	DATE_STAMP="${DATE_STAMP} (${TEMP})"
# %%%	}
# %%%	
# %%%	#	Fully qualified domain name FQDN hostname
# %%%	LOCALHOST=$(hostname -f)
# %%%	
# %%%	#	Version
# %%%	SCRIPT_NAME=$(head -2 "${0}" | awk {'printf $2'})
# %%%	SCRIPT_VERSION=$(head -2 "${0}" | awk {'printf $3'})
# %%%	
# %%%	#	UID and GID
# %%%	USER_ID=$(id -u)
# %%%	GROUP_ID=$(id -g)
# %%%	
# %%%	#       Added following code because USER is not defined in crobtab jobs
# %%%	if ! [ "${USER}" == "${LOGNAME}" ] ; then  USER=${LOGNAME} ; fi
# %%%	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Setting USER to support crobtab...  USER >${USER}<  LOGNAME >${LOGNAME}<" 1>&2 ; fi
# %%%	
# %%%	#	Default help, usage, and version arguments
# %%%	if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] ; then
# %%%		display_help | more
# %%%		exit 0
# %%%	fi
# %%%	if [ "$1" == "--usage" ] || [ "$1" == "-usage" ] || [ "$1" == "usage" ] || [ "$1" == "-u" ] ; then
# %%%	        display_usage
# %%%	        exit 0
# %%%	fi
# %%%	if [ "$1" == "--version" ] || [ "$1" == "-version" ] || [ "$1" == "version" ] || [ "$1" == "-v" ] ; then
# %%%		echo "${SCRIPT_NAME} ${SCRIPT_VERSION}"
# %%%		exit 0
# %%%	fi
# %%%	
# %%%	### production standard 2.0 log format (WHEN WHERE WHAT Version Line WHO UID:GID [TYPE] Message)
# %%%	#	INFO
# %%%	get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[INFO]${NORMAL}  Started..." 1>&2
# %%%	
# %%%	#	DEBUG
# %%%	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Name_of_command >${0}< Name_of_arg1 >${1}< Name_of_arg2 >${2}< Name_of_arg3 >${3}<  Version of bash ${BASH_VERSION}" 1>&2 ; fi
# %%%	
# %%%	###
# %%%	#	Root is required to copy certs
# %%%	if ! [ $(id -u) = 0 ] ; then
# %%%		display_help | more
# %%%		get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Use sudo ${0}" 1>&2
# %%%	#       Help hint
# %%%		echo -e "\n\t${BOLD}>>   SCRIPT MUST BE RUN AS ROOT   <<\n${NORMAL}"	1>&2
# %%%		exit 1
# %%%	fi
# %%%	
# %%%	###
# %%%	#       Test <REGISTRY_PORT> for integer
# %%%	if ! [[ "${REGISTRY_PORT}" =~ ^[0-9]+$ ]] ; then        # requires [[   ]] or  [: =~: binary operator expected
# %%%	        get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  <REGISTRY_PORT> is not an interger.  <REGISTRY_PORT> is set to '${REGISTRY_PORT}'" 1>&2
# %%%	        exit 1
# %%%	fi
# %%%	
# %%%	###     Example arguments (1)
# %%%	### production standard 7.0 Default variable value
# %%%	#       Order of precedence: CLI argument, environment variable, default code
# %%%	if [ "${CLUSTER}" == "" ] ; then CLUSTER=${DEFAULT_CLUSTER} ; fi
# %%%	#       Order of precedence: CLI argument, default code
# %%%	ADMUSER=${DEFAULT_USER}
# %%%	#       Order of precedence: CLI argument, environment variable, default code
# %%%	if [ "${DATA_DIR}" == "" ] ; then DATA_DIR=${DEFAULT_DATA_DIR} ; fi
# %%%	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Variable... CLUSTER >${CLUSTER}< ADMUSER >${ADMUSER}< DATA_DIR >${DATA_DIR}<" 1>&2 ; fi
# %%%	
# %%%	### production standard 9.0 Parse CLI options and arguments
# %%%	while [[ "${#}" -gt 0 ]] ; do
# %%%	        case "${1}" in
# %%%	                -a|--admuser)
# %%%	                        if [ "${2}" == "" ] ; then      # Check if argument is blank
# %%%	                                display_usage
# %%%	                                get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Argument for ${1} is not found on command line" 1>&2
# %%%	                                exit 1
# %%%	                        fi
# %%%	                        ADMUSER=${2}
# %%%	                        shift 2 # shift past argument and value
# %%%	                        ;;
# %%%	                -a=*|--admuser=*)
# %%%	                        ADMUSER=$(echo "${1}" | cut -d '=' -f 2)
# %%%	                        shift # shift past argument=value
# %%%	                        ;;
# %%%	                -c|--cluster)
# %%%	                        if [ "${2}" == "" ] ; then      # Check if argument is blank
# %%%	                                display_usage
# %%%	                                get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Argument for ${1} is not found on command line" 1>&2
# %%%	                                exit 1
# %%%	                        fi
# %%%	                        CLUSTER=${2}
# %%%	                        shift 2 # shift past argument and value
# %%%	                        ;;
# %%%	                -c=*|--cluster=*)
# %%%	                        CLUSTER=$(echo "${1}" | cut -d '=' -f 2)
# %%%	                        shift # shift past argument=value
# %%%	                        ;;
# %%%	                -d|--datadir)
# %%%	                        if [ "${2}" == "" ] ; then      # Check if argument is blank
# %%%	                                display_usage
# %%%	                                get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Argument for ${1} is not found on command line" 1>&2
# %%%	                                exit 1
# %%%	                        fi
# %%%	                        DATA_DIR=${2}
# %%%	                        shift 2 # shift past argument and value
# %%%	                        ;;
# %%%	                -d=*|--datadir=*)
# %%%	                        DATA_DIR=$(echo "${1}" | cut -d '=' -f 2)
# %%%	                        shift # shift past argument=value
# %%%	                        ;;
# %%%	                -f|--filename)
# %%%	                        if [ "${2}" == "" ] ; then      # Check if argument is blank
# %%%	                                display_usage
# %%%	                                get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Argument for ${1} is not found on command line" 1>&2
# %%%	                                exit 1
# %%%	                        fi
# %%%	                        FILE_NAME=${2}
# %%%	                        shift 2 # shift past argument and value
# %%%	                        ;;
# %%%	                -f=*|--filename=*)
# %%%	                        FILE_NAME=$(echo "${1}" | cut -d '=' -f 2)
# %%%	                        shift # shift past argument=value
# %%%	                        ;;
# %%%	                -S|--ssh_user)
# %%%	                        if [ "${2}" == "" ] ; then      # Check if argument is blank
# %%%	                                display_usage
# %%%	                                get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Argument for ${1} is not found on command line" 1>&2
# %%%	                                exit 1
# %%%	                        fi
# %%%	                        SSH_USER=${2}
# %%%	                        shift 2 # shift past argument and value
# %%%	                        ;;
# %%%	                -S=*|--ssh_user=*)
# %%%	                        SSH_USER=$(echo "${1}" | cut -d '=' -f 2)
# %%%	                        shift # shift past argument=value
# %%%	                        ;;
# %%%	                -U|--user_home)				# USER_HOME="/home/"
# %%%	                        if [ "${2}" == "" ] ; then      # Check if argument is blank
# %%%	                                display_usage
# %%%	                                get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Argument for ${1} is not found on command line" 1>&2
# %%%	                                exit 1
# %%%	                        fi
# %%%	                        USER_HOME=${2}
# %%%	                        shift 2 # shift past argument and value
# %%%	                        ;;
# %%%	                -U=*|--user_home=*)			# USER_HOME="/home/"
# %%%	                        USER_HOME=$(echo "${1}" | cut -d '=' -f 2)
# %%%	                        shift # shift past argument=value
# %%%	                        ;;
# %%%	                *)
# %%%	                        get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Option, ${1}, entered on the command line is not supported." 1>&2
# %%%	                        display_usage
# %%%	                        exit 1
# %%%	                        ;;
# %%%	        esac
# %%%	done
# %%%	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Variable... CLUSTER >${CLUSTER}< ADMUSER >${ADMUSER}< DATA_DIR >${DATA_DIR}< FILE_NAME >${FILE_NAME}<" 1>&2 ; fi
# %%%	
# %%%	###     Example arguments (2)
# %%%	#       Order of precedence: CLI argument, default code
# %%%	OPTION1=${1:-default_value1}
# %%%	OPTION2=${2:-${DEFAULT_VALUE2}}
# %%%	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Variable... OPTION1 >${OPTION1}< OPTION2 >${OPTION2}<" 1>&2 ; fi
# %%%	#	Example arguments
# %%%	
# %%%	###     Example arguments (3)
# %%%	### production standard 7.0 Default variable value
# %%%	#	The order of argument options matters.
# %%%	#       Order of precedence: CLI argument, environment variable, default code
# %%%	if [ $# -ge  1 ]  ; then CLUSTER=${1} ; elif [ "${CLUSTER}" == "" ] ; then CLUSTER=${DEFAULT_CLUSTER} ; fi
# %%%	#       Order of precedence: CLI argument, default code
# %%%	ADMUSER=${2:-${DEFAULT_USER}}
# %%%	#       Order of precedence: CLI argument, environment variable, default code
# %%%	if [ $# -ge  3 ]  ; then DATA_DIR=${3} ; elif [ "${DATA_DIR}" == "" ] ; then DATA_DIR=${DEFAULT_DATA_DIR} ; fi
# %%%	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Variable... CLUSTER >${CLUSTER}< ADMUSER >${ADMUSER}< DATA_DIR >${DATA_DIR}<" 1>&2 ; fi
# %%%	
# %%%	###     Example arguments (4)
# %%%	#       Check arguement 1 xxx
# %%%	if [ "$1" != "no" ] && [ "$1" != "normal" ] && [ "$1" != "all" ] && [ "$1" != "" ] ; then
# %%%	        display_help | more
# %%%	        get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${BOLD}[ERROR]${NORMAL}  ${LOCALHOST}  ${USER}  ${USER_ID} ${GROUP_ID}  First arguement, ${1}, is NOT no, normal, all." 1>&2
# %%%	        exit 0
# %%%	fi
# %%%	
# %%%	#
# %%%	get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[INFO]${NORMAL}  Operation finished." 1>&2
# %%%	###


#	locate the latest file
###	
#	Remove header and other none information from file
FILE_ORG_NAME="BradleyA.user-files.2019-07-29"
grep -e clones -e timestamp -e count -e uniques -e views -e /popular/paths -e path -e title -e /popular/referrers  BradleyA.user-files-2019-07-29 | sed -e 's/"//g' -e 's/,//g' -e 's/T.*Z//' -e 's/[ \t]*//g' > ${FILE_ORG_NAME}.no-headers

#	process clones
cat  ${FILE_ORG_NAME}.no-headers | sed -e '1,/views>>>/!d' -e '1,4d' | sed '$ d' > ${FILE_ORG_NAME}.tmp 

while read line; do
	FIRST_LINE_STRING=$(echo ${line} | cut -d: -f 1)
	if [ "${FIRST_LINE_STRING}" == "timestamp" ] ;  then
		SECOND_LINE_STRING=$(echo ${line} | cut -d: -f 2)
		CLONE_FILE_NAME="clone-${SECOND_LINE_STRING}"
		echo ${line} | cut -d: -f 2 | cut -d\- -f 2-3 > ${CLONE_FILE_NAME}
	else
		echo ${line} | cut -d: -f 2 >> ${CLONE_FILE_NAME}
	fi
done < ${FILE_ORG_NAME}.tmp
rm  ${FILE_ORG_NAME}.tmp

paste -d ' ' clone.heading clone-* | column -t -s' ' > clone.table

#	process views 

rm  ${FILE_ORG_NAME}.no-headers

#       RAW data file example
#       clones
#       timestamp, 2019-07-15, 2019-07-22, 2019-07-29
#       count, 1, 27, 1
#       uniques, 1, 2, 1
#       
#       column -t -s' ' filename
#       soffice --convert-to png ./clones
#       display ./clones.png
#
#
#	<img alt="Steam Views" src="https://img.shields.io/steam/views/100">
#
#	cd ~/github/BradleyA/automate/:repo
#	git pull
#	git commit -m '$DATE: automation the update of README table' README.md
#	git push README.md
#
#
#
#
#
###
