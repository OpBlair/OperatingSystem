#!/bin/bash

#This script serves to automate and keep track of the files
#that I install on Linux server systems.

PACKAGES=("curl" "git" "htop" "glances" "wget" "openssh-server" "docker.io" "nginx" "vim")

install_package(){
    PACKAGE=$1
    # Checking package is intalled.
    if dpkg -l | grep -q "ii $PACKAGE "; then
        echo "[-] $PACKAGE is already installed. Skipping."
    else
        echo "[+] Installing $PACKAGE..."
        sudo apt-get install -y "$PACKAGE" > /dev/null

        if [ $? -eq 0 ]; then
            echo "| $(date +%F) | $PACKAGE | Success |" >> "$LOG_FILE"
            echo "Successfully added $PACKAGE to the lab."
        else
            echo "Error: Could not install $PACKAGE."
        fi
    fi
}

for PKG in "${PACKAGES[@]}"; do
    install_package "$PKG"
done
