#!/bin/bash

### Check root permission
#if [ "$EUID" -ne 0 ]; then
#    echo "Please run with sudo"
#    exit
#fi


# https://neousys.gitbook.io/nru-series/misc/jetson-related/jp60_prod_porting_memo/create-a-pure-jetpack-6.0-production-release-environment


# Download Tool chain

:<<BLOCK

cd $HOME
wget https://developer.nvidia.com/embedded/jetson-linux/bootlin-toolchain-gcc-93

# Try to make a different folder name to distinguish from JetPack 4.x requirement
sudo mkdir $HOME/l4t-gcc-93
cd $HOME/l4t-gcc-93

sudo mv ../bootlin-toolchain-gcc-93 bootlin-toolchain-gcc-93.tar.gz
sudo tar xf bootlin-toolchain-gcc-93.tar.gz

#/home/nvidia/l4t-gcc-93
export CROSS_COMPILE=$HOME/l4t-gcc-93/bin/aarch64-buildroot-linux-gnu-


#Download RelaL4ted Packages for Device Tree / Kernel Compile
#sudo apt install build-essential bc
sudo apt-get install -y graphviz dvipng python3-venv latexmk librsvg2-bin texlive-lang-chinese texlive-xetex python3-sphinx bison flex libgmp-dev libssl-dev libmpc-dev build-essential bc
#sudo apt-get install python3-sphinx bison flex
#sudo apt-get install libgmp-dev libssl-dev libmpc-dev -y

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

BLOCK

# Create a Pure JetPack 6.0 Production Release Environment
# Please Choose Ubuntu 20.04 or Ubuntu 22.04 for the Host Computer
# We have verified that Ubuntu 18.04 cannot complete the flashing process properly

# Remember to update the following environment variables
JP=/home/$USER/Desktop/JP60_NRU-160_170

### Ref: https://developer.nvidia.com/embedded/jetson-linux-r363
DriverPackageBSP=https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v3.0/release/jetson_linux_r36.3.0_aarch64.tbz2
SampleRootFileSystem=https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v3.0/release/tegra_linux_sample-root-filesystem_r36.3.0_aarch64.tbz2
DriverPackageBSPSources=https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v3.0/sources/public_sources.tbz2

sudo apt-get install binutils

mkdir -p $JP
cd $JP

wget -O driver.tar.gz $DriverPackageBSP
wget -O driverSource.tar.gz $DriverPackageBSPSources
wget -O rootfs.tar.gz $SampleRootFileSystem

### Decompress
cd $JP
tar xvf driver.tar.gz

mkdir -p $JP/Linux_for_Tegra/rootfs/
cd $JP/Linux_for_Tegra/rootfs/
sudo tar xvpf ../../rootfs.tar.gz

cd $JP
tar xvjf driverSource.tar.gz

# Prepare Kernel Sources
cd $JP/Linux_for_Tegra/source
mkdir -p $JP/Linux_for_Tegra/sources
tar xvf kernel_src.tbz2 -C $JP/Linux_for_Tegra/sources
tar xvf kernel_oot_modules_src.tbz2 -C $JP/Linux_for_Tegra/sources
tar xvf nvidia_kernel_display_driver_source.tbz2 -C $JP/Linux_for_Tegra/sources

# Preparing the flashing environment
cd $JP/Linux_for_Tegra
sudo apt-get install qemu-user-static -y
sudo ./apply_binaries.sh
sudo ./tools/l4t_flash_prerequisites.sh

# Create Defualt User Name (nvidia) and Password (nvidia)
sudo ./tools/l4t_create_default_user.sh -u nvidia -p nvidia -a

#..........................................................................................
#Additional Preparation for Kernel or Device Tree Compile
#Toolchain for JetPack 6.x (Bootlin Toolchain gcc 11.3)

#sudo -s
#mkdir -p /usr/src/l4t-gcc-113/
#cd /usr/src/l4t-gcc-113/

#wget -O bootlin-toolchain-gcc-113.tar.bz2 https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v3.0/toolchain/aarch64--glibc--stable-2022.08-1.tar.bz2 

#tar xvf bootlin-toolchain-gcc-113.tar.bz2
#..........................................................................................

# NRU-50+ flash command

#cd /home/$USER/Desktop/NRU160_170/Linux_for_Tegra
#sudo apt-get install sshpass abootimg nfs-kernel-server libxml2-utils -y
#sudo apt-get install nfs-kernel-server -y
#sudo apt-get install libxml2-utils -y

#sudo ./flash_nru50p_dtb+pinmux.sh

:<<BLOCK

​
# Download target board

  * Please download the appropriate target board corresponding to your specific board.
  	
	neousys_nru
	https://partner.neousys-tech.com/sharing/KEQTDhFwF

  * Once you have downloaded the target board, move it to the following directory:

    	/home/$USER/Desktop/JP511/Linux_for_Tegra/

  * Extract the file and name it following this naming convention:
	${DTB_NAME}_${timestamp}.tar.gz.

cd /home/$USER/Desktop/JP511/Linux_for_Tegra/
sudo tar zxvf nru160_2024-04-03_1511.tar.gz

# Download Image on the host
  * Please download the corresponding image based on the board you are using.
  * Once you've downloaded the image, please put it in the following directory:
	/home/$USER/Desktop/JP511/Linux_for_Tegra/tools/backup_restore_nvme/
Then, extract the image.

cd /home/$USER/Desktop/JP511/Linux_for_Tegra/tools/backup_restore_nvme/
sudo tar zxvf Image

Set Orin recovery mode 
*** Different models may have different methods to enter Recovery mode ***
  * Connect the USB cable between Host Machine and Orin Machine
  * To check if Orin is in recovery mode, type "lsusb" on the Host Machine and look for an "NVIDIA Corp." USB device.

	Bus 003 Device 004: ID 0955:7e19 NVIDIA Corp. APX


# Restore NVMe to default
  * On the host computer, navigate to the following directory:

    /home/$USER/Desktop/JP511/Linux_for_Tegra/

  * On the host computer, execute the following script with sudo:

        sudo ./flash_restore_image.sh
        
    if you encounter some error messages as below , please do "sudo apt-get install ****"
        /home/poc-700/Desktop/JP511/Linux_for_Tegra/tools/kernel_flash/l4t_initrd_flash_internal.sh --no-flash --initrd --showlogs nru50+ mmcblk0p1 ERROR sshpass not found! To install - 
	please run:  "sudo apt-get install sshpass" "sudo apt-get install abootimg"



# Reset Orin machine

  * After executing flash_restore_image.sh, you will see the message as shown in the image below.
  
 * nvrestore_partitions.sh Successful restore of partitions on target board. Operation finishes. you can manually reset the device *

Successful restore
Please reset the device.

:<<BLOCK

ERROR xxxxx not found! To install - please run: 

sudo apt-get install nfs-kernel-server -y
sudo apt-get install libxml2-utils -y
BLOCK
