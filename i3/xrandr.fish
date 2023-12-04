#!/usr/bin/env fish

set vga (xrandr -q | grep "VGA-1")
if string match -r "VGA-1 connected" $vga
    xrandr --output VGA-1 --mode 1024x768
else
    xrandr --output LVDS-1 --auto
end
