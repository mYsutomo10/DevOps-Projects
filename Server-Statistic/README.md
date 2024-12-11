# <u>Server Performance Stats</u>
A simple bash script to analyze and monitor key server performance metrics, providing insights into resource usage and helping identify potential issues.

## <u>Features</u>
- CPU Usage
- Memory Usage
- Disk Usage
- Network Usage
- List of Processes by CPU & Memory Usage
- Load Average
- System Uptime
- Logged-In Users
- Failed Login Attempts

## <u>Getting Started</u>
### 1. Creating the Scripts
Create a new file with shell extension
```
nano server-stats.sh
```
### CPU Usage
This metric will display the total CPU usage, including idle and active CPU percentages. It calculates the CPU usage by subtracting the idle percentage from 100%.
```
echo -e "\nCPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Total CPU Usage: " 100 - $8 "% idle (" $2 + $4 + $6 "% used)"}'
```
### Memory Usage
Shows the used and total memory and also calculates the percentage of memory usage.
```
echo -e "\nMemory Usage:"
free -h | awk '/Mem:/ {printf "Used: %s / Total: %s (%.f%% used)\n", $3, $2, $3/$2}'
```
### Network Usage
Displays network statistics for each network interface, such as packets received and sent, and more.
```
echo -e "\nNetwork Usage:"
netstat -i
```
### List of Processes by CPU & Memory Usage
```
echo -e "\nProcesses by CPU Usage:"
ps -eo pid,comm,%cpu,%mem
```
### Load Average
This metric will display the systems load average over the last 1, 5, and 15 minutes, which indicates the level of system activity and potential overload.
```
echo -e "\nLoad Average (1/5/15 min):"
uptime | awk -F'load average:' '{print $2}'
```
### Uptime
Indicating how long the system has been running since the last reboot.
```
echo -e "\nSystem Uptime:"
uptime -p
```
### Logged-In Users
Lists the users who are currently logged in to the system, showing their usernames and more.
```
echo -e "\nLogged-In Users:"
who
```
### Failed Login Attempts
Shows the number of failed login attempts.
```
echo -e "\nFailed Login Attempts:"
grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l || echo "Log file not accessible or not available."
```
### Final Look
```
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

# List of Processes by CPU & Memory Usage
echo -e "\nProcesses by CPU Usage:"
ps -eo pid,comm,%cpu,%mem

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
```
### Save and exit
### 2. Using the Script
Ensure the bash is installed.
```
bash --version
```
Make the script executable by running:
```
chmod +x server-stats.sh
```
Run the script.
```
./server-stats.sh
```
### Using Alias
Create an alias to run the script from any directory with a short name by adding this command in the **.bashrc** file:
```
alias server-stats='bash ~/scripts/server-stats.sh'
```
Apply the changes.
```
source ~/.bashrc
```
