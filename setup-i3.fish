#!/usr/bin/env fish

set deps tilix firefox feh xrandr fish
verify_deps $deps

printf "%s> Main i3 config file%s\n" (set_color bryellow) (set_color normal)
if test -e "$HOME/.config/i3/config"
    print_warning "i3 config file already exists"
    
    if confirm "Overwrite?" "yes"
	cp "$HOME/dotfiles/i3/config" "$HOME/.config/i3/config"
	print_status "cp" "overwrote i3 config file"
    end
else
    cp "$HOME/dotfiles/i3/config" "$HOME/.config/i3/config"
    print_status "cp" "wrote i3 config file"
end
echo ""

printf "%s> i3status config file%s\n" (set_color bryellow) (set_color normal)
if test -e "$HOME/.config/i3/i3status.conf"
    print_warning "i3status config file already exists"

    if confirm "Overwrite?" "yes"
	cp "$HOME/dotfiles/i3/i3status.conf" "$HOME/.config/i3/i3status.conf"
	print_status "cp" "overwrote i3status config file"
    end
else
    cp "$HOME/dotfiles/i3/i3status.conf" "$HOME/.config/i3/i3status.conf"
    print_status "cp" "wrote i3status config file"
end
echo ""    
