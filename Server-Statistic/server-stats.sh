#!/bin/bash

# CPU Usage
echo -e "\nCPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Total CPU Usage: " 100 - $8 "% idle (" $2 + $4 + $6 "% used)"}'

# Memory Usage
echo -e "\nMemory Usage:"
free -h | awk '/Mem:/ {printf "Used: %s / Total: %s (%.f%% used)\n", $3, $2, $3/$2}'

# Disk Usage
echo -e "\nDisk Usage:"
df --block-size=G --total | awk '/total/ {printf "Used: %s / Total: %s (%s used)\n", $3, $2, $5}'

# Network Usage
echo -e "\nNetwork Usage:"
netstat -i

# List of Processes by CPU Usage
echo -e "\nProcesses by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu

# List of Processes by Memory Usage
echo -e "\nProcesses by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem
