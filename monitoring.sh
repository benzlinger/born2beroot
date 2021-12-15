#!/bin/bash
arch=$(uname -a)
cpu=$(nproc)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
memu=$(free -m | grep Mem | awk '{printf "%s/%sMB (%.2f%%)", $3,$2,$3*100/$2}')
disku=$(df -Bm --total | grep total | awk '{printf"%d", $3}')
diska=$(df -Bg --total | grep total | awk '{printf"/%dGb (%d%%)", $2, $5}')
cpul=$(top -bn1 | grep load | awk '{printf"%.1f", $(NF-2)}')
lboot=$(who -b | awk '{print $3" " $4}')
lvm=$(lsblk | grep lvm | wc -l)
lvmif=$(if [ $lvm -gt 0 ]; then echo yes; else echo no; fi)
tcp=$(netstat -an | grep ESTABLISHED | wc -l)
ulog=$(who | wc -l)
host=$(hostname -I)
mac=$(ip link show | grep ether | awk '{print $2}')
sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
wall "
#Architecture: $arch
#CPU physical: $cpu
#vCPU: $vcpu
#Memory Usage: $memu
#Disk Usage: $disku$diska
#CPU load: $cpul%
#Last boot: $lboot
#LVM use: $lvmif
#Connections TCP: $tcp ESTABLISHED
#User log: $ulog
#Network: IP $host ($mac)
#Sudo: $sudo cmd
"
