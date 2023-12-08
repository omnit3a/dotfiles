#!/usr/bin/env fish

function verify_args -a expected found
    if test $expected -eq $found
	return 0
    end
    print_error "incorrect number of parameters were passed"
    return 1
end

function create_function -a func in
    set valid verify_args 2 (count $argv)
    if not $valid; return 1; end

    funcsave -q $func

    if [ $in = "" ]
	return 0
    end
    print_status "function:new" "functions" "created function \"$in\""
end

function create_alias -a func in out
    set valid verify_args 3 (count $argv)
    if not $valid; return 1; end
        
    funcsave -q $func
    
    if [ $in = "" ]
	return 0
    end
    if [ $out = "" ]
	return 0
    end
    print_status "alias:new" "functions" "created alias for \"$in\" as \"$out\""
end

function print_status -a stat stat_type msg
    set valid verify_args 3 (count $argv)
    if not $valid; return 1; end

    switch $stat_type
	case "general"
	    set color brgreen	    
	case "linux"
	    set color red
	case "files"
	    set color brmagenta	    
	case "functions"
	    set color brblue
	case "common"
	    set color brmagenta
	case "shell"
	    set color blue
	case "compile"
	    set color brcyan
	case "binutils"
	    set color bryellow
	case "git"
	    set color brgreen
	case "windows"
	    set color magenta	   
    end

    set colors (set_color -c)
    echo $colors | grep -q $stat_type
    if test $status -eq 0
	set color $stat_type
    end

    printf "[%s%s%s]: %s\n" \
	(set_color $color) \
	$stat \
	(set_color normal) \
	$msg
end

function print_warning -a msg
    set valid verify_args 1 (count $argv)
    if not $valid; return 1; end

    printf "[%sWARNING%s]: %s\n" \
	(set_color bryellow) \
	(set_color normal) \
	$msg
end

function print_error -a msg    
    printf "[%sERROR%s]: %s\n" \
	(set_color brred) \
	(set_color normal) \
	$msg
end

function destroy_function -a func_name
    set valid verify_args 1 (count $argv)
    if not $valid; return 1; end

    if [ "$func_name" = "" ]
	print_error "no function name was specified"
	return 1
    end

    if functions -q $func_name
	functions --erase $func_name
	funcsave -q $func_name
	print_status "function:remove" "functions" "successfully removed $func_name"
    else
	print_error "$func_name does not exist or cannot be found"
    end

end

function confirm -a msg yes_no
    set valid verify_args 2 (count $argv)
    if not $valid; return 1; end

    switch $yes_no
	case "yes"
	    set option "Y/n"
	    set default_stat "yes"
	    set option_color brgreen
	    set default_output 0
	case "no"
	    set option "y/N"
	    set default_stat "no"
	    set option_color brred
	    set default_output 1
	case "def"
	    set option "y/n"
	    set option_color bryellow
	    set default_output 2
	case "*"
	    print_error "default option not specified, or is unrecognizable"
	    return -1
    end
	
    set prompt (printf "%s" $option)
    
    while true
	print_status $option $option_color $msg
	read -l -P "" input
	
	if [ $input = "" ]
	    if [ $default_output = 2 ]
		continue
	    end
	    return $default_output
	end
	
	switch $input
	    case Y y
		return 0
	    case N n
		return 1
	end
    end
end

function fish_prompt
    set -x prev_cmd $history[1]
    if test $status -eq 0
	set prompt_color brcyan
    else
	set prompt_color brred
	if command -q $prev_cmd
	    print_error "$prev_cmd failed for some reason"
	end
    end

    set_color $fish_color_cwd
    set dir_name (basename $PWD)
    echo -n "$dir_name "
    set_color $prompt_color
    echo -n "% "
end

function run_bg_func
    set valid verify_args 1 (count $argv)
    if not $valid; return 1; end

    $HOME/dotfiles/fish/run_c $argv[1] &
    return $status
end

printf "%s> Fish Shell related setup%s\n" (set_color bryellow) (set_color normal)
create_function verify_args "verify_args"
create_function fish_prompt "fish_prompt"
print_status "fish" "shell" "set fish shell prompt"
create_function confirm "confirm"
create_function print_status "print_status"
create_function print_warning "print_warning"
create_function print_error "print_error"
create_function create_function "create_function"
create_function create_alias "create_alias"
create_function destroy_function "destroy_function"
create_function run_bg_func "run_bg_func"
echo ""

printf "%s> Fisher setup%s\n" (set_color bryellow) (set_color normal)
function install_fisher
    if test -e $HOME/.config/fish/functions/fisher.fish
	print_warning "fisher is already installed"
	return 1
    end
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source \
	&& fisher install jorgebucaran/fisher > fisher-install.log
    if test -e "$HOME/.config/fish/functions/fisher.fish"
	print_status "success" "general" "fisher was installed successfully"
    end
end

