gpg-connect-agent updatestartuptty /bye

$env:SSH_AUTH_SOCK = gpgconf --list-dirs agent-ssh-socket


set-alias -name vim -value nvim
