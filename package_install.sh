#!/bin/bash
apt update && \
apt install apache2 -y && \
echo "<h1>Deployed via Terraform</h1>" | tee /var/www/html/index.html && \
echo $(hostname -f) | tee /var/www/html/index.html && \
systemctl start apache2
