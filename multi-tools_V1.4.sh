#!/bin/bash

# Define colors for the menu
green='\033[38;5;82m'
red='\033[1;31m'
blue='\033[1;34m'
yellow='\033[1;93m'
BR_yellow='\033[38;5;226m'
BR_gray='\033[38;5;250m'
BR_red='\033[38;5;196m'
BL_purple='\033[38;5;104m'
BR_blue='\033[38;5;87m'
LT_blue='\033[38;5;85m'
BL_blue='\033[38;5;84m' # Bright
BG_BLUE="\033[44;37m" # Blue background, white text
BG_RED="\033[41;37m"  # Red background, white text
nc='\033[0m' # No color
BOLD="\033[1m"        # Bold text
BLINK="\033[5m"       # Blinking effect
RESET="\033[0m"       # Reset to default style



# Define functions for installation and uninstallation
One-click_install() {
    echo -e "${green}Installing acpid...${nc}"
    sudo apt update
    sudo apt install -y acpid
    #/etc/acpi/events/power
    sudo echo -e "event=button/power\naction=sudo shutdown now" > /etc/acpi/events/power
    sudo service acpid restart
    echo -e "${green}acpid installation completed.\n${nc}"
    
    echo -e "${green}Installing can-utils...${nc}"
    sudo apt install can-utils -y
    echo -e "${green}can-utils installation completed.\n${nc}"
    
    echo -e "${green}Installing dbus-x11...${nc}"
    sudo apt install dbus-x11 -y
    echo -e "${green}dbus-x11 completed.\n${nc}"

    echo -e "${green}Installing ethtool...${nc}"
    sudo apt install ethtool -y
    echo -e "${green}ethtool completed.\n${nc}"

    echo -e "${green}Installing gparted...${nc}"
    sudo apt install gparted -y
    echo -e "${green}gparted installation completed.\n${nc}"
    
    echo -e "${green}Installing hardinfo...${nc}"
    sudo apt install hardinfo -y
    echo -e "${green}hardinfo installation completed.\n${nc}"
    
    echo -e "${green}Installing inxi...${nc}"
    sudo apt install inxi -y
    echo -e "${green}inxi installation completed.\n${nc}"
      
    echo -e "${green}Installing jtop...${nc}"
    sudo apt update
    sudo apt install python3-pip python2-dev build-essential -y
    sudo apt autoremove -y
    sudo pip install --upgrade pip
    sudo -H pip3 install -U jetson-stats
    sudo systemctl restart jetson_stats.service
    echo -e "${green}jtop installation completed.\n${nc}"
       
    echo -e "${green}Installing kdiskmark...${nc}"
    sudo add-apt-repository ppa:jonmagon/kdiskmark -y
    sudo apt update
    sudo apt install kdiskmark -y
    echo -e "${green}kdiskmark installation completed.\n${nc}"
    
    echo -e "${green}Installing minicom...${nc}"
    sudo apt install minicom -y
    echo -e "${green}minicom installation completed.\n${nc}"
    
    echo -e "${green}Installing net-tools"
    sudo apt install net-tools -y
    echo -e "${green}net-tools installation completed.\n${nc}"

    
    echo -e "${green}Installing smplayer"
    sudo apt install smplayer -y
    echo -e "${green}smplayer installation completed.\n${nc}"
        
    echo -e "${green}Installing pps"
    sudo apt install net-tools -y
    echo -e "${green}pps installation completed.\n${nc}"       
}

One-click_uninstall() {
    echo -e "${red}Uninstalling jtop...${nc}"
    sudo -H pip3 uninstall -y jetson-stats
    sudo apt remove --purge python3-pip python2-dev build-essential -y
    sudo apt autoremove -y
    echo -e "${red}jtop uninstalled.\n${nc}"
    
    echo -e "${red}Uninstalling kdiskmark...${nc}"
    sudo apt remove --purge kdiskmark -y
    sudo apt autoremove -y
    echo -e "${red}kdiskmark uninstalled.\n${nc}"
    
    echo -e "${red}Uninstalling can-utils...${nc}"
    sudo apt remove can-utils -y
    echo -e "${red}can-utils uninstalled.\n${nc}"   
    
    echo -e "${red}Uninstalling gparted${nc}"
    sudo apt remove gparted -y
    echo -e "${red}gparted uninstalled.\n${nc}"   
}

