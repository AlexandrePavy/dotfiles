#!/bin/bash

declare dotfilesDirectory="$HOME/dotfiles"
declare skipQuestions=false

main() {
    # Relative path
    cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

    if [ ! -x "lib/utils.sh" ]; then
        echo "[ERROR] utils can't be load"
        exit 1
    else
        source "lib/utils.sh" || exit 1
    fi

    print_in_purple "• Ready to start\n"

    verify_os && print_in_purple "• OS supported\n" || exit 1

    # Use -n|--no-interaction
    skip_questions "$@" && skipQuestions=true

    ask_for_sudo

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    #./create_local_config_files.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    #./install/main.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    #./preferences/main.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! ${skipQuestions}; then
        source ./tasks/restart.sh
    fi

    upgrade

    print_in_purple "• Finished !\n"
}

upgrade() {

    # Install the newest versions of all packages installed.

    execute \
        "export DEBIAN_FRONTEND=\"noninteractive\" \
            && sudo apt-get -o Dpkg::Options::=\"--force-confnew\" upgrade -qqy" \
        "APT (upgrade)"

}


main "$@"
