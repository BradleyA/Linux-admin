# github-animated-GIF   [![Release Status](https://img.shields.io/badge/Status_-Alpha-red.svg)](https://github.com/BradleyA/Linux-admin/blob/master/github-animated-GIF/README.md#github-animated-gif----pi-servo--)

 **WARNING:** These instructions below are incomplete. Consider them as notes quickly drafted on a napkin rather than proper documentation!  I need to get this completed then some cleanup  . . . 

<img id="Construction" src="../images/construction-icon.gif" width="120">

#### If you like this repository, select in the upper-right corner, [![GitHub stars](https://img.shields.io/github/stars/BradleyA/Linux-admin.svg?style=social&label=Star&maxAge=2592000)](https://GitHub.com/BradleyA/Linux-admin/stargazers/), thank you.

  
    my notes after reading this from Paul
    Thanks Paul!
    
    ssh -X uadmin@five-rpi3b.cptx86.com

    cd ~/github/animated-GIF/
    export PATH=$PATH:~/github/animated-GIF/bin
    export WINDOWID=$(xdotool getwindowfocus)  # 12-29-2019 added https://github.com/icholy/ttygif/blob/master/README.md
    
    $ ttyrec  FILE
    # do some stuff
    ctrl-D
    $ ttygif  FILE
    $ gifsicle -O3 -k 8 --lossy=80 -o  FILE.gif  tty.gif

    $ ls -alh tty*.gif
     -rw-rw-r-- 1 bob bob 386K Oct  6 16:10 tty.gif
     -rw-rw-r-- 1 bob bob 186K Oct  6 16:12 FILE.gif
     
    How to make an animated GIF of your terminal commands
    https://medium.com/@pczarkowski/how-to-make-an-animated-gif-of-your-terminal-commands-62b08dfb6089
    Paul Czarkowski
    Oct 6, 2017 · 1 min read
    
    Sometimes a dump of text in a code block just isn’t enough. 
    Here’s how to record your terminal session turn it into an animated GIF.
    
    Install the following:
    
        https://github.com/mjording/ttyrec
        https://github.com/icholy/ttygif
        https://github.com/pornel/giflossy
    . . .

* three-rpi3b
* five-rpi3b


## Install, Setup, and Configure Animated GIF

To download your copy of animated GIF tools, follow these steps. Use git to pull or clone these scripts into a directory. If you do not have git then enter; "sudo apt-get install git" if using Ubuntu.

Change to the /tmp directory and download/clone repository files to your Linux system.

    cd  /tmp
    git clone https://github.com/BradleyA/Linux-admin.git
    cd  Linux-admin/github-animated-GIF
    tar -xf ./animated-GIF.tar.gz
    
helpful links: 
    https://github.com/icholy/ttygif/blob/master/README.md
    https://reposhub.com/cpp/miscellaneous/icholy-ttygif.html
    

----

#### Contribute
Please do contribute!  Issues and pull requests are welcome.  Thank you for your help improving software.

[Return to top](https://github.com/BradleyA/Linux-admin/blob/master/github-animated-GIF/README.md#github-animated-gif)

#### Author
[<img id="github" src="../images/github.png" width="50" a="https://github.com/BradleyA/">](https://github.com/BradleyA/)    [<img src="../images/linkedin.png" style="max-width:100%;" >](https://www.linkedin.com/in/bradleyhallen) [<img id="twitter" src="../images/twitter.png" width="50" a="twitter.com/bradleyaustintx/">](https://twitter.com/bradleyaustintx/)       <a href="https://twitter.com/intent/follow?screen_name=bradleyaustintx"> <img src="https://img.shields.io/twitter/follow/bradleyaustintx.svg?label=Follow%20@bradleyaustintx" alt="Follow @bradleyaustintx" />    </a>          [![GitHub followers](https://img.shields.io/github/followers/BradleyA.svg?style=social&label=Follow&maxAge=2592000)](https://github.com/BradleyA?tab=followers)

[Return to top](https://github.com/BradleyA/Linux-admin/blob/master/github-animated-GIF/README.md#github-animated-gif)

#### Tested OS
 * Ubuntu 14.04.6 LTS (amd64,armv7l)
 * Ubuntu 16.04.7 LTS (amd64,armv7l)
 * Ubuntu 18.04.5 LTS (amd64,armv7l)
 * Raspbian GNU/Linux 10 (buster)

[Return to top](https://github.com/BradleyA/Linux-admin/blob/master/github-animated-GIF/README.md#github-animated-gif)

#### Design Principles
 * Have a simple setup process and a minimal learning curve
 * Be usable as non-root
 * Be easy to install and configure
 
[Return to top](https://github.com/BradleyA/Linux-admin/blob/master/github-animated-GIF/README.md#github-animated-gif)

#### License
MIT License

Copyright (c) 2020  [Bradley Allen](https://www.linkedin.com/in/bradleyhallen)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[Return to top](https://github.com/BradleyA/Linux-admin/blob/master/github-animated-GIF/README.md#github-animated-gif)
