#!/bin/bash

BOLD='\033[1m'
BB='\033[00m'

vol(){
    vol=$(pulsemixer --get-volume | awk '{print $1}')
	echo -e "+@fg=1;vol+@fg=0; $vol% "
}

dte() {
  dte=$(date +"%A, %B %d")
  echo -e "+@fg=1;date+@fg=0; $dte "
}

cpu() {
    read -r cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read -r cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    echo -e "+@fg=1;cpu+@fg=0; $cpu% "
}

tie() {
  tme=$(date +"%I:%M %p")
  echo -e "+@fg=1;time+@fg=0; $tme "
}

while :; do
    echo "$(vol) $(cpu) $(tie) $(dte)" 
	sleep 2
done
