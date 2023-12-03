#!/usr/bin/env fish

test -e "$HOME/.config/i3/config"
echo $status

if test -e "$HOME/.config/i3/config"
    echo "test"
end

#cp i3/* ~/.config/i3/

#if i3/
