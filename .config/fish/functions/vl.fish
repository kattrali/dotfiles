#!/usr/bin/env fish

function vl --description "list directory with preview"
    if test -n "$argv[1]"
        set fprefix "$argv[1]/"
    end
    ls -l $argv[1] | fzf --preview="if test -d '$fprefix{-1}'; ls -l $fprefix{-1}; else; cat $fprefix{-1}; end" --header-lines=1
end