install_gpu_burn_jetson() {
    echo -e "${green}Installing gpu-burn...${nc}"
    sudo apt update
    git clone https://github.com/anseeto/jetson-gpu-burn.git
    cd jetson-gpu-burn
    make
    echo -e "${green}gpu-burn installation completed.${nc}"
}

uninstall_gpu_burn_jetson() {
    echo -e "${red}Uninstalling gpu-burn...${nc}"
    rm -rf ~/Desktop/jetson-gpu-burn
    echo -e "${red}gpu-burn uninstalled.${nc}"
}

install_gpu_burn_x86() {
    echo -e "${green}Installing gpu-burn...${nc}"
    sudo apt update
    sudo apt install -y git build-essential nvidia-cuda-toolkit
    git clone https://github.com/wilicc/gpu-burn.git
    sudo chmod 777 gpu-burn
    cd gpu-burn
    sudo make
#    sudo apt install snapd -y
#    sudo snap install gpu-burn -y
#    make
    echo -e "${green}gpu-burn installation completed.${nc}"
}

uninstall_gpu_burn_x86() {
    echo -e "${red}Uninstalling gpu-burn...${nc}"
    sudo rm -rf gpu-burn
    echo -e "${red}gpu-burn uninstalled.${nc}"
}

install_Chrome() {
    echo -e "${green}Installing Chrome...${nc}"
    sudo apt install chromium-browser-l10n -y
    echo -e "${green}Chrome installation completed.${nc}"
}

uninstall_Chrome() {
    echo -e "${red}Uninstalling Chrome...${nc}"
    sudo apt remove chromium-browser-l10n -y
    echo -e "${red}Chrome uninstalled.${nc}"
}

install_pycharm-community() {
    echo -e "${green}Installing pycharm-community...${nc}"
    sudo apt update
    sudo snap install pycharm-community --classic
    echo -e "${green}pycharm-community installation completed.${nc}"
}

uninstall_pycharm-community() {
    echo -e "${red}Uninstalling pycharm-community...${nc}"
    sudo snap remove pycharm-community --classic
    echo -e "${red}pycharm-community uninstalled.${nc}"
}

lock_kernel() {
    echo -e "${green}Locking kernel version...${nc}"
    
# Print blinking and green text
    echo -e "${green}${BOLD}${BLINK}Please enter your root password${RESET}"

# Wait for the user to input their password
    read -s -p "Password: " password
    echo
    echo -e "The password you entered is: ${red}${BOLD}${BLINK}${RESET}"
    echo $password | sudo -S sudo apt-mark hold linux-image-$(uname -r)
    echo $password | sudo -S sudo apt-mark hold linux-headers-$(uname -r)
    echo -e "${green}Kernel version $(uname -r) locked.${nc}"
}

unlock_kernel() {
    echo -e "${red}Unlocking kernel version...${nc}"
        
# Print blinking and green text
    echo -e "${green}${BOLD}${BLINK}Please enter your root password${RESET}"

# Wait for the user to input their password
    read -s -p "Password: " password
    echo
    echo -e "The password you entered is: ${red}${BOLD}${BLINK}${RESET}"
    echo $password | sudo -S sudo apt-mark unhold linux-image-$(uname -r)
    echo $password | sudo -S sudo apt-mark unhold linux-headers-$(uname -r)
    echo -e "${red}Kernel version $(uname -r) unlocked.${nc}"
}

showhold() {
    echo -e "${red}showhold kernel...${nc}"
    sudo apt-mark showhold
    echo -e "${red}Output : linux-image-[your-kernel-version]${nc}"
}

List_all_kernel() {
    echo -e "${red}List all installed Linux kernel packages...${nc}"
    echo $password | sudo -S dpkg --list |grep linux-image
    echo -e "${red}Output : linux-image-[your-kernel-version]${nc}"
}

