#!/bin/bash

echo $(date) " - Starting Script"

echo $(date) "Install and Configure Required Dependencies"

yum -y install curl policycoreutils-python openssh-server 
 
yum -y install postfix
systemctl start postfix
systemctl enable postfix
systemctl status postfix

echo $(date) "Add GitLab Repository and Install Package"

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash

EXTERNAL_URL="http://gitlab.tecmint.com" yum install -y gitlab-ce

gitlab-ctl reconfigure

firewall-cmd --permanent --add-service=80/tcp
firewall-cmd --permanent --add-service=443/tcp
systemctl reload firewalld

echo $(date) " - Script Complete"

