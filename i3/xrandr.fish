#!/usr/bin/env fish

printf "%s> Setup xrandr %s\n" (set_color bryellow) (set_color normal)
set vga (xrandr -q | grep "VGA-1")
if string match -r "VGA-1 connected" $vga
    print_status "xrandr" "set monitor to VGA-1" 
    xrandr --output VGA-1 --primary --mode 1024x768
else
    print_status "xrandr" "set monitor to LVDS-1"
    xrandr --output LVDS-1 --primary --mode 1440x900 --output VGA-1 --off
end
