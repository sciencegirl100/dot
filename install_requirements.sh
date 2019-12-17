#!/bin/bash

# "Debian GNU/Linux"
if [[ $EUID == 0 ]]; then
  echo "Please run this script as a normal user, I will ask for root access when it's needed."
  return 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# APT Packages
if grep -q "Debian GNU/Linux" "/etc/os-release"; then
  sudo apt update
  sudo apt install -y `cat $DIR/configs/apt-packages`
fi

# Z Script
mkdir -p $HOME/.local/{bin,share}
curl https://raw.githubusercontent.com/rupa/z/master/z.sh --output $HOME/.local/bin/z
chmod +x $HOME/.local/bin/z

# Git Config
cp $DIR/configs/gitconfig $HOME/.gitconfig

# Extra Scripts
cp $DIR/sbin/* $HOME/.local/bin/

# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp $DIR/configs/zshrc $HOME/.zshrc
