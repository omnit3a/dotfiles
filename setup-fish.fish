#!/usr/bin/env fish

function verify_args -a expected found
    if test $expected -eq $found
	return 1
    end
    print_error "incorrect number of parameters were passed"
    return 0
end

function create_function -a func in
    set valid verify_args 2 (count $argv)
    if $valid; return 1; end

    funcsave -q $func
    if [ $in = "" ]
	return 0
    end
    print_status "new_func" "created function \"$in\""
end

function create_alias -a func in out
    set valid verify_args 3 (count $argv)
    if $valid; return 1; end
    
    funcsave -q $func
    if [ $in = "" ]
	return 0
    end
    if [ $out = "" ]
	return 0
    end
    print_status "new_alias" "created alias for \"$in\" as \"$out\""
end

function print_status -a stat msg
    set valid verify_args 2 (count $argv)
    if $valid; return 1; end
    
    switch $stat
	# general use
	case "info"
	    set info "INFO"
	    set color brgreen
	case "exec"
	    set info "RUN"
	    set color brgreen
	case "success"
	    set info "SUCCESS"
	    set color brgreen
	case "confirm"
	    set info "?"
	    set color brgreen
	    
        # linux related
	case "apt"
	    set info "APT"
	    set color red
	case "sudo"
	    set info "SUDO"
	    set color red
	case "systemd"
	    set info "INIT"
	    set color red
	case "dd"
	    set info "DISKS:WRITE"
	    set color red
	case "lsblk"
	    set info "DISKS:READ"
	    set color red
	case "man"
	    set info "MANUAL"
	    set color red
	    
	# file manipulation related
	case "dir"
	    set info "MKDIR"
	    set color brmagenta
	case "touch"
	    set info "TOUCH"
	    set color brmagenta
	case "rm"
	    set info "REMOVE"
	    set color brmagenta
	case "chmod"
	    set info "PERMISSIONS"
	    set color brmagenta
	case "cp"
	    set info "COPY"
	    set color brmagenta
	case "mv"
	    set info "MOVE"
	    set color brmagenta
	case "rename"
	    set info "RENAME"
	    set color brmagenta
	    
	# function related
	case "new_func"
	    set info "FUNCTION:NEW"
	    set color brblue
	case "rem_func"
	    set info "FUNCTION:REMOVE"
	    set color brblue
	case "new_alias"
	    set info "ALIAS:NEW"
	    set color brblue

	# common programs
	case "cat"
	    set info "CAT"
	    set color brmagenta
	case "echo"
	    set info "ECHO"
	    set color brmagenta
	case "export"
	    set info "EXPORT"
	    set color brmagenta
	case "ls"
	    set info "LIST"
	    set color brmagenta
	case "grep"
	    set info "GREP"
	    set color brmagenta
	case "cd"
	    set info "CHDIR"
	    set color brmagenta

        # shell related
	case "clear"
	    set info "SHELL:CLEAR"
	    set color blue
	case "sh"
	    set info "SHELL:SH"
	    set color blue
	case "bash"
	    set info "SHELL:BASH"
	    set color blue
	case "fish"
	    set info "SHELL:FISH"
	    set color blue
	    
	# compilation related
	case "cc"
	    set info "COMPILE:C"
	    set color brcyan
	case "cpp"
	    set info "COMPILE:C++"
	    set color brcyan
	case "ghc"
	    set info "COMPILE:HASKELL"
	    set color brcyan
	case "lisp"
	    set info "EVAL:LISP"
	    set color brcyan	    
	case "scheme"
	    set info "EVAL:SCHEME"
	    set color brcyan

	# binutils related
	case "ld"
	    set info "LINK"
	    set color bryellow
	case "ar"
	    set info "ARCHIVE"
	    set color bryellow	    
	case "as"
	    set info "ASSEMBLE"
	    set color bryellow
	case "make"
	    set info "MAKE"
	    set color bryellow

	# git related
	case "git_clone"
	    set info "GIT:CLONE"
	    set color brgreen
	case "git_add"
	    set info "GIT:ADD"
	    set color brgreen
	case "git_rm"
	    set info "GIT:REMOVE"
	    set color br_green
	case "git_commit"
	    set info "GIT:COMMIT"
	    set color brgreen
	case "git_push"
	    set info "GIT:PUSH"
	    set color brgreen
	case "git_merge"
	    set info "GIT:MERGE"
	    set color brgreen
	case "git_checkout"
	    set info "GIT:LOAD"
	    set color brgreen
	case "git_branch"
	    set info "GIT:BRANCH"
	    set color brgreen
	case "git_merge"
	    set info "GIT:MERGE"
	    set color brgreen
	case "git_pull"
	    set info "GIT:PULL"
	    set color brgreen
	case "git_rebase"
	    set info "GIT:REBASE"
	    set color brgreen
	case "git_status"
	    set info "GIT:STATUS"
	    set color brgreen
	case "git_switch"
	    set info "GIT:SWITCH"
	    set color brgreen
	case "git_diff"
	    set info "GIT:DIFF"
	    set color brgreen
	    
    end
    printf "[%s$info%s]: %s\n" (set_color $color) (set_color normal) $msg
end

