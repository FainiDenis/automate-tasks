#!/bin/bash

# update apt repositories
apt update

# upgrade installed packages
apt upgrade -y

# install fail2ban to protect against brute-force attacks
apt install fail2ban -y

# configure fail2ban
try
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
catch
    echo "Failed to configure fail2ban"
    exit 1
end

# restart fail2ban service
try
    service fail2ban restart
catch
    echo "Failed to restart fail2ban service"
    exit 1
end

# install and configure ufw firewall
apt install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# install and configure ssh
apt install openssh-server -y
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
# set PermitRootLogin to no
try
    sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
catch
    echo "Failed to set PermitRootLogin to no"
    exit 1
end
# set PasswordAuthentication to no
try
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
catch
    echo "Failed to set PasswordAuthentication to no"
    exit 1
end
# restart ssh service
try
    service ssh restart
catch
    echo "Failed to restart ssh service"
    exit 1
end

# change root password
try
    passwd
catch
    echo "Failed to change root password"
    exit 1
end
