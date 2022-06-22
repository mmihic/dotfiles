#!/bin/sh

set -x

brew_install() {
  brew list $1 >> /dev/null || brew install $1
}

[[ -z $(which brew)  ]] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 

brew_install macvim
brew_install go
brew_install git
brew_install jq
brew_install bash-completion

# Install goimports
[[ ! -f $HOME/go/bin/goimports ]] && go get golang.org/x/tools/cmd/goimports 

# Link to helper scripts
[[ ! -d $HOME/tmp ]] && mkdir ~/tmp 
[[ ! -d $HOME/bin ]] && ln -sf $PWD/bin $HOME/bin
[[ ! -f $HOME/.vimrc ]] && ln -sf $PWD/.vimrc $HOME/.vimrc

# Install pathogen and vim bundles
[[ ! -d $HOME/.vim/autolod ]] && \
				mkdir -p ~/.vim/autoload ~/.vim/bundle && \
				curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
[[ ! -d $HOME/.vim/bundle/vim-go ]] && \
				git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go 
[[ ! -d $HOME/.vim/bundle/vim-sensible ]] && \
				git clone https://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible 

# Fix for go module
git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"

# Source local bash_profile
PWD=$( pwd )
echo "source ${PWD}/.bash_profile" >> ~/.profile


