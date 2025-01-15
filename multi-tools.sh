#!/bin/bash

# Define colors for the menu
green='\033[1;32m'
red='\033[1;31m'
nc='\033[0m' # No color

# Define functions for installation and uninstallation
install_jtop() {
    echo -e "${green}Installing jtop...${nc}"
    sudo apt update
    sudo apt install python3-pip python2-dev build-essential -y
    sudo apt autoremove -y
    sudo pip install --upgrade pip
    sudo -H pip3 install -U jetson-stats
    sudo systemctl restart jetson_stats.service
    echo -e "${green}jtop installation completed.${nc}"
}

uninstall_jtop() {
    echo -e "${red}Uninstalling jtop...${nc}"
    sudo -H pip3 uninstall -y jetson-stats
    sudo apt remove --purge python3-pip python2-dev build-essential -y
    sudo apt autoremove -y
    echo -e "${red}jtop uninstalled.${nc}"
}

install_gpu_burn() {
    echo -e "${green}Installing gpu-burn...${nc}"
    sudo apt update
    cd ~/Desktop
    git clone https://github.com/anseeto/jetson-gpu-burn.git
    cd jetson-gpu-burn
    make
    echo -e "${green}gpu-burn installation completed.${nc}"
}

uninstall_gpu_burn() {
    echo -e "${red}Uninstalling gpu-burn...${nc}"
    rm -rf ~/Desktop/jetson-gpu-burn
    echo -e "${red}gpu-burn uninstalled.${nc}"
}

install_kdiskmark() {
    echo -e "${green}Installing kdiskmark...${nc}"
    sudo add-apt-repository ppa:jonmagon/kdiskmark -y
    sudo apt update
    sudo apt install kdiskmark -y
    echo -e "${green}kdiskmark installation completed.${nc}"
}

uninstall_kdiskmark() {
    echo -e "${red}Uninstalling kdiskmark...${nc}"
    sudo apt remove --purge kdiskmark -y
    sudo apt autoremove -y
    echo -e "${red}kdiskmark uninstalled.${nc}"
}

# Display the menu
while true; do
    echo -e "\n${green}Select an option:${nc}"
    echo "1. jtop (jetson)"
    echo "2. gpu-burn"
    echo "3. kdiskmark"
    echo "4. Exit"
    read -p "Enter your choice [1-4]: " choice

    case $choice in
        1)
            echo -e "\n${green}jtop Options:${nc}"
            echo "1. Install jtop"
            echo "2. Uninstall jtop"
            read -p "Enter your choice [1-2]: " jtop_choice
            case $jtop_choice in
                1) install_jtop ;;
                2) uninstall_jtop ;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;
        2)
            echo -e "\n${green}gpu-burn Options:${nc}"
            echo "1. Install gpu-burn"
            echo "2. Uninstall gpu-burn"
            read -p "Enter your choice [1-2]: " gpu_burn_choice
            case $gpu_burn_choice in
                1) install_gpu_burn ;;
                2) uninstall_gpu_burn ;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;
        3)
            echo -e "\n${green}kdiskmark Options:${nc}"
            echo "1. Install kdiskmark"
            echo "2. Uninstall kdiskmark"
            read -p "Enter your choice [1-2]: " kdiskmark_choice
            case $kdiskmark_choice in
                1) install_kdiskmark ;;
                2) uninstall_kdiskmark ;;
                *) echo -e "${red}Invalid choice.${nc}" ;;
            esac
            ;;
        4)
            echo -e "${green}Exiting...${nc}"
            break 2
            ;;
        *)
            echo -e "${red}Invalid choice. Please try again.${nc}" ;;
    esac

done
