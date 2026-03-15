#!/bin/bash

LIMIT=$1

USED=$(df -h / | grep / | awk '{print $5}' | tr -d '%')

if [ "$USED" -gt "$LIMIT" ]; then
    echo "Disk usage is ${USED}% - WARNING" >> /var/log/disk.log
fi
