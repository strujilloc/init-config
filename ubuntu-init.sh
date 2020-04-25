#!/bin/bash
echo "Programs to be installed:"
programs=("speedtest" "tools" "zsh")
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
    # Ubuntu versions supported: xenial, bionic
    # Debian versions supported: jessie, stretch, buster
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
# -- Main Program --
for program in ${programs[@]}; do
    inst="inst_${program}"
    $inst
done