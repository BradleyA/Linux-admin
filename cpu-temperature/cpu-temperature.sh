#!/bin/bash
#	cpu-temperature.sh	1.0	2017-12-20_22:07:09_CST uadmin rpi3b-two.cptx86.com
#	added description comment and added mark
#
#       set -x
#       set -v
#
#	print out current temperature
#
echo "Hostname =	" `hostname`

CPUTEMP=$(/usr/bin/vcgencmd measure_temp | \
sed -e 's/?C$//' | \
sed -e 's/temp=//')

CPUTEMP=${CPUTEMP//\'C/}

echo "Celsius =	" $CPUTEMP
echo $CPUTEMP | awk '{print "Fahrenheit =	" 1.8 * $1 +32}'
