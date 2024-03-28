#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<html><body><h1>Hello from ACME Homepage</h1><p>Environment: ${environment}</p></body></html>" > /var/www/html/index.html
