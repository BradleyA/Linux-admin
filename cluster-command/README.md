# cluster-command

This script runs a command from a set of predefined commands on several hosts.  

The hostnames are found in a file (/usr/local/data/us-tx-cluster-1/SYSTEMS) with one hostname per line.  Lines in this file that begin with a # are comments.  The defualt location for this cluster host file, SYSTEMS, is /usr/local/data/us-tx-cluster-1.  A different path and SYSTEMS file can be entered on the command line as the second argument.

Example of first argument, predefind commands (enter 'cluster-command -h' for latest list)

 * shutdown       - sudo shutdown -f now
 * reboot         - sudo reboot

 * os             - lsb_release -d
 * cpu            - lscpu
 * date           - date
 * last           - lastlog | grep -v '**Never logged in**'
 * who            - who
 * ip             - ip a
 * netstat        - sudo netstat -natup
 * uptime         - uptime

 * docker-version - docker version | grep -m 1 'Version:'
 * docker-release - grep docker /etc/apt/sources.list
 * docker-df      - docker system df
 * docker-df-v    - docker system df --verbose
 * docker-info    - docker system info | head -6
 * ls-docker-con  - docker container ls
 * ls-docker-ima  - docker images
 * ls-docker-net  - docker network ls
 * ls-docker-vol  - docker volume ls
 * clean-docker-ima	- docker image rm $(docker image ls --filter='dangling=true' -q)
 * clean-docker-vol	- docker volume rm $(docker volume ls --filter dangling=true -q)
 * prune-docker-net	- docker network prune
 * prune-docker-vol	- docker volume prune
 * prune-docker-all	- docker system prune

 * showhold       - apt-mark showhold
 * update         - sudo apt-get update ;
                    /usr/lib/update-notifier/apt-check --human-readable
 * upgrade        - sudo apt-get upgrade --assume-yes ;
                    if [ -f /var/run/reboot-required ] ; then
                    echo 'reboot required' ; else
                    echo 'no reboot required' ; fi
 * dist-upgrade   - sudo apt-get dist-upgrade --assume-yes
 * autoremove     - sudo apt-get autoremove --assume-yes
 * require-reboot - if [ -f /var/run/reboot-required ]; then echo 'reboot
                    required' ; else echo 'no reboot required' ; fi
 * require-upgrade - /usr/lib/update-notifier/apt-check --human-readable
 * upgrade-package - apt-get upgrade --simulate | grep -vE 'Conf|Inst'

HOSTFILE     Other file with hostnames, default /usr/local/bin/cluster-command.txt


## Clone

To clone, change to the directory you want to download the script, README, and host file, SYSTEMS. Use git to clone these files into your directory. If you do not have git then enter; "sudo apt-get install git". On the github page of this script use the "HTTPS clone URL" with the 'git clone' command.

    git clone https://github.com/BradleyA/Linux-admin
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
    
## Install

To install a new version of cluster-command.sh, change to the directory, cd /usr/local/bin, to download the script.  The following command does not download the required /usr/local/data/us-tx-cluster-1/SYSTEMS text file.

    curl -L https://api.github.com/repos/BradleyA/Linux-admin/tarball | tar -xzf - --wildcards */cluster-command.sh ; mv BradleyA-Linux-admin-*/cluster-command/cluster-command.sh . ; rm -rf BradleyA-Linux-admin-*

#### System OS script tested
 * Ubuntu 14.04.3 LTS
 * Ubuntu 16.04.3 LTS (armv7l)

#### Design Principles
 * Have a simple setup process and a minimal learning curve
 * Be usable as non-root (failed: some commands require root)
 * Be easy to install and configure

## License
MIT License

Copyright (c) 2019  Bradley Allen

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

