# <u>Ansible Server Configuration Project</u>
This project demonstrates the basics of configuration management using Ansible. It includes a playbook (setup.yml) and associated roles to configure a Linux server hosted on AWS. The configuration includes setting up basic utilities, a web server (nginx), deploying a static website, and configuring SSH access.

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
- Deploy a static website from a GitHub Repo.
### SSH Configuration
- Add public SSH key to the server
