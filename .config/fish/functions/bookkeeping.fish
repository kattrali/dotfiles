#!/usr/bin/env fish
#
# Helper commands for editing and viewing ledger accounts.
# Uses the default location of stored ledgers to open and edit files. To edit
# the primary ledger in $EDITOR, use:
#
#     bookkeeping edit
#
# Other ledger files and related data can be edited by specifying the name. For
# example, to edit the 'accounts.dat' file in the ledgers directory, use:
#
#     bookkeeping edit accounts
#
# Commands other than 'edit' are passed to ledger-cli (http://ledger-cli.org)
# along with any additional arguments. Example usages include:
#
#     bookkeeping balance # View balances
#     bookkeeping equity  # View available equity
#
# See Also: ledger(1)

function bookkeeping
    set LEDGERS ~/.local/share/ledger
    set NUMBERS $LEDGERS/numbers.dat
    set CMD ledger -f $NUMBERS --strict
    set USAGE "Usage: bookkeeping [edit/ledger commands]"
    if test (count $argv) -eq 0
        echo $USAGE
    else
        switch (echo $argv[1])
        case edit
            if test (count $argv) -eq 1
                eval $EDITOR $NUMBERS
            else
                eval $EDITOR $LEDGERS/$argv[2].dat
            end
        case '*'
            eval ledger -f $NUMBERS --strict $argv[1..-1]
        end
    end
end
