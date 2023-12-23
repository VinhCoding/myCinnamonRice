#!/bin/bash

# Bash Setup
colorN='\033[0m' 
colorR='\033[0;31m'
colorG='\033[0;32m'
colorY='\033[1;32m'
colorB='\033[0;34m'

# Disclaimer
echo "Disclaimer: By installing the contents of this GitHub repository (https://github.com/VinhCoding/myCinnamonRice), you acknowledge and agree that there is a possibility of harm to your computer system."
echo "The owner of this repository does not take any responsibility for any damages, losses, or adverse effects that may occur as a result of installing or using the provided files. It is your sole responsibility to ensure the safety and integrity of your computer system."
echo "Prior to installation, we strongly recommend taking appropriate precautions, including creating backups and verifying the compatibility of the files with your system. Install and use the files at your own risk."
echo ""
sleep 1 

# Dependencies Installer
while true; do

read -p "$(echo -e "Do you want to proceed? ( ${colorG}[Y]es${colorN} / ${colorR}[N]o${colorN} ): ")" yn

case $yn in 
	
  [yY] ) echo 'Install LunarVim - BEGIN: '; 

    echo 'Install Update-To-Date Neovim: ';
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage;
    chmod u+x nvim.appimage;
    ./nvim.appimage;
    sudo mv squashfs-root /;
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim;

    echo 'Install Dependencies for LunarVim: ';
    sudo apt install -y git make python-is-python3 nodejs npm;

    echo 'Install Dependencies for LunarVim: Lazygit ';
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*');
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz";
    tar xf lazygit.tar.gz lazygit;
    sudo install lazygit /usr/local/bin;

    echo 'Install Dependencies For LunarVim: Rust Language';
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;


    echo 'Install Dependencies For LunarVim: Make NPM Global';
    mkdir ~/.npm-global;
    npm config set prefix '~/.npm-global';
    export PATH=~/.npm-global/bin:$PATH;
    source ~/.profile;
    npm install -g jshint;

    echo 'Install Dependencies For LunarVim: Install Python';
    python -m venv ~/.myenv;
    echo 'export PYTHONPATH=""; export PYTHONHOME=""; source ~/.myenv/bin/activate; alias reload="source ~/.bashrc"' >> ~/.bashrc;
    reload;
    pip install pynvim;


    break;;


# If [No] or If Invalid Response
  [nN] ) echo 'Understandable, Have a nice day!';
		exit;;
	
  * ) echo -e invalid response;;

esac

echo $? # Get exit status of a process in bash

done



