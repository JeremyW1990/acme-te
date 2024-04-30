#!/bin/bash
echo "Auto Deployment from Cloud-AI" > index.html
nohup busybox httpd -f -p 80 &