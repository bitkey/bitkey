#!/bin/sh

run_scripts()
{
    for script in $1/*; do
        [ -x "$script" ] || continue
        . $script
    done
}

run_scripts $HOME/.xsession.d
