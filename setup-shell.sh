#!/bin/bash

source utils.sh

# install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # link plugins zsh-autosuggestions and zsh-syntax-highlighting
    ln -s /usr/share/zsh/plugins/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    ln -s /usr/share/zsh/plugins/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# create link
linkPath "configs/zshrc" ".zshrc"

cargo install bat
cargo install bottom
cargo install exa
