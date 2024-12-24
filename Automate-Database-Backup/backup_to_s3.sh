#!/bin/bash

DB_NAME="dbname"
BACKUP_DIR="/tmp/mongo_backups"
TIMESTAMP=$(date "Y-%m-%d_%H-%M-%S")
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.tar.gz"
S3_BUCKET_NAME="backup-bucket"
AWS_REGION="ap-southeast-1"

mkdir -p $BACKUP_DIR

mongodump --db $DB_NAME --out $BACKUP_DIR/$DB_NAME-$TIMESTAMP

tar -czvf $BACKUP_FILE -C $BACKUP_DIR $DB_NAME-$TIMESTAMP

aws s3 cp $BACKUP_FILE s3://$S3_BUCKET_NAME/ --region $AWS_REGION

rm -rf $BACKUP_DIR/$DB_NAME-$TIMESTAMP
rm -rf $BACKUP_FILE

echo "Backup completed"