Remove_linux-image-6.8.0-51-generic() {
    echo -e "${red}remove linux-image-6.8.0-51-generic...${nc}"
    echo $password | sudo -S sudo apt remove linux-image-6.8.0-51-generic
    #echo -e "${red}Output : linux-image-[your-kernel-version]${nc}"
}

Downgrade_linux-image-5.19.0-32-generic() {
    echo -e "${red}downgrade to linux-image-5.19.0-32-generic...${nc}"
    echo $password | sudo -S sudo sed -i 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 5.19.0-32-generic"/' /etc/default/grub && sudo update-grub
    #echo -e "current version : linux-image-[your-kernel-version]"
    echo -e "${green}$(uname -r)${nc}"  
}

Install_nvidia-driver-550() {
    echo -e "${red}Install nvidia-driver-550...${nc}"
    sudo add-apt-repository ppa:graphics-drivers/ppa --yes
    sudo apt update
    sudo apt install nvidia-utils-550 -y
    sudo apt update
    sudo apt install nvidia-driver-550 nvidia-cuda-toolkit -y
:<<BLOCK
    ## (Optional) Mark the driver as hold to prevent auto-upgrading (since it is a server):
    dpkg-query -W --showformat='${Package} ${Status}\n' | grep -v deinstall | awk '{ print $1 }' | \
    grep -E 'nvidia.*-[0-9]+$' | \
    xargs -r -L 1 sudo apt-mark hold
BLOCK
    echo -e "${red}${BOLD}${BLINK}Nvidia driver 550 installation completed.\nWill reboot in 30 seconds, ctrl +c to cancel or reboot by manual.${RESET}"

## Countdown
    countdown=30  # Set countdown duration in seconds
    
while [ $countdown -gt 0 ]; do
    echo -ne "Counting down: $countdown seconds remaining\r"  # -ne means no newline, \r returns to the beginning of the line
    sleep 1  # Pause for 1 second
    countdown=$((countdown - 1))  # Decrease the countdown by 1
done

echo -e "\nCountdown finished!"  # After the countdown is complete, move to a new line and display the message
    sleep 3
    sudo reboot
}

custom_NV_driver() {
    echo -e "${green}Enter the NVIDIA driver version you want to install (e.g., 545):${nc}"
    read -r driver_version

    if [[ ! $driver_version =~ ^[0-9]+$ ]]; then
        echo -e "${red}Invalid version number. Please enter a numeric value.${nc}"
        return
    fi

    echo -e "${red}Installing nvidia-driver-${driver_version}...${nc}"
    sudo add-apt-repository ppa:graphics-drivers/ppa --yes
    sudo apt update
    sudo apt install -y "nvidia-utils-${driver_version}" "nvidia-driver-${driver_version}" nvidia-cuda-toolkit

    echo -e "${red}${BOLD}${BLINK}Nvidia driver ${driver_version} installation completed.\nWill reboot in 30 seconds, ctrl +c to cancel or reboot manually.${RESET}"

    countdown=30  # Set countdown duration in seconds
    while [ $countdown -gt 0 ]; do
        echo -ne "Counting down: $countdown seconds remaining\r"
        sleep 1
        countdown=$((countdown - 1))
    done


    echo -e "\nCountdown finished!"
    sleep 3
    sudo reboot
}

Uninstall_nvidia-driver() {
    echo -e "${red}Uninstall nvidia-driver...${nc}"
    sudo apt remove --purge '^nvidia-.*' -y
    sudo apt autoremove -y
    echo -e "${red}nvidia driver uninstalled. To execute command nvidia-smi to check.${nc}"  
}

Open_nvidia_website() {
    export DISPLAY=:0
    xhost +local:root
    echo -e "${green}Opening NVIDIA driver FAQ website...${nc}"
    gnome-terminal -- xdg-open "https://www.nvidia.com/en-gb/drivers/drivers-faq/" || echo -e "${red}Failed to open the browser. Please check your system settings.${nc}"
}

list_all() {
    echo -e "${red}List all NVIDIA supported drivers...${nc}"
    sudo apt search nvidia-driver
}

