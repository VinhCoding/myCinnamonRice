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
    echo -e "\n${GREEN}Backups Neovim, LunarVim, zshrc and Zshrc if exist: ${NC}\n";
    
    mv -v ~/.config/nvim ~/.config/_old.nvim
    mv -v ~/.local/share/nvim ~/.local/share/_old.nvim
    
    mv -v ~/.config/lvim ~/.config/_old.lvim
    
    mv -v ~/.zshrc ~/.zshrc_old
    cp /etc/skel/.zshrc ~/
    
    mv -v ~/.zshrc ~/.zshrc_old
    cp /etc/zsh/zshrc ~/.zshrc
    
    mv -v ~/.profile ~/.profile_old

    echo -e "\n${GREEN}Begin Install ZSH and Oh My ZSH: ${NC}\n";
    sudo apt install -y zsh curl;
    exec zsh; 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
    source ~/.zshrc;
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    
    # Apply P10k Themes 
    # Define the search and replace strings
    search_string="ZSH_THEMES='*'"
    replace_string="ZSH_THEMES='powerlevel10k/powerlevel10k'"

# Check if the ~/.zshrc file exists
  if [ -f ~/.zshrc ]; then
    # Find and replace the string in the file
    sed -i "s|$search_string|$replace_string|" ~/.zshrc

    # Print a success message
    echo -e "\n${GREEN}String replaced successfully${NC}\n"
  else
    # Print an error message if the file doesn't exist
    echo "\n${RED}~/.zshrc file not found.${NC}\n"
  fi

# Apply Custom Fonts for ZSH / P10K
  [ -d "./fonts" ] && mv "./fonts" "$HOME/.fonts" && echo "Directory moved and renamed successfully." || echo "Source directory './fonts' not found.";
  
  fc-cache -f -v

  source "$HOME/.zshrc";  


    echo -e "\n${GREEN}Begin Install Dependencies for LunarVim: ${NC}\n";
    
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
    echo 'export PYTHONPATH=""' >> ~/.zshrc;
    echo "source ~/.myenv/bin/activate" >> ~/.zshrc;
    source ~/.zshrc;
    pip install pynvim;
    
    echo 'alias bashreload="source ~/.zshrc"' >> ~/.zshrc;
    source ~/.zshrc;

    echo -e "\n${GREEN}Install LunarVim: ${NC}\n";
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
    
    sed -i '/source ~\/\.myenv\/bin\/activate/d' ~/.zshrc
    source ~/.zshrc;
    

    break;;






# If [No] or If Invalid Response
  [nN] ) echo 'Understandable, Have a nice day!';
		exit;;
	
  * ) echo -e invalid response;;

esac

done

set -o history
