#!/bin/bash
echo -e '\n# Function - change zsh theme'>> ~/.zshrc
echo 'zshtheme(){
    new_ZSH_THEME=$1
    sed -i "s/ZSH_THEME=${ZSH_THEME}/ZSH_THEME=${new_ZSH_THEME}/" ~/.zshrc
}' >> ~/.zshrc