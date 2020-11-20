set -l commands versions set version bootstrap which
set filter "not __fish_seen_subcommand_from $commands"
complete -xc xcodenv -d "Xcode installation switcher"
complete -c xcodenv -n "$filter" -a versions -d "List installed versions"
complete -c xcodenv -n "$filter" -a set -d " <version> Set which version to use"
complete -c xcodenv -n "$filter" -a version -d "Print the selected version"
complete -c xcodenv -n "$filter" -a bootstrap -d "Configure a new xcodenv setup"
complete -c xcodenv -n "$filter" -a which -d "Print the current developer directory"
complete -c xcodenv -n "__fish_seen_subcommand_from set" -a (xcodenv versions | string join " ")
