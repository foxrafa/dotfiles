#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "This is a linux machine."

	sudo passwd root
	sudo passwd fox
	sudo apt-get update

	if ! command -v zsh &>/dev/null; then
		echo "Zsh is not installed. Installing..."
		sudo apt-get install zsh -y
		chsh -s "$(which zsh)"
	else
		echo "Zsh is already installed."
	fi

	sudo apt-get install git build-essential

	ln -s ~/dotfiles/.zprofile ~/.zprofile
	ln -s ~/dotfiles/.zshrc ~/.zshrc
	ln -s ~/dotfiles/.zsh ~/.zsh

	mkdir ~/.config
	ln -s ~/dotfiles/.config/nvim ~/.config/nvim

	curl -LO https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf nvim-linux64.tar.gz
fi
