#!/bin/bash

# var
LOG_DIR="/var/log/myapp"    # folder log
DAYS_OLD=7                  # day

# gzip file log +DAYS_OLD
echo "Compressing log files older than $DAYS_OLD days in $LOG_DIR..."
find $LOG_DIR -type f -name "*.log" -mtime +$DAYS_OLD -exec gzip {} \;

if [ $? -eq 0 ]; then
    echo "Log compression completed successfully!"
else
    echo "Log compression failed!"
    exit 1
fi

# delete file log gzip +30 day
echo "Removing compressed log files older than 30 days..."
find $LOG_DIR -type f -name "*.gz" -mtime +30 -exec rm {} \;

# Kiểm tra nếu quá trình xóa thành công
if [ $? -eq 0 ]; then
    echo "Old compressed logs removed successfully!"
    # Gửi email thông báo hoàn thành dọn dẹp
    echo "Log rotation and cleanup completed successfully!"
else
    echo "Log removal failed!"
    exit 1
fi
