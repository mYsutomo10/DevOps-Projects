# <ins>Remote Linux Server Setup on AWS with SSH Access</ins>


## <ins>Getting Started</ins>

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