nvidia-packages-installed() {
    echo -e "${red}What packages from nvidia you have installed...${nc}"
    sudo dpkg -l | grep -i nvidia
}

Install_CUDA_arm() {
    echo -e "${green}Installing CUDA with JP6...${nc}"
    
    # Update the system and install NVIDIA JetPack
    sudo apt-get update
    sudo apt-get install -y nvidia-jetpack

    # Prepare environment variables
    CUDA_VERSION="12.2"
    CUDA_PATH="/usr/local/cuda-$CUDA_VERSION"

    # Append environment variables to ~/.bashrc
    echo -e "\n# Set CUDA Path" >> ~/.bashrc
    echo "export PATH=\"$CUDA_PATH/bin:\$PATH\"" >> ~/.bashrc
    echo "export LD_LIBRARY_PATH=\"$CUDA_PATH/lib64:\$LD_LIBRARY_PATH\"" >> ~/.bashrc

    # Reload ~/.bashrc
    source ~/.bashrc

    # Verify changes were applied
    echo "CUDA Path added to ~/.bashrc:"
    tail -n 3 ~/.bashrc
    echo -e "${green}CUDA installation completed.${nc}"
}

Uninstall_CUDA_arm() {
    echo -e "${red}Uninstalling CUDA with JP6...${nc}"
    # Uninstallation function
    
    echo -e "\nWould you like to uninstall NVIDIA JetPack and CUDA? (y/n)"
    read -r response
    
    if [[ $response == "y" || $response == "Y" ]]; then
        echo "Uninstalling NVIDIA JetPack and CUDA..."
        sudo apt-get remove --purge -y nvidia-jetpack
        sudo apt-get autoremove -y

        # Remove environment variables from ~/.bashrc
        sed -i '/# Set CUDA Path/,+2d' ~/.bashrc

        # Reload ~/.bashrc
        source ~/.bashrc

        echo "NVIDIA JetPack and CUDA have been uninstalled, and environment variables removed."
    else
        echo "Uninstallation cancelled."
    fi
        echo -e "${red}CUDA uninstalled.${nc}"
}

Install_CUDA_x86() {
    echo -e "${green}Installing CUDA with x86...${nc}"
    
    # Refer to https://developer.nvidia.com/cuda-downloads   // CUDA Toolkit 12.6 Update 3 Downloads
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
    sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/12.6.3/local_installers/cuda-repo-ubuntu2204-12-6-local_12.6.3-560.35.05-1_amd64.deb
    cd "$(dirname "$(sudo find / -name 'cuda-repo-ubuntu2204-12-6-local_12.6.3-560.35.05-1_amd64.deb' 2>/dev/null | head -n 1)")"
    sudo dpkg -i cuda-repo-ubuntu2204-12-6-local_12.6.3-560.35.05-1_amd64.deb
    sudo cp /var/cuda-repo-ubuntu2204-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/
    sudo apt-get update
    sudo apt-get -y install cuda-toolkit-12-6
    
    # Driver installer
    sudo apt-get install -y nvidia-open
    echo -e "${green}CUDA 12.6 installation completed.${nc}"
}

Uninstall_CUDA_x86() {
    echo -e "${red}Uninstalling CUDA and related components...${nc}"

    # Step 1: Remove CUDA Toolkit
    echo -e "${red}Removing CUDA Toolkit...${nc}"
    sudo apt-get remove --purge -y cuda-toolkit-12-6

    # Step 2: Remove NVIDIA Open Kernel Module
    echo -e "${red}Removing NVIDIA Open Kernel Module...${nc}"
    sudo apt-get remove --purge -y nvidia-open

    # Step 3: Remove remaining CUDA packages
    echo -e "${red}Removing remaining CUDA packages...${nc}"
    sudo apt-get remove --purge -y "cuda*" "nvidia*"
    sudo apt-get autoremove -y
    sudo apt-get autoclean -y

    # Step 4: Remove CUDA Repository and Configuration Files
    echo -e "${red}Removing CUDA repository and configuration files...${nc}"
    sudo rm -f /etc/apt/preferences.d/cuda-repository-pin-600
    sudo rm -f /etc/apt/sources.list.d/cuda*
    sudo rm -rf /var/cuda-repo-ubuntu2204-12-6-local

    # Step 5: Remove CUDA Environment Variables from ~/.bashrc
    echo -e "${red}Cleaning up environment variables...${nc}"
    sed -i '/\/usr\/local\/cuda/d' ~/.bashrc
    source ~/.bashrc

    echo -e "${green}CUDA and related components have been successfully uninstalled.${nc}"
}

