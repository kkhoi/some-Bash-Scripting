#!/bin/bash

# var
SERVICE="nginx"           # service name

if systemctl is-active --quiet $SERVICE; then
    echo "$SERVICE is running"
else
    echo "$SERVICE is not running, attempting to restart..."
    systemctl restart $SERVICE

    if systemctl is-active --quiet $SERVICE; then
        echo "$SERVICE restarted successfully!" 
    else
        echo "Failed to restart $SERVICE!" 
    fi
fi
