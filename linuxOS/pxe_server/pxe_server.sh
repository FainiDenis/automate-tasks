#!/bin/bash

# MAKE CHANGE TO THIS FOR YOUR NEED
domain_name = "fainilab.xyz"
domain_name_servers="8.8.8.8, 8.8.4.4"
server_ip = "10.1.10.100"
subnet_ip = "10.1.10.0"
subnet_ip_range = "10.1.10.100 10.1.10.200"


# Get current IP address
current_ip=$(ifconfig eth0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1)

# Set new IP address
new_ip=$server_ip

# Update IP address
ifconfig eth0 $new_ip

# Verify that the IP address was updated
updated_ip=$(ifconfig eth0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1)
if [ "$updated_ip" == "$new_ip" ]; then
  echo "IP address updated successfully"
else
  echo "Error updating IP address"
fi


# Function to handle errors
function handle_error() {
  # Print error message
  echo "Error: $1"

  # Exit with non-zero exit code
  exit 1
}

# Install and configure DHCP server
try {
  # Install DHCP server
  apt-get update
  apt-get install isc-dhcp-server -y

  # Configure DHCP server
  mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.bak
  cat <<EOF > /etc/dhcp/dhcpd.conf
  # DHCP configuration file

  # Global parameters

  option domain-name "$domain_name";
  option domain-name-servers $domain_name_servers;

  # PXE-specific options

  option space PXE;
  option PXE.mtftp-ip code 1 = ip-address;
  option PXE.mtftp-cport code 2 = unsigned integer 16;
  option PXE.mtftp-sport code 3 = unsigned integer 16;
  option PXE.mtftp-tmout code 4 = unsigned integer 8;
  option PXE.mtftp-delay code 5 = unsigned integer 8;

  # DHCP scope

  subnet $subnet_ip netmask 255.255.255.0 {
    range $subnet_ip_range;
    filename "pxelinux.0";
    next-server $newip;
  }
  EOF

  # Restart DHCP server
  service isc-dhcp-server restart

  # Catch any errors
  catch handle_error
}

# Install and configure TFTP server
try {
  # Install TFTP server
  apt-get install tftpd-hpa -y

  # Configure TFTP server
  sed -i 's/TFTP_DIRECTORY=\/srv\/tftp/TFTP_DIRECTORY=\/var\/lib\/tftpboot/g' /etc/default/tftpd-hpa
  service tftpd-hpa restart

  # Catch any errors
  catch handle_error
}

# Install PXE server software
try {
  # Download PXE server software
  wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/pxelinux.0
  wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/amd64/pxelinux.cfg/default

  # Catch any errors
  catch handle_error
}
