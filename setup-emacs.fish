#!/usr/bin/env fish

printf "%s> Init file%s\n" (set_color bryellow) (set_color normal)
if test -e "$HOME/.emacs.d/init.el"
    print_warning "emacs init file already exists"
    
    if confirm "Overwrite?" "yes"
	cp "$HOME/dotfiles/emacs/init.el" "$HOME/.emacs.d/init.el"
	print_status "cp" "overwrote emacs init file"
    end
else
    cp "$HOME/dotfiles/emacs/init.el" "$HOME/.emacs.d/init.el"
    print_status "cp" "wrote emacs init file"
end
echo ""

printf "%s> Config file%s\n" (set_color bryellow) (set_color normal)
if test -e "$HOME/.emacs.d/config.el"
    print_warning "emacs config file already exists"
    
    if confirm "Overwrite?" "yes"
	cp "$HOME/dotfiles/emacs/config.el" "$HOME/.emacs.d/config.el"
	print_status "cp" "overwrote emacs config file"
    end
else
    cp "$HOME/dotfiles/emacs/config.el" "$HOME/.emacs.d/config.el"
    print_status "cp" "wrote emacs config file"
end
echo ""

printf "%s> Splash screen file%s\n" (set_color bryellow) (set_color normal)
if test -e "$HOME/.emacs.d/start.org"
    print_warning "emacs splash file already exists"
    
    if confirm "Overwrite?" "yes"
	cp "$HOME/dotfiles/emacs/start.org" "$HOME/.emacs.d/start.org"
	print_status "cp" "overwrote emacs splash file file"
    end
else
    cp "$HOME/dotfiles/emacs/start.org" "$HOME/.emacs.d/start.org"
    print_status "cp" "wrote emacs splash screen file"
end
echo ""