function print_warning -a msg
    set valid verify_args 1 (count $argv)
    if $valid; return 1; end

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
    if $valid; return 1; end

    if [ $func_name = "" ]
	print_error "no function name was specified"
	return 1
    end
    
    set filepath (string join '' "/home/fostyr/.config/fish/functions/" $func_name ".fish")
    if test -e $filepath
	rm $filepath
    else
	print_error "$func_name does not exist or cannot be found"
	return 1
    end

    if not test -e $filepath
	print_status "rem_func" "successfully removed $func_name"
    end
end

function confirm -a msg yes_no
    set valid verify_args 2 (count $argv)
    if $valid; return 1; end

    switch $yes_no
	case "yes"
	    set option "[Y/n]"
	    set default_stat "yes"
	    set default_output 0
	case "no"
	    set option "[y/N]"
	    set default_stat "no"
	    set default_output 1
	case "def"
	    set option "[y/n]"
	    set default_output 2
	case "*"
	    print_error "default option not specified, or is unrecognizable"
	    return -1
    end
	
    set prompt (printf "%s" $option)
    
    while true
	print_status "confirm" $msg
	read -l -P $prompt input
	
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
    printf "%s%s %s%% " \
	(set_color $fish_color_cwd) (basename $PWD)\
	(set_color brblue)
end
printf "%s> Fish Shell related setup%s\n" (set_color bryellow) (set_color normal)
create_function verify_args "verify_args"
create_function fish_prompt "fish_prompt"
print_status "fish" "set fish shell prompt"
create_function confirm "confirm"
create_function print_status "print_status"
create_function print_warning "print_warning"
create_function print_error "print_error"
create_function create_function "create_function"
create_function create_alias "create_alias"
create_function destroy_function "destroy_function"

function install_fisher
    if test -e /home/fostyr/.config/fish/functions/fisher.fish
	print_error "fisher is already installed"
	return 1
    end
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source \
	&& fisher install jorgebucaran/fisher > fisher-install.log
    if test -e /home/fostyr/.config/fish/functions/fisher.fish
	print_status "success" "fisher was installed successfully"
    end
end

if confirm "Install fisher?" "yes"
    install_fisher
    if test -e fisher-install.log
	if confirm "Delete log file (fisher-install.log)?" "yes"
	    rm fisher-install.log
	end
	if not test -e fisher-install.log
	    print_status "rm" "successfully removed fisher-install.log"
	end
    end
end
echo ""

function ls -a dir
    exa --long --no-user --no-permissions --no-time --binary --header --group-directories-first $dir
end

printf "%s> Alias creation%s\n" (set_color bryellow) (set_color normal)
if confirm "Using exa?" "yes"
    create_alias ls "exa" "ls"
end

function chper -a add_rem perm file
    set valid verify_args 3 (count $argv)
    if $valid; return 1; end

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
		    print_status "chmod" "file is now executable"
		    return 0
		end
	    else
		if not test -x $file
		    print_status "chmod" "file is no longer executable"
		    return 0
		end
	    end
	case "write"
	    if [ $change = "+" ]
		if test -w $file
		    print_status "chmod" "file now writable"
		    return 0
		end
	    else
		if not test -w $file
		    print_status "chmod" "file no longer writable"
		    return 0
		end
	    end
	case "read"
	    if [ $change = "+" ]
		if test -r $file
		    print_status "chmod" "file now readable"
		    return 0
		end
	    else
		if not test -r $file
		    print_status "chmod" "file no longer readable"
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

function fileinfo -a perm file
    set valid verify_args 2 (count $argv)
    if $valid; return 1; end

    if [ $perm = "" ]
	print_error "no file queries were specified"
	return 1
    end

    if [ $file = "" ]
	print_error "no file was specified"
	return 1

    if not test -e $file
	print_error "$file does not exist"
	return 1
    end

    set pred "is not"

    switch $perm
	case "exec"
	    set desc "an executable"
	    if test -x $file
		set pred "is"
	    end
	    set out (test -x $file)
	    
	case "write"
	    set desc "writable"
	    if test -w $file
		set pred "is"
	    end
	    set out (test -w $file)
	    
	case "read"
	    set desc "readable"
	    if test -r $file
		set pred "is"
	    end
	    set out (test -r $file)
	    
	case "dir"
	    set desc "a directory"
	    if test -d $file
		set pred "is"
	    end
	    set out (test -d $file)
	    
	case "file"
	    set desc "a regular file"
	    if test -f $file
		set pred "is"
	    end
	    set out (test -f $file)
	    
	case "link"
	    set desc "a symbolic link"
	    if test -L $file
		set pred "is"
	    end
	    set out (test -L $file)
	    
	case "mine"
	    if test -O $file
		print_status "info" "$file belongs to me"
		return 0
	    else
		print_status "info" "$file does not belong to me"
		return 1
	    end
	    
	case "empty"
	    set desc "empty"
	    if not test -s $file
		set pred "is"
	    end
	    set out (not test -s $file)
	    
	case "tty"
	    set desc "a TTY"
	    if test -t $file
		set pred "is"
	    end
	    set out (test -t $file)
	    
    end
    
    print_status "info" "$file $pred a $desc"
    end
end

if confirm "Add alias for retrieving file info?" "yes"
    create_alias fileinfo "stat" "fileinfo"
end

function ezgit -a command args
end
