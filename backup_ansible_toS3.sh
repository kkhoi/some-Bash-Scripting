#!/bin/bash

# var
BACKUP_SRC="/home/ubuntu"  # folder backup
S3_BUCKET="s3://khoi/backups/"  # S3 Bucket store backup
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")  # timestamp
BACKUP_FILE="backup_$TIMESTAMP.zip"     # filename

# Zip folder backup
cd $BACKUP_SRC
zip -r $BACKUP_FILE test #change folder should be backup 

if [ $? -eq 0 ]; then
    echo "Backup completed successfully!"
else
    echo "Backup failed!"
    exit 1
fi

# Upload file backup to S3
echo "Uploading $BACKUP_FILE to S3..."
aws s3 cp $BACKUP_SRC/$BACKUP_FILE $S3_BUCKET

if [ $? -eq 0 ]; then
    echo "Upload to S3 completed successfully!"
    # Gửi email thông báo thành công
    echo "Backup and upload to S3 completed successfully at $TIMESTAMP"
else
    echo "Upload to S3 failed!"
    exit 1
fi

# delete file backup
echo "Cleaning up old backup files..."
find $BACKUP_SRC -type f -name $BACKUP_FILE -exec rm {} \;

echo "Backup process completed."
