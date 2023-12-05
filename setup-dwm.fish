#!/usr/bin/env fish

function setup_dwm_tree
    if not test -e $HOME/.suckless
	mkdir $HOME/.suckless
	if test -e $HOME/.suckless
	    print_status "dir" "successfully created $HOME/.suckless"
	    return 0
	else
	    print_error "could not create directory $HOME/.suckless"
	    return 1
	end
    end
end

function clone_dwm_files
    if test -e $HOME/.suckless
	cd $HOME/.suckless
	print_status "cd" "entered $HOME/.suckless"
	if not test -e dwm/
	    git clone https://git.suckless.org/dwm
	    if test $status -eq 0
		print_status "git_clone" "successfully clone dwm"
	    else
		print_error "could not clone dwm"
		return 1
	    end
	end
    end
end

function compile_dwm
    set prev_dir (pwd)

    if test -e $HOME/.suckless/dwm
	cd $HOME/.suckless/dwm
	
	print_status "info" "looking for config file"

	# copy config file
	if test -e $HOME/dotfiles/dwm/config.h
	    cp $HOME/dotfiles/dwm/config.h .
	    print_status "cp" "copied config.h file"
	else
	    print_warning "no config file was found"
	end
	
	print_status "make" "compiling dwm"
	make
	sudo make install
    else
	print_error "could not find $HOME/.suckless/dwm"
    end

    cd $prev_dir
end

printf "%s> DWM source code%s\n" (set_color bryellow) (set_color normal)
setup_dwm_tree
clone_dwm_files
echo ""

printf "%s> DWM desktop entry%s\n" (set_color bryellow) (set_color normal)
sudo cp $HOME/dotfiles/dwm/dwm.desktop /usr/share/xsessions/
if test -e /usr/share/xsessions/dwm.desktop
    print_status "cp" "successfully wrote DWM desktop entry"
end
echo ""

printf "%s> DWM functions setup%s\n" (set_color bryellow) (set_color normal)
create_function compile_dwm "compile_dwm"
echo ""
