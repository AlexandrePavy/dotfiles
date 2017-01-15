#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../lib/utils.sh"

install_phpstorm() {
    # Configuration
    PHPSTORM_PATH=~/Apps
    PHPSTORM_VERSION=2016.3.3
    # /Configuration

    PHPSTORM_ARCHIVE_NAME=PhpStorm-${PHPSTORM_VERSION}.tar.gz
    PHPSTORM_URL=https://download-cf.jetbrains.com/webide/${PHPSTORM_ARCHIVE_NAME}

    OLD_VERSION="Unknow"

    if [ ! -e "${PHPSTORM_PATH}/PhpStorm" ]; then

        if [ ! -e "${PHPSTORM_ARCHIVE_NAME}" ]; then
            execute "wget -q ${PHPSTORM_URL} -O ${PHPSTORM_ARCHIVE_NAME}" "Dowloading ${PHPSTORM_URL}" || exit 1
        else
            print_success "Use existing ${PHPSTORM_ARCHIVE_NAME}"
        fi

        REMOTE_SHA256=$(wget -qO - https://download.jetbrains.com/webide/${PHPSTORM_ARCHIVE_NAME}.sha256 | cut -d " " -f1)
        LOCAL_SHA256=$(sha256sum ${PHPSTORM_ARCHIVE_NAME} | cut -d " " -f1)

        if [ "${REMOTE_SHA256}" != "${LOCAL_SHA256}" ]; then
            print_error "Remote checksum is not equal to local checksum. Try to remove ${PHPSTORM_ARCHIVE_NAME}."
            exit 1;
        fi

        rm -rdf /tmp/phpstorm-update
        mkdir /tmp/phpstorm-update
        mkdir -p ${PHPSTORM_PATH}
        
        execute "tar zxf ${PHPSTORM_ARCHIVE_NAME} -C /tmp/phpstorm-update/" "Extracting"
        execute "mv /tmp/phpstorm-update/PhpStorm* ${PHPSTORM_PATH}/PhpStorm" "Installing : ${PHPSTORM_PATH}/PhpStorm"

        echo "2016.3.2" > ~/Apps/PhpStorm/version
        
        ${PHPSTORM_PATH}/PhpStorm/bin/phpstorm.sh

    else
        OLD_VERSION=$(cat ~/Apps/PhpStorm/version)
        print_success "PhpStorm already installed (Version: ${OLD_VERSION})"
    fi

}

main() {
    print_in_purple "• Install PhpStorm ${PHPSTORM_VERSION} \n"


    install_phpstorm
}

main
