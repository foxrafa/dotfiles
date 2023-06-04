#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "This is a linux machine."

	if ! command -v zsh &>/dev/null; then
		echo "Zsh is not installed. Installing..."
		sudo passwd root
		sudo passwd fox
		sudo apt-get update
		sudo apt-get install zsh -y
		chsh -s "$(which zsh)"
	else
		echo "Zsh is already installed."
	fi

	ln -s ~/dotfiles/.zprofile ~/.zprofile
	ln -s ~/dotfiles/.zshrc ~/.zshrc
	ln -s ~/dotfiles/.oh-my-zsh ~/.oh-my-zsh
	ln -s ~/dotfiles/.vimrc ~/.vimrc
	ln -s ~/dotfiles/.vim ~/.vim
	ln -s ~/dotfiles/.zsh ~/.zsh

	sudo apt update && sudo apt install python3 nodejs git htop build-essential
fi
