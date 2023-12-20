#!/usr/bin/env fish

cp xterm/Xdefaults $HOME/.Xdefaults
print_status "copy" "files" "copy xterm config"
xrdb -load $HOME/.Xdefaults
