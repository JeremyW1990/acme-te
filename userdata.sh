#!/bin/bash
# Install a basic web server and write the homepage
yum -y update
yum -y install httpd
systemctl start httpd
systemctl enable httpd
echo "Auto Deployment from Cloud-AI" > /var/www/html/index.html