#!/bin/sh

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

if ! command -v fzf &> /dev/null
then
  if [[ "$platform" == "linux" ]]
  then
    sudo apt update
    sudo apt install fzf -y
  else 
    # FZF
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    $HOME/.fzf/install
  fi
fi

if [ ! -d "$HOME/bin" ]
then
    mkdir "$HOME/bin"
fi

# Ripgrep
if ! command -v rg &> /dev/null
then
  if [[ "$platform" == "linux" ]]
  then
    sudo apt update
    sudo apt install ripgrep -y
  else 
    curl -LO 'https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep-11.0.2-x86_64-unknown-linux-musl.tar.gz'
    tar xf ripgrep-11.0.2-*.tar.gz
    if [ ! -d "$HOME/bin/rg" ]
    then
        mkdir "$HOME/bin/rg"
    fi
    cp ripgrep-11.0.2-*/rg "$HOME/bin/rg"
    rm ripgrep-11.0.2-*.tar.gz && rm -rf ripgrep-11.0.2-x86_64*
    echo "export PATH=\$PATH:\$HOME/bin/rg" >> ~/.bashrc
  fi
fi

# silver searcher
if ! command -v ag &> /dev/null
then
  if [[ "$platform" == "linux" ]]
  then
    sudo apt install silversearcher-ag -y
  fi
fi

# vim setup
if ! command -v vim &> /dev/null; then
  if [[ "$platform" == "linux" ]]
  then
    sudo apt update
    sudo apt install vim -y
  fi
fi
if [ ! -d "$HOME/.vim" ]
then
    mkdir "$HOME/.vim"
fi
cp -r .vim/* "$HOME/.vim/"
vim +'PlugInstall --sync' +qall &> /dev/null < /dev/tty
