#!/usr/bin/env fish

pkill Xorg &
wait $last_pid
echo "test"
