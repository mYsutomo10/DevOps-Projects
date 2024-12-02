## <u>Remote Linux Server Setup on AWS with SSH Access</u>
This project demonstrates how to set up a remote Linux server on Amazon Web Services (AWS) and configure secure SSH access for remote management. The guide covers the entire process, from launching an EC2 instance to establishing a secure connection using SSH.

## <u>Built With</u>
- Amazon Web Services (AWS)
- Linux (RHEL)

## <u>Getting Started</u>
### 1. Launch an EC2 Instance
- Log in to your [AWS Management Console](https://aws.amazon.com/console/).
- Navigate to **EC2** and click **Launch instance**.
- Scroll down to **Key pair (login)** and create a new key pair for connect to the instance.
- In **Network settings** and make sure the **Allow SSH traffic** is checked.
- Leave the rest configuration by default and click **Launch instance**.

### 2. Generate SSH Key Pairs
- On your local machine, run this command to generate the key:
  ```
  ssh-keygen -t ecdsa -b 256 -f ~/.ssh/<private key file1> -C "<publc key file1>"
  ssh-keygen -t ecdsa -b 256 -f ~/.ssh/<private key file2> -C "<publc key file2>"
  ```
  In this case, I generated 2 ssh key pairs and used the ECCNISTP256 algorithm, I chose that algorithm because of its relatively short key length which makes it faster than others, but still provides enough security for SSH needs. If you need to protect sensitive data, it is recommended to use ECCNISTP521 instead.
- To make sure your key is not publicly viewable by running:
  ```
  chmod 400 <private key file>
  ```

### 3. Add SSH Keys to Server
- Connect to the instance using the key that created when configuring the instance.
  ```
  ssh -i "<your key>" <username>@<instance public DNS>
  ```
- When you have successfully logged in, then add the content of the public keys to *authorized_keys* file.
  ```
  cat >> ~/.ssh/authorized_keys <<EOF
  <contents of key1.pub>
  <contents of key2.pub>
  EOF
  ```
- Verify the SSH Access
  ```
  ssh -i ~/.ssh/<private key1> <username>@<public-server-ip>
  ssh -i ~/.ssh/<private key2> <username>@<public-server-ip>
  ```

### 4. Configure aliases for the server
- On your local machine, edit the SSH config file
  ```
  Host <host name1>
    HostName <public-server-ip>
    User <username>
    IdentityFile ~/.ssh/<private key1>

  Host <host name2>
    HostName <public-server-ip>
    User <username>
    IdentityFile <private key2>
  ```
- Save and exit
  this configuration will allow you to connect to your server using the following command:
  ```
  ssh <alias>
  ```
- Test the aliases
  ```
  ssh <host name1>
  ssh <host name2>
  ```

### 5. Install and Configure fail2ban
Fail2Ban is a security tool designed to protect servers from unauthorized access and brute-force attacks. It works by monitoring log files for specific patterns that indicate malicious behavior, such as repeated failed login attempts, and then taking automated actions, such as banning the offending IP address.
- On your server, install the fail2ban
  ```
  sudo yum install fail2ban -y
  ```
- Create a local jail file
  ```
  sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
  ```
- Enable SSH protection by editing the */etc/fail2ban/jail.local* file
  ```
  [sshd]
  enabled = true
  ```
- Enable the service and start the fail2ban
  ```
  sudo systemctl enable fail2ban
  sudo systemctl start fail2ban
  ```
- Verify the jail is enabled by run this command:
  ```
  sudo fail2ban-client status sshd
  ```

### Project URL
https://roadmap.sh/projects/ssh-remote-server-setup
