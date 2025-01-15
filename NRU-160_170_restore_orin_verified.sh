#!/bin/bash

### Check root permission
#if [ "$EUID" -ne 0 ]; then
#    echo "Please run with sudo"
#    exit
#fi


# https://neousys.gitbook.io/nru-series/nru-220s/software-related/building-pinmux-+-device-tree-+-kernel-for-nru-220s
# https://neousys.gitbook.io/nru-series/nru50/software-related/backup-and-restore-pre-built-nvme
# https://neousys.gitbook.io/nru-series/pcie-nx150/software-related/create-a-pure-jetpack-5.1.1-environment


# Download Tool chain
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


# Create a Pure JetPack 5.1.1 Environment
# Remember to update the following environment variables
JP=/home/$USER/Desktop/NRU160_170

### Ref: https://developer.nvidia.com/embedded/jetson-linux-r3531
DriverPackageBSP=https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v3.1/release/jetson_linux_r35.3.1_aarch64.tbz2/
DriverPackageBSPSources=https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v3.1/sources/public_sources.tbz2/
SampleRootFileSystem=https://developer.nvidia.com/downloads/embedded/l4t/r35_release_v3.1/release/tegra_linux_sample-root-filesystem_r35.3.1_aarch64.tbz2/

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

cd $JP/Linux_for_Tegra/source/public
mkdir -p $JP/Linux_for_Tegra/sources
tar xvf kernel_src.tbz2 -C $JP/Linux_for_Tegra/sources

# Preparing the flashing environment
cd $JP/Linux_for_Tegra
sudo apt-get install qemu-user-static -y
sudo ./apply_binaries.sh
sudo ./tools/l4t_flash_prerequisites.sh

# Create Defualt User Name
sudo ./tools/l4t_create_default_user.sh -u nvidia -p nvidia -a

# NRU-160 flash command

#cd /home/$USER/Desktop/NRU160_170/Linux_for_Tegra
sudo apt-get install sshpass abootimg nfs-kernel-server libxml2-utils -y
sudo apt-get install nfs-kernel-server -y
sudo apt-get install libxml2-utils -y
#sudo ./flash_nru160_dtb+pinmux.sh

:<<BLOCK

Backup and Restore Pre-built NVMe
Create a Pure JetPack5.1.1 Environment
Please reference this https://neousys.gitbook.io/nru-series/pcie-nx150/software-related/create-a-pure-jetpack-5.1.1-environment
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
