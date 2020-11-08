# cluster-command

This script runs a command from a set of predefined commands on several hosts.  

This script reads /usr/local/data/us-tx-cluster-1/SYSTEMS file for hosts.  The <DATA_DIR>/<CLUSTER>/<SYSTEMS_FILE> includes one FQDN or IP address per line for all hosts in the cluster.  Lines in <SYSTEMS_FILE> that begin with a '#' are comments.  The <SYSTEMS_FILE> is used by markit/find-code.sh, Linux-admin/cluster-command/cluster-command.sh, docker-TLS/copy-registry-tls.sh,
pi-display/create-message/create-display-message.sh, and other scripts.  A different <SYSTEMS_FILE> can be entered on the command line or environment variable.

The user may receive password and/or passphrase prompts from a remote systen; running the following with the remote hostname or IP address may stop the prompts in your cluster.

    ssh-copy-id <TLS_USER>@<REMOTE_HOST>

If that does not resolve the prompting challenge then review the man pages for
ssh-agent and ssh-add before entering the following in a terminal window.

    eval $(ssh-agent)
    ssh-add

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)

## Clone
To Install, change into a directory that you want to download the scripts. Use git to pull or clone these scripts into the directory. If you do not have Git installed then enter; "sudo apt-get install git" if using Debian/Ubuntu. Other Linux distribution install methods can be found here: https://git-scm.com/download/linux. On the GitHub page of this script use the "HTTPS clone URL" with the 'git clone' command.

    git clone https://github.com/BradleyA/Linux-admin.git
    cd Linux-admin/cluster-command
    
    mkdir -p /usr/local/bin
    mv cluster-command.sh /usr/local/bin
    
    mkdir -p /usr/local/data/us-tx-cluster-1
    mv SYSTEMS /usr/local/data/us-tx-cluster-1/

    <edit> /usr/local/data/us-tx-cluster-1/SYSTEMS

## Usage
    $ cluster-command.sh require-upgrade

## Data File
    /usr/local/data/us-tx-cluster-1/SYSTEMS
#### CONTENT OF /usr/local/data/us-tx-cluster-1/SYSTEMS FILE
    ###     List of hosts used by cluster-command.sh, create-message.sh
    ###
    #       One FQDN host on each line
    ###
    #  -> Raspberry Pi us-tx-cluster-1
    one-rpi3b.cptx86.com
    two-rpi3b.cptx86.com
    three-rpi3b.cptx86.com
    four-rpi3b.cptx86.com
    five-rpi3b.cptx86.com
    six-rpi3b.cptx86.com

## Output
      -->  one-rpi3b.cptx86.com
    0 packages can be updated. 0 updates are security updates.

      -->  two-rpi3b.cptx86.com
        # #####   All connections monitored   ##### #
    0 packages can be updated.
    0 updates are security updates.
    
      -->  three-rpi3b.cptx86.com
      	# #####   All connections monitored   ##### #
    18 packages can be updated.
    18 updates are security updates.
    
      -->  four-rpi3b.cptx86.com
      	# #####   All connections monitored   ##### #
    0 packages can be updated.
    0 updates are security updates.
    
      -->  five-rpi3b.cptx86.com
	      # #####   All connections monitored   ##### #
    19 packages can be updated.
    18 updates are security updates.
    
      -->  six-rpi3b.cptx86.com
	      # #####   All connections monitored   ##### #
    19 packages can be updated.
    18 updates are security updates.
    
    /usr/local/bin/cluster-command.sh 117 [INFO]:	Done.

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)

#### SCRIPT OPTIONS
Example of first argument, predefind commands (enter '**cluster-command.sh --help**' for latest list)