CUDA_ckeck() {
    echo -e "${red}Display Driver and CUDA version...${nc}"
    gnome-terminal --geometry=100x24 -- bash -c "nvidia-smi; exec bash" 
}

NVIDIA_CUDA_Installation_Guide() {
    export DISPLAY=:0
    xhost +local:root
    echo -e "${green}Opening NVIDIA driver FAQ website...${nc}"
    #gnome-terminal -- xdg-open "https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#meta-packages" || echo -e "${red}Failed to open the browser. Please check your system settings.${nc}"
    gnome-terminal -- firefox --new-tab "https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#meta-packages" --new-tab "https://developer.nvidia.com/cuda-downloads"
}

# LAN management functions
list_networks() {
    echo -e "${green}Listing all network interfaces and their IP addresses:${nc}"
    gnome-terminal -- bash -c "ip -br addr; exec bash"
}

set_static_ip() {
    echo -e "${yellow}Available network interfaces:${nc}"
    ip -br addr | awk '{print $1}'
    read -p "Enter the network interface to configure (e.g., enp0s3): " interface
    read -p "Enter the static IP address (e.g., 192.168.1.100): " ip_addr
    netmask="255.255.255.0"
    sudo ip addr add "$ip_addr/$netmask" dev "$interface"
    sudo ip link set "$interface" down
    sleep 3
    sudo ip link set "$interface" up
    #sudo service network-manager restart
    #sudo systemctl restart systemd-networkd
    echo -e "${green}Static IP $ip_addr set for $interface.${nc}"
    gnome-terminal -- bash -c "ip -br addr; exec bash"
}

batch_set_static_ip() {
    echo -e "${yellow}Setting static IPs for all network interfaces...${nc}"
    interfaces=($(ip -br addr | awk '{print $1}' | grep '^e'))
    base_ip=("192.168.10.10")
    for i in "${!interfaces[@]}"; do
        ip_addr=${base_ip[$i]:-"192.168.$((i + 10)).10"}
        sudo ip addr add "$ip_addr/24" dev "${interfaces[$i]}"
        sudo ip link set "${interfaces[$i]}" down
        sleep 3
        sudo ip link set "${interfaces[$i]}" up
        #sudo service network-manager restart
        #sudo systemctl restart systemd-networkd
        echo -e "${green}Static IP $ip_addr set for ${interfaces[$i]}.${nc}"
    done
    gnome-terminal -- bash -c "ip -br addr; exec bash"
}

