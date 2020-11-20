#!/usr/bin/env fish
#
# Switch xcode environments. Assumes installations are in /Applications/Xcode,
# named like "Xcode-{version}.app"
#
# The root xcode installations directory can be changed by setting $XCODE_DIR
function xcodenv --description "Switch Xcode installations"
    if test -z "$XCODE_DIR"
        set XCODE_DIR "/Applications/Xcode"
    end
    function print-version
        echo $argv | awk '{split($0,a,"-"); print a[2]}' | awk '{split($0,a,".app"); print a[1]}'
    end
    set SYM_DIR ~/.local/share/xcodenv
    set USAGE "Switch Xcode installations
    Usage: xcodenv <command> [<args>]

    Commands:
        bootstrap       configure a new installation (uses sudo)
        set <version>   set which version to use
        version         print the current version number
        versions        list installed versions
        which           print the current developer directory"

    if test (count $argv) -eq 0
        echo $USAGE
    else
        switch (echo $argv[1])
        case bootstrap
            mkdir -p $SYM_DIR
            xcodenv set (xcodenv versions | tail -n 1)
            sudo xcode-select --switch $SYM_DIR/Xcode.app
        case versions
            for file in $XCODE_DIR/Xcode-*
                print-version $file
            end
        case set
            if test (count $argv) -eq 2
                # -s: create symbolic link
                # -F: remove target dir so link may occur
                # -h: do not follow symbolic link
                ln -sFh $XCODE_DIR/Xcode-$argv[2].app $SYM_DIR/Xcode.app
            else
                echo $USAGE
            end
        case version
            print-version (xcodenv which)
        case which
            realpath (xcode-select --print-path)
        case '*'
            echo $USAGE
        end
    end
end

