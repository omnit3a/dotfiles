#!/bin/sh

cp ~/dotfiles/emacs/init.el ~/.emacs
rm ~/.emacs.d/*~
rm ~/.emacs.d/config.el
cp ~/dotfiles/emacs/config.el ~/.emacs.d/config.el
