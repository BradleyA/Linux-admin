**WARNING:** These instructions below are incomplete. Consider them as notes quickly drafted on a napkin rather than proper documentation!  I need to get this to work and completed then some cleanup before it is shareable . . .
  
    https://medium.com/@pczarkowski/how-to-make-an-animated-gif-of-your-terminal-commands-62b08dfb6089
    
    my notes:
    Thanks Paul!
    ssh -X uadmin@five-rpi3b.cptx86.com

    cd ~/github/animated-GIF/

    export PATH=$PATH:~/github/animated-GIF/bin
    export WINDOWID=$(xdotool getwindowfocus)  # 12-29-2019 added https://github.com/icholy/ttygif/blob/master/README.md
    
    How to make an animated GIF of your terminal commands
    Paul Czarkowski
    Oct 6, 2017 · 1 min read
    
    Sometimes a dump of text in a code block just isn’t enough. Here’s how to record your terminal session turn it into an animated GIF.
    
    Install the following:
    
        https://github.com/mjording/ttyrec
        https://github.com/icholy/ttygif
        https://github.com/pornel/giflossy
    
    Record, GIFerize, and Optimize your terminal:
    
    $ ttyrec FILE
    # do some stuff
    ctrl-D
    $ ttygif FILE
    $ gifsicle -O3 -k 8 --lossy=80 -o tty-small.gif tty.gif

    $ ls -alh tty*.gif
    -rw-rw-r-- 1 bob bob 386K Oct  6 16:10 tty.gif
    -rw-rw-r-- 1 bob bob 186K Oct  6 16:12 tty-small.gif
    
    ttyrec of using ttyrec <insert yo dawg meme here>
    
        Linux
        Terminal
        Recording
        Animated Gif
