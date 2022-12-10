Setting up a PXE server on the latest version of Ubuntu Server involves a few steps. Here's a general outline of the process:

1. Install and configure a DHCP server on your Ubuntu Server. This will allow your PXE server to automatically assign IP addresses to client machines when they boot up.

2. Install and configure a TFTP server on your Ubuntu Server. This will allow your PXE server to host files that are needed for the network boot process.

3. Download and install the PXE server software on your Ubuntu Server. This software provides the necessary tools for setting up and managing your PXE server.

4. Configure the PXE server to point to the location of the boot files on your TFTP server. This will allow the PXE server to serve the files to client machines when they boot up.

5. Test your PXE server by booting up a client machine and verifying that it can connect to the PXE server and download the necessary files.