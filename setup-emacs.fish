#!/usr/bin/env fish

cp -r $HOME/dotfiles/emacs/* $HOME/.emacs.d/
cp $HOME/dotfiles/emacs/init.el $HOME/.emacs
print_status "copy" "files" "copy emacs configs"
