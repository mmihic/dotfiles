#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"


brew install macvim go git bash-completion jq


mkdir ~/tmp
mkdir ~/bin
cp trim ~/bin

ln -sf $PWD/.vimrc $HOME/.vimrc

mkdir -p $HOME/bin
ln -sf $PWD/trim $HOME/bin/trim

# Install pathogen and vim bundles
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
git clone https://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible

# Fix for go module
git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"

PWD=$( pwd )
echo "source ${PWD}/.bash_profile" >> ~/.bashrc


