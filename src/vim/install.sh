#!/bin/sh
set -e

echo "Activating feature 'vim'"

# only support debian, ubuntu
apt-get update
apt-get install -y wget curl jq libfuse2 libglib2.0-0 autoconf automake cproto gettext libacl1-dev libgpm-dev libgtk-3-dev libtinfo-dev libxmu-dev libxpm-dev libncurses-dev libperl-dev liblua5.2-0 liblua5.2-dev libluajit-5.1-dev lua5.2 luajit python3-dev ruby-dev

# install vim latest AppImage
wget -O /usr/local/bin/vim.AppImage $(curl -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/vim/vim-appimage/releases/latest | jq '. | .assets[] | select(.name | test("AppImage$")) | .browser_download_url' | tr -d '"')

# extract AppImage
chmod +x /usr/local/bin/vim.AppImage

cat > /usr/local/bin/vim \
<< \EOF
#!/bin/sh
/usr/local/bin/vim.AppImage --appimage-extract-and-run $@
EOF

chmod +x /usr/local/bin/vim
