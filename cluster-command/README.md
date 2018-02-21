# cluster-command

#### WARNING: These instructions are incomplete. Consider them as notes quickly drafted on a napkin rather than proper documentation!

cluster-command is a bash script that loops through a list fo RaspBerry pi and issues shutdown -f now. 

## Install

To install, change to the directory you want to download the scripts.

curl -L https://api.github.com/repos/BradleyA/docker-scripts/tarball | tar -xzf - --wildcards */c* ; mv BradleyA-docker-scripts*/docker-TLS/c* . ; rm -rf BradleyA-docker-scripts-*/

## Clone

To clone, change to the directory you want to download the scripts. Use git to clone these scripts into your directory. If you do not have git then enter; "sudo apt-get install git". On the github page of this script use the "HTTPS clone URL" with the 'git clone' command.

git clone https://github.com/BradleyA/docker-scripts
cd docker-scripts/docker-TLS


## Usage
    cluster-command.sh

## Output
    _____

#### System OS script tested
 * Ubuntu 14.04.3 LTS

#### Design Principles
 * Have a simple setup process and a minimal learning curve
 * Be usable as non-root
 * Be easy to install and configure

## License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