set_dhcp() {
    echo -e "${yellow}Restoring all 'e'-prefix network interfaces to DHCP mode...${nc}"

    # Filter out interfaces that start with 'e'
    interfaces=($(ip -br addr | awk '{print $1}' | grep '^e'))

    # Ensure there is at least one matching interface
    if [[ ${#interfaces[@]} -eq 0 ]]; then
        echo -e "${red}No network interfaces found starting with 'e'.${nc}"
        return 1
    fi

    # Ensure the systemd-networkd service is running
    if ! systemctl is-active --quiet systemd-networkd; then
        echo -e "${red}systemd-networkd is not running. Trying to start it...${nc}"
        sudo systemctl start systemd-networkd || {
            echo -e "${red}Failed to start systemd-networkd. Exiting.${nc}"
            return 1
        }
    fi

    # Create .network configuration files for all matching interfaces
    for interface in "${interfaces[@]}"; do
        config_file="/etc/systemd/network/$interface.network"
        echo -e "[Match]\nName=$interface\n\n[Network]\nDHCP=yes" | sudo tee "$config_file" > /dev/null
        echo -e "${green}DHCP enabled for $interface (${config_file}).${nc}"
    done

    # Restart systemd-networkd once after all configurations are updated
    echo -e "${yellow}Restarting systemd-networkd...${nc}"
    sudo systemctl restart systemd-networkd

    # Display the current IP configuration
    gnome-terminal -- bash -c "ip -br addr; exec bash"
}

check_wol_support() {
    # List network interfaces
    echo -e "${green}Available network interfaces:${nc}"
    ip -br link | awk '{print $1}'

    # Prompt user to enter an interface
    read -p "Enter the network interface to check WOL support (e.g., enp0s3): " interface

    # Display the selected interface in red
    echo -e "${red}Selected interface: $interface${nc}"

    # Display ethtool output with green text
    ethtool enp2s0f0 | grep -i 'Wake-on' | sed -e "s/.*/\x1b[38;5;82m'&\x1b[0m/"

    echo -e "\n${yellow}Explanation of 'Supports Wake-on' values:${nc}"
    echo -e "${BR_yellow}p:${nc} Wake on PHY activity           (physical layer changes, such as link state)."
    echo -e "${BR_yellow}u:${nc} Wake on unicast packets        (specific to the device's MAC address)."
    echo -e "${BR_yellow}m:${nc} Wake on multicast packets      (group communication packets)."
    echo -e "${BR_yellow}b:${nc} Wake on broadcast packets      (packets sent to all devices on the network)."
    echo -e "${BR_yellow}g:${nc} Wake on Magic Packet           (standard wake-up signal for WOL)."
}

# Display the menu
while true; do
    echo -e "\n${green}===================== MAIN MENU ========================${RESET}"
    echo -e "${BR_blue}1) One-click install (tools) ${RESET}"
    echo -e "${BR_blue}2) GPU-burn management (Jetson / x86)${RESET}"
    echo -e "${BR_blue}3) Install Chrome${RESET}"
    echo -e "${BR_blue}4) Install pycharm-community${RESET}"
    #echo e "${BR_gray}----------------------------------------------------------${RESET}"
    echo -e "${LT_blue}5) Kernel Lock / Unlock${RESET}"
    echo -e "${LT_blue}6) Kernel managerment${RESET}"
    #echo e "${BR_gray}----------------------------------------------------------${RESET}"
    echo -e "${BL_blue}7) NVIDIA driver management${RESET}"
    echo -e "${BL_blue}8) CUDA management${RESET}"
    #echo e "${BR_gray}----------------------------------------------------------${RESET}"
    echo -e "${BL_purple}9) LAN management${RESET}"
    echo -e "${red}Q) Exit${RESET}"
    echo -e "${green}========================================================${RESET}"
    echo
    read -p "Enter your choice [1-9] or [Q/q]: " choice

    case $choice in
        1)
            echo -e "\n${green}One-click install Options:${nc}"
            #[acpid] [can-utils] [dbus-x11] [gparted] [hardinfo] [inxi]  [jtop] [kdiskmark] [minicom] [net-tools] [smplayer] [pps]
            echo -e "1. One-click install \n[acpid] [can-utils] [dbus-x11] [ethtool] [gparted] [hardinfo] [inxi]  [jtop] [kdiskmark] [minicom] [net-tools] [smplayer] [pps]\n"
            echo "2. One-click uninstall"
            read -p "Enter your choice [1-2]: " One_click_install_choice
            case $One_click_install_choice in
                1) One-click_install ;;
                2) One-click_uninstall ;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;
        2)
            echo -e "\n${green}gpu-burn-jetson Options:${nc}"
            echo "1. Install   gpu-burn-jetson"
            echo "2. Uninstall gpu-burn-jetson"
            echo "3. Install   gpu-burn-x86"
            echo "4. Uninstall gpu-burn-x86"
            read -p "Enter your choice [1-4]: " gpu_burn_choice
            case $gpu_burn_choice in
                1) install_gpu_burn_jetson ;;
                2) uninstall_gpu_burn_jetson ;;
                3) install_gpu_burn_x86 ;;
                4) uninstall_gpu_burn_x86 ;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;

        3)
            echo -e "\n${green}Chrome Options:${nc}"
            echo "1. Install   Chrome"
            echo "2. Uninstall Chrome"
            read -p "Enter your choice [1-2]: " Chrome_choice
            case $Chrome_choice in
                1) install_Chrome ;;
                2) uninstall_Chrome ;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;
        4)
            echo -e "\n${green}pycharm-community Options:${nc}"
            echo "1. Install   pycharm-community"
            echo "2. Uninstall pycharm-community"
            read -p "Enter your choice [1-2]: " pycharm_choice
            case $pycharm_choice in
                1) install_pycharm-community ;;
                2) uninstall_pycharm-community ;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;            
        5)
            echo -e "\n${green}Kernel Options:${nc}"
            echo "1. Lock   kernel"
            echo "2. Unlock kernel"
            echo "3. showhold"
            read -p "Enter your choice [1-3]: " kernel_choice
            case $kernel_choice in
                1) lock_kernel ;;
                2) unlock_kernel ;;
                3) showhold;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;
        6)
            echo -e "\n${green}Kernel Options:${nc}"
            echo "1. List_all_kernel"
            echo "2. Remove_linux-image-6.8.0-51-generic"
            echo "3. Downgrade to linux-image-5.19.0-32-generic"
            read -p "Enter your choice [1-3]: " kernel_choice
            case $kernel_choice in
                1) List_all_kernel;;
                2) Remove_linux-image-6.8.0-51-generic;;
                3) Downgrade_linux-image-5.19.0-32-generic;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;
        7)
