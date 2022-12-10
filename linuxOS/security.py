import subprocess

USERNAME = "fainidenis"
VOLUME_NAME = ""

try:
    # Update the package index
    subprocess.run(["sudo", "apt", "update"])

    # Upgrade installed packages
    subprocess.run(["sudo", "apt", "upgrade"])

    # Install the firewall
    subprocess.run(["sudo", "apt", "install", "ufw"])

    # Enable the firewall
    subprocess.run(["sudo", "ufw", "enable"])

    # Set the password for the root user
    subprocess.run(["sudo", "passwd", "root"])

    # Create the new user
    subprocess.run(["sudo", "useradd", "-m", "-s", "/bin/bash", USERNAME])

    # Set the password for the new user
    subprocess.run(["sudo", "passwd", USERNAME])

    # Add the new user to the sudo group
    subprocess.run(["sudo", "usermod", "-aG", "sudo", USERNAME])

    # Edit the SSH configuration file
    subprocess.run(["sudo", "nano", "/etc/ssh/sshd_config"])

    # Restart the SSH service to apply the changes
    subprocess.run(["sudo", "systemctl", "restart", "ssh"])
    
     # Install the encryption tools
    subprocess.run(["sudo", "apt", "install", "cryptsetup"])

    # Create an encrypted volume
    subprocess.run(["sudo", "cryptsetup", "luksFormat", "/dev/sda1"])

    # Open the encrypted volume
    subprocess.run(["sudo", "cryptsetup", "luksOpen", "/dev/sda1", "<volume-name>"])

    # Format the volume
    subprocess.run(["sudo", "mkfs.ext4", "/dev/mapper/<volume-name>"])

    # Mount the volume
    subprocess.run(["sudo", "mount", "/dev/mapper/<volume-name>", "/mnt"])


except Exception as e:
    # Print an error message
    print("An error occurred:", e)
