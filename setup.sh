#!/bin/sh

# make sure we have the submodules
git submodule update --init --recursive

# vim setup
if [ ! -d $HOME/.vim ]
then
    mkdir $HOME/.vim
fi
cp .vim/* $HOME/.vim/*

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# Ripgrep
curl -LO 'https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep-11.0.2-x86_64-unknown-linux-musl.tar.gz'
tar xf ripgrep-11.0.2-*.tar.gz
if [ ! -d $HOME/bin/rg ]
then
    mkdir $HOME/bin/rg
fi
cp ripgrep-11.0.2-*/rg $HOME/bin/rg
rm ripgrep-11.0.2-*.tar.gz && rm -rf ripgrep-11.0.2-x86_64*
echo "export PATH=\$PATH:\$HOME/bin/rg" >> ~/.bashrc
