# <u>Ansible Server Configuration Project</u>
This project demonstrates the basics of configuration management using Ansible. It includes a playbook (setup.yml) and associated roles to configure a Linux server hosted on AWS. It focuses on deploying applications from a GitHub repository using Docker.

## <u>Requirements</u>
- Linux Server
- Ansible
- SSH key

## <u>Prerequisites</u>
1. Ansible Installation on local machine:
   ```
   sudo apt update && sudo apt install ansible -y
   ```
2. SSH Access is configured

## <u>Features</u>
### Base Setup
- Update and upgraddes the servve packages.
- Install basic utilities.
- Install and configures fail2ban for basic security.
### Web Server Setup
- Install and configures nginx.
- Starts and enables the enginex service.
### App Deployment
- Clones a repository from GitHub.
- Builds and runs the application as a Docker container.
### SSH Configuration
- Add public SSH key to the server

## <u>Usage</u>
### 1. Update inventory file
Edit `inventory.ini` with your server IP address, SSH username and private key path.
### 2. Run the playbook
To run all roles:
```
ansible-playbook setup.yml
```
To run a spesific role (e.g., ssh):
```
ansible-playbook setup.yml --tags "ssh"
```
