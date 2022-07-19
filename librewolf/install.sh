#!/bin/bash
name=librewolf
export RAND=$RANDOM
function init() {
	mkdir /tmp/$RAND
}
function get_source() {
    echo 'Librewolf is based on Firefox. As such, there is no way to get the source code for Librewolf.'
}
function install() {
    # detect current linux distro
    # if it is ubuntu
    distro=$(lsb_release -i | cut -d: -f2 | sed 's/^[ \t]*//')
    if [ "$distro" == "Ubuntu" ]; then
        echo "Upgrading system..."
        sudo apt update && sudo apt upgrade -y
        echo "Ensuring dependencies are installed..."
        sudo apt install wget apt-transport-https gnupg2 ubuntu-keyring -y
        echo "Importing GPG key..."
        wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/librewolf.gpg
        echo "Importing repository..."
        echo deb [arch=amd64 signed-by=/usr/share/keyrings/librewolf.gpg] http://deb.librewolf.net "$(lsb_release -cs)" main | sudo tee /etc/apt/sources.list.d/librewolf.list
        echo "Updating repository..."
        sudo apt update
        echo "Installing librewolf..."
        sudo apt install librewolf -y
        echo "Librewolf installed successfully!"
    else
        # if it is arch-based
        if [ "$distro" == "Arch Linux" ]; then
            # check if yay is installed
            if [ ! -f /usr/bin/yay ]; then
                echo "Installing yay..."
                sudo pacman -S yay
            fi
            echo "Installing librewolf binary from yat..."
            sudo yay -S librewolf-bin
            echo "Librewolf installed successfully!"
        else
            # if it is any other linux distro
            echo "Librewolf is not supported on your distro."
        fi
    fi
}
function remove() {
    # detect current linux distro
    # if it is ubuntu
    distro=$(lsb_release -i | cut -d: -f2 | sed 's/^[ \t]*//')
    if [ "$distro" == "Ubuntu" ]; then
        sudo rm -f \
        /etc/apt/sources.list.d/librewolf.list \
        /etc/apt/sources.list.d/librewolf.sources \
        /etc/apt/trusted.gpg.d/librewolf.gpg \
        /etc/apt/keyrings/librewolf.gpg \
        /etc/apt/preferences.d/librewolf.pref
        sudo apt update
        sudo apt purge librewolf -y
        echo "Librewolf removed successfully!"
    else
        # if it is arch-based
        if [ "$distro" == "Arch Linux" ]; then
            sudo yay -R librewolf-bin
            echo "Librewolf removed successfully!"
        else
            # if it is any other linux distro
            echo "Librewolf is not supported on your distro."
        fi
    fi
}