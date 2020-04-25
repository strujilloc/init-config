#!/bin/bash
echo "Programs to be installed:"
programs=("speedtest" "tools" "zsh" "zshplugins")
for program in ${programs[@]}; do
    echo "->${program}"
done
# -- update & upgrade --
sudo apt update
sudo apt upgrade -y

# --install tools --
inst_tools(){
    sudo apt install tmux neofetch sed -y    
}
# --install speedtest --
inst_speedtest(){
    sudo apt install gnupg1 apt-transport-https dirmngr -y
    export INSTALL_KEY=379CE192D401AB61
    export DEB_DISTRO=$(lsb_release -sc)
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
    echo "deb https://ookla.bintray.com/debian ${DEB_DISTRO} main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
    sudo apt update
    sudo apt install speedtest -y
}
inst_zsh(){
    sudo apt install zsh -y
    chsh -s $(which zsh)
    # install OhMyZsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

}
inst_zshplugins(){
    ZSH_CUSTOM="${ZSH}/custom"
    # enable plugins
    plugins=(git z)
    sed -i "s/plugins=(git)/plugins=(${plugins})/" ~/.zshrc
    # Spaceship theme
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="spaceship"/' ~/.zshrc
    # highlighting plugin
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    sed -i "s/plugins=(${plugins})/plugins=(${plugins} zsh-syntax-highlighting)/" ~/.zshrc
    plugins+=(zsh-syntax-highlighting)
    zsh
}
# -- Main Program --
for program in ${programs[@]}; do
    inst="inst_${program}"
    $inst
done