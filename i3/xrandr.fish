#!/usr/bin/env fish

set vga (xrandr -q | grep "VGA")
if string match -r "VGA1 connected" $vga
    xrandr --output LVDS1 --off
    xrandr --output VGA1 --auto --primary
else
    xrandr --output VGA1 --off
    xrandr --output LVDS1 --auto --primary
end
