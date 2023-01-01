#!/bin/sh
set -e

echo "Activating feature 'vim'"

# only support debian, ubuntu
apt-get update
apt-get install -y wget curl jq

# install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install gh -y

# install vim latest AppImage
wget -O /usr/local/bin/vim $(gh api -H "Accept: application/vnd.github+json" /repos/vim/vim-appimage/releases/latest | jq '. | .assets[] | select(.name | test("AppImage$")) | .browser_download_url' | tr -d '"')

chmod +x /usr/local/bin/vim
