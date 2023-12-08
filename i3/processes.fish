#!/usr/bin/env fish

set tmp_file "$HOME/.config/i3/i3processes.tmp"
set process_name "fish -c processes_update"

if not test -e $tmp_file
    touch $tmp_file
end

function processes_update
    while true
	set value (ps -ef | wc -l)
	echo $value > $HOME/.config/i3/i3processes.tmp
	sleep 1
    end
end

create_function processes_update "processes_update"
run_bg_func "fish -c processes_update"