echo -e "\n${green}Driver Options:${nc}"
            echo "1. Install nvidia-driver-550 # version 550.120-0ubuntu0.22.04.1"
            echo "2) Install custom NVIDIA driver (user input)"          
            echo "3. Uninstall nvidia-driver"
            echo "4) Open NVIDIA driver FAQ website"
            echo "5. list all NVIDIA supported drivers"
            echo "6. What packages from nvidia you have installed"
            read -p "Enter your choice [1-6]: " NVIDIA_Driver_choice
            case $NVIDIA_Driver_choice in
                1) Install_nvidia-driver-550;;
                2) custom_NV_driver;;
                3) Uninstall_nvidia-driver;;
                4) Open_nvidia_website;;
                5) list_all;;
                6) nvidia-packages-installed;;
            esac
            ;;
        8)
echo -e "\n${green}CUDA Options:${nc}"
            echo "1. Install   CUDA with JP6"
            echo "2. Uninstall CUDA with JP6"
            echo "3. Install   CUDA 12.6_x86 in ubuntu 22.04"
            echo "4. Uninstall CUDA 12.6_x86 in ubuntu 22.04"
            echo "5. CUDA version check"
            echo "6. NVIDIA CUDA Installation Guide for Linux"
            read -p "Enter your choice [1-4]: " CUDA_choice
            case $CUDA_choice in
                1) Install_CUDA_arm;;
                2) Uninstall_CUDA_arm;;
                3) Install_CUDA_x86;;
                4) Uninstall_CUDA_x86;;
                5) CUDA_ckeck;;  
                6) NVIDIA_CUDA_Installation_Guide;;          
            esac
            ;;
        9)
            echo -e "\n${green}LAN Management Options:${nc}"
            echo "1. List all network interfaces and their IP addresses"
            echo "2. Configure a network interface with a static IP"
            echo "3. Batch configure static IPs for all interfaces"
            echo "4. Restore all interfaces to DHCP mode"
            echo "5. Check WOL support for a specific interface"
            read -p "Enter your choice [1-5]: " lan_choice
            case $lan_choice in
                1) list_networks ;;
                2) set_static_ip ;;
                3) batch_set_static_ip ;;
                4) set_dhcp ;;
                5) check_wol_support ;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;
        Q|q)
            echo -e "${green}Exiting...${nc}"
            break 2
            ;;
        *)
            echo -e "${red}Invalid choice. Please try again.${nc}" ;;
    esac

done



:<<BLOCK




BLOCK

