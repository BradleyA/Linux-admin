# cluster-command

This script runs a command from a set of predefined commands on several hosts.  

The hostnames are found in a file (/usr/local/data/cluster-1/SYSTEMS) with one hostname per line.  Lines in this file that begin with a # are comments.  The defualt location for this cluster host file, SYSTEMS, is /usr/local/data/cluster-1.  A different path and SYSTEMS file can be entered on the command line as the second argument.

Example of first argument, predefind commands (enter 'cluster-command -h' for latest list)

 * shutdown       - sudo shutdown -f now
 * reboot         - sudo reboot

 * os             - lsb_release -d
 * cpu            - lscpu
 * date           - date
 * last           - lastlog | grep -v '**Never logged in**'
 * who            - who
 * uptime         - uptime
 * showhold       - apt-mark showhold

 * docker-version - docker version | grep -m 1 'Version:'
 * docker-release - grep docker /etc/apt/sources.list

 * update         - sudo apt-get update
 * upgrade        - sudo apt-get upgrade --assume-yes
 * dist-upgrade   - sudo apt-get dist-upgrade --assume-yes
 * autoremove     - sudo apt-get autoremove --assume-yes
 * require-reboot - if [ -f /var/run/reboot-required ]; then echo 'reboot
                    required' ; else echo 'no reboot required' ; fi
 * require-upgrade - /usr/lib/update-notifier/apt-check --human-readable
 * upgrade-package - apt-get upgrade --simulate | grep -vE 'Conf|Inst'

Second and third arguments:

HOSTFILE     Other file with hostnames, default /usr/local/bin/cluster-command.txt

SSHPORT      SSH server port, default is port 22

## Clone

To clone, change to the directory you want to download the script, README, and host file, SYSTEMS. Use git to clone these files into your directory. If you do not have git then enter; "sudo apt-get install git". On the github page of this script use the "HTTPS clone URL" with the 'git clone' command.

    git clone https://github.com/BradleyA/Linux-admin
    cd Linux-admin/cluster-command
    
    mkdir -p /usr/local/bin
    mv cluster-command /usr/local/bin
    
    mkdir -p /usr/local/data/cluster-1
    mv SYSTEMS /usr/local/data/cluster-1/

     <edit> /usr/local/data/cluster-1/SYSTEMS

## Usage
    $ cluster-command.sh require-upgrade

## Data
    /usr/local/data/cluster-1/SYSTEMS

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

To install, change to the directory, cd /usr/local/bin, to download the script and host file.

    curl -L https://api.github.com/repos/BradleyA/Linux-admin/tarball | tar -xzf - --wildcards */cluster-command.* ; mv BradleyA-Linux-admin-*/cluster-command/cluster-command.* . ; rm -rf BradleyA-Linux-admin-*

#### System OS script tested
 * Ubuntu 14.04.3 LTS
 * Ubuntu 16.04.3 LTS (armv7l)

#### Design Principles
 * Have a simple setup process and a minimal learning curve
 * Be usable as non-root (failed: some commands require root)
 * Be easy to install and configure

## License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
