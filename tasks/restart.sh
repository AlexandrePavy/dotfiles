#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../lib/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple " • Restart\n"

    ask_for_confirmation "Do you want to restart?"

    if answer_is_yes; then
        sudo shutdown -r now &> /dev/null
    fi
 }

main
