#!/bin/bash

# Bash Setup
#colorY='\033[1;32m'
#colorB='\033[0;34m'

NC='\033[0m' 
RED='\033[0;31m'
GREEN='\033[0;32m'
# Disclaimer
echo "Disclaimer: By installing the contents of this GitHub repository (https://github.com/VinhCoding/myCinnamonRice), you acknowledge and agree that there is a possibility of harm to your computer system."
echo "The owner of this repository does not take any responsibility for any damages, losses, or adverse effects that may occur as a result of installing or using the provided files. It is your sole responsibility to ensure the safety and integrity of your computer system."
echo "Prior to installation, we strongly recommend taking appropriate precautions, including creating backups and verifying the compatibility of the files with your system. Install and use the files at your own risk."
echo ""
sleep 1 

# Dependencies Installer
while true; do

read -r -p "$(echo -e "Do you want to proceed? ( ${GREEN}[Y]${NC}es / ${RED}[N]${NC}o ): ")" yn

case $yn in 
	
  [yY] )  echo -e "\n${GREEN}Install Dependencies for LunarVim: ${NC}\n";
   
    echo -e "\n${GREEN}Install Dependencies for LunarVim: Neovim ${NC}\n";
      curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage;
      chmod u+x nvim.appimage;
      ./nvim.appimage --appimage-extract
      ./squashfs-root/AppRun --version
      sudo mv squashfs-root /;
      sudo ln -s /squashfs-root/AppRun /usr/bin/nvim;

    echo -e "\n${GREEN}Install Dependencies for LunarVim: Git, Make, Python, Pip, Python-Venv, NodeJS and NPM ${NC}\n";
    sudo apt install -y git make python-is-python3 python3-pip python3-venv nodejs npm;

    echo -e "\n${GREEN}Install Dependencies for LunarVim: Lazygit ${NC}\n";
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*');
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz";
    tar xf lazygit.tar.gz lazygit;
    sudo install lazygit /usr/local/bin;

    echo -e "\n${GREEN}Install Dependencies for LunarVim: Rust Language ${NC}\n";
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;


    echo -e "\n${GREEN}Install Dependencies for LunarVim: Make NPM Global ${NC}\n";
    mkdir ~/.npm-global;
    npm config set prefix "$HOME/.npm-global";
    export PATH=~/.npm-global/bin:$PATH;
    source ~/.profile;
    npm install -g jshint;

    echo -e "\n${GREEN}Install Dependencies for LunarVim: Make Python-Pip Global via VENV + Install PyNvim ${NC}\n";
    python -m venv ~/.myenv;
    echo 'export PYTHONPATH=""' >> ~/.bashrc;
    echo "source ~/.myenv/bin/activate" >> ~/.bashrc;
    pip install pynvim;
    
    source ~/.bashrc;
    echo 'alias bashreload="source ~/.bashrc"' >> ~/.bashrc;
    bashreload;

    sed -i '/source ~\/\.myenv\/bin\/activate/d' ~/.bashrc
    

    echo -e "\n${GREEN}Install LunarVim: ${NC}\n";
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
    break;;


# If [No] or If Invalid Response
  [nN] ) echo 'Understandable, Have a nice day!';
		exit;;
	
  * ) echo -e invalid response;;

esac

done
