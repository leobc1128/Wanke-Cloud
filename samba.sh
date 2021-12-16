# Raspbian Jessie SAMBA service by CYRO4S
# This script will share entire external HDD for file sharing
# (C)2017 CYROFORCE.NET
#!/bin/bash

pass="$1"

echo "Creating share directory ----------"
sudo mkdir /www/samba
sudo chmod -R 777 /www/samba

echo "Setting auto-mount for HDD --------"
sudo cat >> /etc/fstab << EOF
/dev/sda1       /media/pi/hdd   ext4    defaults          0       0
EOF

echo "Updating source -------------------"
sudo apt-get update

echo "Installing SAMBA ------------------"
sudo apt-get install samba samba-common-bin

echo "Configuring SAMBA -----------------"
sudo cat >> /etc/samba/smb.conf << EOF
[share]
path = /www/samba
valid users = root arm
browseable = yes
public = yes
writable = yes
EOF
sudo /etc/init.d/samba restart

echo "Adding SAMBA user -----------------"
sudo smbpasswd –a arm
$pass
$pass

echo "ALL DONE."
