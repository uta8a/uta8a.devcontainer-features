#!/bin/sh
set -e

echo "Activating feature 'neovim'"

# only support debian, ubuntu
apt-get update
apt-get install -y wget

# install neovim nightly deb package
wget -P /tmp 'https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb'
apt-get install /tmp/nvim-linux64.deb
rm /tmp/nvim-linux64.deb
