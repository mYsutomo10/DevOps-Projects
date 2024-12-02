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

# Load Average
echo -e "\nLoad Average (1/5/15 min):"
uptime | awk -F'load average:' '{print $2}'

# OS Version
echo -e "\nOS Version:"
cat /etc/os-release | grep -E "PRETTY_NAME"

# Uptime
echo -e "\nSystem Uptime:"
uptime -p

# Logged-In Users
echo -e "\nLogged-In Users:"
who

# Failed Login Attempts
echo -e "\nFailed Login Attempts:"
grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l || echo "Log file not accessible or not available."
