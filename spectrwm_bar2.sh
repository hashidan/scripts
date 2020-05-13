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

#xkb() {
#
#}
#
cpu() {
    read -r cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read -r cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    echo -e "+@fg=1;cpu+@fg=0; $cpu% "
}

mem() {
    #mem=$(free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }')
    mem=$(free | awk '/Mem/ {printf "%dM\n", $3 / 1024.0, $2 / 1024.0 }')
    echo -e "+@fg=1;mem+@fg=0; $mem "
}

tie() {
  tme=$(date +"%H:%M")
  echo -e "+@fg=1;time+@fg=0; $tme "
}

while :; do
    echo "$(vol) $(cpu) $(mem) $(tie) $(dte)"
    sleep 2
done
