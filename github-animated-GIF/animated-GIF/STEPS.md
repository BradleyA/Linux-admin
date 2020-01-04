#!/bin/bash

#	ssh -X uadmin@192.168.1.106

export PATH=$PATH:~/github/animated-GIF/bin

echo "do something to record on tty, when finshed enter ctrl-D or exit"
ttyrec spam
# do some stuff
ctrl-D

# to set ttygif to work on ubuntu had to follow these two steps

#	sudo apt-get install xdotool
export WINDOWID=$(xdotool getwindowfocus)

ttygif spam
#	111308 uadmin@six-rpi3b: ~/github/animated-GIF/ttyrec
#	     $ echo "is there time for this to work ?"
#	is there time for this to work ?
#	111309 uadmin@six-rpi3b: ~/github/animated-GIF/ttyrec
#	     $ exit
#	Creating Animated GIF ... this can take a while
#	Created: tty.gif in the current directory!

$ gifsicle -O3 -k 8 --lossy=80 -o tty-small.gif tty.gif
$ ls -alh tty*.gif
