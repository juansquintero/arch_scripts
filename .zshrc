# export PATH=$HOME/bin:/usr/local/bin:$PATH

# ______ _____ _   _ ______  _____ 
#|___  //  ___| | | || ___ \/  __ \
#   / / \ `--.| |_| || |_/ /| /  \/
#  / /   `--. \  _  ||    / | |    
#./ /___/\__/ / | | || |\ \ | \__/\
#\_____/\____/\_| |_/\_| \_| \____/                                  

# Fetch script
# 
pfetch

# Path to your oh-my-zsh installation.
#
export ZSH="$HOME/.oh-my-zsh"

# Oh-my-zsh theme
# 
ZSH_THEME="lukerandall"

# Oh-my-zsh update
#
zstyle ':omz:update' mode auto     
zstyle ':omz:update' mode reminder  

# Update frequency
#
zstyle ':omz:update' frequency 13

# Oh-my-zsh plugins
#
plugins=(git)

# Oh-my-zsh source
#
source $ZSH/oh-my-zsh.sh

# Aliases
# 
alias pacin="sudo pacman -S"
alias pacs="sudo pacman -Ss"
alias pacup="sudo pacman -Syu"
alias pacrm="sudo pacman -Rs"

alias yayin="yay -S"
alias yayrm="yay -Rs"
alias yays="yay -Ss"
alias yayup="yay -Syu"

alias zrc="nvim .zshrc"
alias vim="nvim"

alias fls="flatpak search"
alias fli="flatpak install"

# Java PATH
#
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'
export PATH=$JAVA_HOME/bin:$PATH 

# Flutter PATH
#
export FLUTTER='/home/juansquintero/.flutter-sdk'
export PATH=$FLUTTER/bin:$PATH

# Android PATH
#
export ANDROID_SDK_ROOT='/opt/android-sdk'
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
