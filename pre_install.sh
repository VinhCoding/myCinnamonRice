#!/bin/bash

set +o history

# Bash Setup
#colorY='\033[1;32m'
#colorB='\033[0;34m'
wrap_text() {
    echo "$1" | fold -s -w 120
}

NC='\033[0m' 
RED='\033[0;31m'
GREEN='\033[0;32m'

distro=$(lsb_release -si)
desktop=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]') 

if [[ "$distro" != "Debian" && "$distro" != "Linuxmint" && "$desktop" != "cinnamon" ]]; then
    echo "This script is intended for Debian, Linux Mint, or Cinnamon desktop environments only. Exiting..."
    exit 1
fi

# Disclaimer
wrap_text "Disclaimer: By installing the contents of this GitHub repository (https://github.com/VinhCoding/myCinnamonRice), you acknowledge and agree that there is a possibility of harm to your computer system. The owner of this repository does not take any responsibility for any damages, losses, or adverse effects that may occur as a result of installing or using the provided files. It is your sole responsibility to ensure the safety and integrity of your computer system. Prior to installation, we strongly recommend taking appropriate precautions, including creating backups and verifying the compatibility of the files with your system. Install and use the files at your own risk."
sleep 1; 

echo -e "\n${READ}Please Read The README.md for more information about stuff this script will do, Thank you!.${NC}\n";

# Dependencies Installer
while true; do

read -r -p "$(echo -e "Do you want to proceed? ( ${GREEN}[Y]${NC}es / ${RED}[N]${NC}o ): ")" yn

case $yn in 
	
  [yY] )  
    echo -e "\n${GREEN} Install Ranger, Kitty Terminal and Fonts: ${NC}\n";

# Set the source and destination paths
font_source_dir="./fonts"
font_destination_dir="$HOME/.fonts"

# Check if the source directory exists
if [ -d "$font_source_dir" ]; then
    # Move and rename the directory
    mv "$font_source_dir" "$font_destination_dir"

    # Print a success message
    echo "Directory moved and renamed successfully."
else
    # Print an error message if the source directory doesn't exist
    echo "Source directory '$font_source_dir' not found."
fi

sudo fc-cache -f -v;

# Check if Ranger exists
if command -v ranger &> /dev/null
  then
    echo "Ranger file manager found. Creating backup..."
    # Create a backup directory if it doesn't exist
    ranger_backup_dir="$HOME/ranger_backup"
    mkdir -p "$ranger_backup_dir"
    
    # Backup the existing Ranger configuration files
    cp -r "$HOME/.config/ranger" "$ranger_backup_dir/"
    echo "Backup created in $ranger_backup_dir"
  else
    echo "Ranger file manager not found. Proceeding with installation..."
    
    # Install Ranger (assuming a Debian-based system)
    sudo apt-get update
    sudo apt-get install -y ranger
    
    echo "Ranger file manager installed successfully."
fi

[ -d "./config/ranger" ] && mv "./config/ranger" "$HOME/.config/ranger" && echo "Ranger Directory moved and renamed successfully." || echo "Source directory './config/ranger' not found.";


# Check if Kitty terminal exists and install
if command -v kitty &> /dev/null
  then
    echo "Kitty terminal found. Creating backup..."
    # Create a backup directory if it doesn't exist
    kitty_backup_dir="$HOME/kitty_backup"
    mkdir -p "$kitty_backup_dir"
    
    # Backup the existing Kitty configuration files
    cp -r "$HOME/.config/kitty" "$kitty_backup_dir/"
    echo "Backup created in $kitty_backup_dir"
  else
    echo "Kitty terminal not found. Proceeding with installation..."
    
    # Install dependencies (assuming a Debian-based system)
    sudo apt-get update
    sudo apt-get install -y curl
    
    # Download and install Kitty terminal
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    
    # Add Kitty to the PATH
    echo 'export PATH="$HOME/.local/kitty.app/bin:$PATH"' >> "$HOME/.bashrc"
    source "$HOME/.bashrc"
    
    echo "Kitty terminal installed successfully."
fi

    [ -d "./fonts" ] && mv "./fonts" "$HOME/.fonts" && echo "Fonts Directory moved and renamed successfully." || echo "Source directory './fonts' not found.";

    [ -d "./config/kitty" ] && mv "./config/kitty" "$HOME/.config/kitty" && echo "Ranger Directory moved and renamed successfully." || echo "Source directory './config/kitty' not found.";

    # Change Default User's Terminal to Kitty
    dconf write /org/cinnamon/desktop/applications/terminal/exec "'$HOME/.local/kitty.app/bin/kitty'"

break;;


# If [No] or If Invalid Response
  [nN] ) echo 'Understandable, Have a nice day!';
		exit;;
	
  * ) echo -e invalid response;;

esac

done

set -o history
