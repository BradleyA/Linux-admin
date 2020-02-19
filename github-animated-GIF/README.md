**WARNING:** These instructions below are incomplete. Consider them as notes quickly drafted on a napkin rather than proper documentation!  I need to get this completed then some cleanup  . . .
  
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