|  Option          |   | Command |
|------------------|:---:|-------------|
shutdown          | - | sudo shutdown -f now
reboot            | + | sudo reboot
|                 |   |   |
os                | - | lsb_release -d 
cpu               | - | lscpu 
date              | + | date 
df                | + | df 
last              | - | lastlog | grep -v '**Never logged in**'
who               | + | who 
ip                | - | ip a 
netstat           | - | sudo netstat -natup 
uptime            | + | uptime 
|                 |   |   |
docker-version    | - | docker version | grep 'Version:' 
docker-release    | - | grep docker /etc/apt/sources.list 
docker-df         | - | docker system df 
docker-df-v       | - | docker system df --verbose 
docker-info       | + | docker system info 
docker-info-con   | - | docker system info \| head -6 
docker-info-swarm | - | docker system info \| grep -i swarm 
docker-con-ls     | + | docker container ls 
docker-ima-ls     | + | docker images
docker-net-ls     | + | docker network ls
docker-vol-ls     | + | docker volume ls
docker-ima-clean  | - | docker image rm $(docker image ls --filter='dangling=true' -q)
docker-vol-clean  | - | docker volume rm $(docker volume ls --filter dangling=true -q)
docker-net-prune  | + | docker network prune 
docker-vol-prune  | + | docker volume prune 
docker-all-prune  | + | docker system prune 
|                 |   |   |
update            | - | sudo apt-get update ; 
|                 |   | /usr/lib/update-notifier/apt-check --human-readable
upgrade           | - | sudo apt-get upgrade --assume-yes ; 
|                 |   | if [ -f /var/run/reboot-required ] ; then
|                 |   | echo 'reboot required' ; else
|                 |   | echo 'no reboot required' ; fi 
dist-upgrade      | - | sudo apt-get dist-upgrade --assume-yes
autoremove        | - | sudo apt-get autoremove --assume-yes
showhold          | - | apt-mark showhold
unhold            | - | apt-mark unhold
hold              | - | apt-mark hold
require-reboot    | - | if [ -f /var/run/reboot-required ]; then echo 'reboot
|                 |   | required' ; else echo 'no reboot required' ; fi
require-upgrade   | - | /usr/lib/update-notifier/apt-check --human-readable
upgrade-package   | - | apt-get upgrade --simulate | grep -vE 'Conf|Inst'
|                 |   | apt list --upgradeable -> does not work on Ubuntu 14.04
|                 |   |     |
disable-user      | + | sudo usermod --expiredate 1
enable-user       | + | sudo usermod --expiredate ''
|                 |   |     | 
special           | + |     |
root-special      | + | sudo 

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)

#### ARCHITECTURE TREE

    /usr/local/data/                           <-- <DATA_DIR>
    └── <CLUSTER>/                             <-- <CLUSTER>
        └── SYSTEMS                            <-- List of hosts in cluster

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)

## Install

To install a new version of cluster-command.sh, change to the directory, cd /usr/local/bin, to download the script.  The following command does not download the required /usr/local/data/us-tx-cluster-1/SYSTEMS text file.

    curl -L https://api.github.com/repos/BradleyA/Linux-admin/tarball | tar -xzf - --wildcards */cluster-command.sh ; mv BradleyA-Linux-admin-*/cluster-command/cluster-command.sh . ; rm -rf BradleyA-Linux-admin-*
    
#### To watch future updates in this repository select in the upper-right corner, the "Watch" list, and select Watching.

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)

----

#### Contribute
Please do contribute!  Issues and pull requests are welcome.  Thank you for your help improving software.

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)

#### Author
[<img id="github" src="images/github.png" width="50" a="https://github.com/BradleyA/">](https://github.com/BradleyA/)    [<img src="images/linkedin.png" style="max-width:100%;" >](https://www.linkedin.com/in/bradleyhallen) [<img id="twitter" src="images/twitter.png" width="50" a="twitter.com/bradleyaustintx/">](https://twitter.com/bradleyaustintx/)       <a href="https://twitter.com/intent/follow?screen_name=bradleyaustintx"> <img src="https://img.shields.io/twitter/follow/bradleyaustintx.svg?label=Follow%20@bradleyaustintx" alt="Follow @bradleyaustintx" />    </a>          [![GitHub followers](https://img.shields.io/github/followers/BradleyA.svg?style=social&label=Follow&maxAge=2592000)](https://github.com/BradleyA?tab=followers)

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)

#### Tested OS
 * Ubuntu 14.04.6 LTS (amd64,armv7l)
 * Ubuntu 16.04.7 LTS (amd64,armv7l)
 * Ubuntu 18.04.5 LTS (amd64,armv7l)
 * Raspbian GNU/Linux 10 (buster)

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)

#### Design Principles
 * Have a simple setup process and a minimal learning curve
 * Be usable as non-root (failed: some commands require root)
 * Be easy to install and configure

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)

## License
MIT License

Copyright (c) 2019  Bradley Allen

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[Return to top](https://github.com/BradleyA/Linux-admin/tree/master/cluster-command#cluster-command)