if confirm "Install fisher?" "yes"
    install_fisher
    if test -e fisher-install.log
	if confirm "Delete log file (fisher-install.log)?" "yes"
	    rm fisher-install.log
	end
	if not test -e fisher-install.log
	    print_status "remove" "files" "successfully removed fisher-install.log"
	end
    end
end

function install_fisher_pkg -a name path
    set valid verify_args 2 (count $argv)
    if not $valid; return 1; end
    
    if not functions -q "fisher"
	print_error "fisher is not installed"
	return 1
    end

    if not functions -q $name
	fisher install $path
	if functions -q $name
	    print_status "shell:fish" "shell" "successfully installed $name"
	else
	    print_error "could not install $name"
	    return 1
	end
    else
	print_warning "package $name is already installed"
	return 1
    end
    if functions -q "source ~/dotfiles/setup-fish.fish"
	source ~/dotfiles/setup-fish.fish
    end
end

function ls -a dir
    exa --long --no-user --no-permissions --no-time --binary --header --group-directories-first $dir
end

printf "%s> Alias creation%s\n" (set_color bryellow) (set_color normal)
if confirm "Using exa?" "yes"
    create_alias ls "exa" "ls"
end

function chper -a add_rem perm file
    set valid verify_args 3 (count $argv)
    if not $valid; return 1; end

    if [ $add_rem = "add" ]
	set change "+"
    else if [ $add_rem = "rem" ]
	set change "-"
    else
	print_error "specified permission qualifier is not recognized"
	return 1
    end
    
    if [ $perm = "" ]
	print_error "specified permission is not recognized"
	return 1
    end

    switch $perm
	case "exec"
	    if [ $change = "+" ]
		if test -x $file
		    print_error "file is already marked as executable"
		    return 1
		end
	    else
		if not test -x $file
		    print_error "file is already marked as non-executable"
		    return 1
		end
	    end
	    set perm_char "x"
	case "write"
	    if [ $change = "+" ]
		if test -w $file
		    print_error "file is already marked as writable"
		    return 1
		end
	    else
		if not test -w $file
		    print_error "file is already marked as non-writable"
		    return 1
		end
	    end
	    set perm_char "w"
	case "read"
	    if [ $change = "+" ]
		if test -r $file
		    print_error "file is already marked as readable"
		    return 1
		end
	    else
		if not test -r $file
		    print_error "file is already marked as non-readable"
		    return 1
		end
	    end
	    set perm_char "r"
	case "*"
	    print_error "specified permission is not recognized"
	    return 1
    end
    
    chmod (string join '' $change $perm_char) $file
    
    if [ $change = "+" ]
	set desc "is now"
    else if [ $change = "-" ]
	set desc "is no longer"
    end
    
    switch $perm
	case "exec"
	    if [ $change = "+" ]
		if test -x $file
		    print_status "permissions" "files" "file is now executable"
		    return 0
		end
	    else
		if not test -x $file
		    print_status "permissions" "files" "file is no longer executable"
		    return 0
		end
	    end
	case "write"
	    if [ $change = "+" ]
		if test -w $file
		    print_status "permissions" "files" "file now writable"
		    return 0
		end
	    else
		if not test -w $file
		    print_status "permissions" "files" "file no longer writable"
		    return 0
		end
	    end
	case "read"
	    if [ $change = "+" ]
		if test -r $file
		    print_status "permissions" "files" "file now readable"
		    return 0
		end
	    else
		if not test -r $file
		    print_status "permissions" "files" "file no longer readable"
		    return 0
		end
	    end
    end
    print_error "no permissions were able to be modified"
    return 1
end

if confirm "Add alias for chmod?" "yes"
    create_alias chper "chmod" "chper"
end

function is_emacs_running
    emacsclient -a false -e '0' &> /dev/null
    return $status
end

create_function is_emacs_running "is_emacs_running"

function start_emacs
    print_status "emacs:server" \
	"common" \
	"attempting to start emacs server"
    if not is_emacs_running
	/sbin/emacs --daemon &> /dev/null
    else
	print_error "emacs is already running"
	return 1
    end

    if is_emacs_running
	print_status "emacs:server" \
	    "common" \
	    "successfully started emacs server"
	return 0
    else
	print_error "something went wrong when starting emacs"
	return 1
    end
end

function emacs_handler --on-event emacs_done
    run_bg_func "fish -c start_emacs &> /dev/null"
    commandline (commandline --cut-at-cursor)
end

function emacs
    if not is_emacs_running
	start_emacs
    end
    print_status "emacs:server" \
	"common" \
	"attempting to connect to emacs server"
    emacsclient -t $argv
    emit emacs_done
end

if confirm "Add alias for starting emacsclient" "yes"
    create_alias start_emacs "emacs_server" "start_emacs"
    create_alias emacs "emacsclient" "emacs"
end

cp $HOME/dotfiles/fish/* $HOME/.config/fish/
