#!/usr/bin/env fish

set deps xmonad
verify_deps $deps

function compile_xmonad
    xmonad --recompile
    echo $status
end

function install_xmonad
    cd "$HOME/.config/xmonad/"
    stack install
end

printf "%s> XMonad compilation related setup%s\n" (set_color bryellow) (set_color normal)
create_function compile_xmonad "compile_xmonad"
create_function install_xmonad "compile_xmonad"
