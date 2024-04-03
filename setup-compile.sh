#!/bin/bash

# Enable extended globbing
shopt -s extglob

# Error counter
error=0

echo "Installing Xorg, core dependencies"
yum install -y "xorg-x11-apps"
yum install -y "libX11-devel"
yum install -y "xorg-x11-server-Xephyr"
yum install -y "xorg-x11-server-Xorg"
yum install -y "xorg-x11-xauth"
yum install -y "xorg-x11-server-Xvfb"

echo "Creating DOOM dir"
mkdir "/root/sos-project/DOOM"

echo "Creating temp dir"
mkdir "/root/sos-project/DOOM/temp"

echo "Downloading DOOM zip from GitHub"
curl -o "/root/sos-project/DOOM/temp/master.zip" "https://github.com/kubikulek231/SOS-DOOM/archive/refs/heads/master.zip" -O -J -L

echo "Installing unzip"
yum install unzip -y

echo "Unziping the package"
unzip "/root/sos-project/DOOM/temp/master.zip" -d "/root/sos-project/DOOM/temp/"

echo "Moving unziped files to DOOM directory"
mv "/root/sos-project/DOOM/temp/SOS-DOOM-master/"!(dependencies|scripts) "/root/sos-project/DOOM/"

echo "Downloading the blackbox mw"
curl -o "/root/sos-project/DOOM/temp/blackbox.zip" "https://downloads.sourceforge.net/project/blackboxwm/blackboxwm/Blackbox%200.70.1_SL7/blackbox-0.70.1_SL7.0.tar.gz?ts=gAAAAABmDHbCv0mBN4TCILi1nnIMZFUC3zDzY4nmwJ4ADB3COSmvwCdaOplDVJixNpPSdHJoUvfqggf6f44GOv0tLAUI7LM3fQ%3D%3D&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fblackboxwm%2Ffiles%2Flatest%2Fdownload" -O -J -L 

echo "Unzipping blackbox"
unzip "/root/sos-project/DOOM/temp/blackbox.zip" -d "/root/sos-project/DOOM/temp/"

echo "Deleting temp directory"
#rm -rf "/root/sos-project/DOOM/temp/"

ldpath="/root/sos-project/DOOM/"

echo "Installing gcc"
sudo yum install gcc

echo "Compiling"
make -C $ldpath"linuxdoom-1.10"

echo "Downloading the shareware wad"
curl -o $ldpath"linuxdoom-1.10/""linux/doom1.wad" "https://distro.ibiblio.org/slitaz/sources/packages/d/doom1.wad" -O -J -L

echo "Setup complete!"
