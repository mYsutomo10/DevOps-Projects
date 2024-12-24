# <u>MongoDB Backups with Amazon S3</u>
This project sets up a scheduled workflow to back up a MongoDB database every 24 hours and upload the backup to Amazon S3 for secure storage. Additionally, a script is included to restore the database from the latest backup stored in S3.

## <u>Prerequisites</u>
- AWS EC2 instance
- MongoDB
- Amazon S3 bucket

## <u>Steps</u>
### 1. Launch an AWS EC2 instance
- if you doesn't have a keypair yet
  ```
  aws ec2 create-key-pair --key-name <key-name> --query 'KeyMaterial' --output text > <key-name>.pem
  ```
- create an instance from cloud shell
  ```
  aws ec2 run-instances \
    --image-id <ami-06650ca7ed78ff6fa> \
    --instance-type t2.micro \
    --key-name <key-name> \
    --security-group-ids <security-group-id> \
    --min-count 1 --max-count 1 \
    --output json
  ```
### 2. Create an S3 bucket
```
aws s3api create-bucket --bucket backup-bucket
```
### 3. Install MongoDB
- SSH to the EC2 instance
- install **gnupg** and **curl**
  ```
  sudo apt-get install gnupg curl
  ```
- import MongoDB public GPG key
  ```
  curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
  ```
- create the list file
  ```
  echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
  ```
- reload the package database
  ```
  sudo apt-get update
  ```
- install MongoDB community server
  ```
  sudo apt-get install -y mongodb-org
  ```
- start MongoDB
  ```
  sudo service mongod start
  ```
- verify the status
  ```
  sudo service mongod status
  ```
### 4. Schedule the backup using cron
- open crontab editor
  ```
  crontab -e
  ```
- add this line to run the script foor every 24 hours
  ```
  0 0 * * * /backup_to_s3.sh
  ```
- save and exit
