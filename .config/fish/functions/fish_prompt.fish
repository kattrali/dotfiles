function fish_prompt
    set -l last_status $status
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    if test $last_status -eq 0
        echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    else
        echo -n (set_color red)'❯❯❯ '
    end
end
