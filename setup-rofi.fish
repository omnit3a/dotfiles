#!/usr/bin/env fish

printf "%s> Rofi config file%s\n" (set_color bryellow) (set_color normal)
if test -e "$HOME/.config/rofi/config.rasi"
    print_warning "rofi config file already exists"
    
    if confirm "Overwrite?" "yes"
	cp "$HOME/dotfiles/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"
	print_status "cp" "overwrote rofi init file"
    end
else
    cp "$HOME/dotfiles/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"
    print_status "cp" "wrote rofi init file"
end
echo ""
