#!/bin/bash
name=lua
export RAND=$RANDOM
function init() {
	mkdir /tmp/$RAND
}
function get_source() {
    curl -R -O https://github.com/SuperTux/supertux/releases/download/v0.6.3/SuperTux-v0.6.3-Source.tar.gz
}
function install() {
    echo "Getting supertux appimage..."
    curl -R -O https://github.com/SuperTux/supertux/releases/download/v0.6.3/SuperTux-v0.6.3.glibc2.29-x86_64.AppImage
    echo "Installing supertux..."
    chmod a+x SuperTux-v0.6.3.glibc2.29-x86_64.AppImage
    ./SuperTux-v0.6.3.glibc2.29-x86_64.AppImage
}
function remove() {
    echo "Killing supertux process..."
    killall supertux
    echo "Removing supertux..."
    rm -rf SuperTux-v0.6.3.glibc2.29-x86_64.AppImage
    rm SuperTux-v0.6.3-Source.tar.gz
    echo "Supertux removed successfully!"
}