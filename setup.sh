#!/bin/sh

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi


# vim setup
if [ ! -d "$HOME/.vim" ]
then
    mkdir "$HOME/.vim"
fi
cp -r .vim/* "$HOME/.vim/"
vim +PlugInstall +qall

if ! command -v fzf &> /dev/null
then
  # FZF
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  $HOME/.fzf/install
fi

if [ ! -d "$HOME/bin" ]
then
    mkdir "$HOME/bin"
fi

# Ripgrep
if ! command -v rg &> /dev/null
then
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

# silver searcher
if ! command -v ag &> /dev/null
then
  if [[ "$platform" == "linux" ]]
  then
    sudo apt install silversearcher-ag
  fi
fi
