#!/bin/bash

DB_NAME="dbname"
RESTORE_DIR="/tmp/mongo_restore"
S3_BUCKET_NAME="backup-bucket"
AWS_REGION="ap-southeast-1"


LATEST_BACKUP=$(aws s3 ls s3://$S3_BUCKET_NAME/ --region $AWS_REGION | sort | tail -n 1 | awk '{print $4}')

mkdir -p $RESTORE_DIR
aws s3 cp s3://$BUCKET_NAME/$LATEST_BACKUP $RESTORE_DIR --region $AWS_REGION

tar -xzvf $RESTORE_DIR/$LATEST_BACKUP -C $RESTORE_DIR
mongostore --db $DB_NAME $RESTORE_DIR/$DB_NAME

rm -rf $RESTORE_DIR

echo "Database restored"
