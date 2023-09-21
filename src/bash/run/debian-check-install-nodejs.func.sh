#!/bin/bash
do_debian_check_install_nodejs(){


   sudo apt update
   sudo apt install nodejs npm -y

   command -v yarn || {
      sudo npm install -g yarn -y
   }

    echo -e "\nnode version: $(node --version)"
    echo -e "\nnpm version: $(npm --version)"
    echo -e "\nyarn version: $(yarn --version)\n"

   export exit_code="0"
}