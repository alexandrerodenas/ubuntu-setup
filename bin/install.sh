#!/bin/bash

source helpers
source ../configuration/config


if [ "$kernel_headers_install" = true ]; then
  log "Installation of kernel headers."
  sudo apt install -y linux-headers-$(uname -r)
fi

if [ "$upgrade_package" = true ]; then
  log "Update and upgrade of existing packages."
  sudo apt update && sudo apt upgrade -y
fi

if [ "$basic_software_install" = true ]; then
  log "Installation od following dependencies: $basic_softwares."
  sudo apt install -y $basic_softwares
fi

if [ "$brave_browser_install" = true ]; then
  log "Installation of brave-browser."
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A8580BDC82D3DC6C
  echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update && sudo apt install -y brave-browser
fi

if [ "$sdkman_java_install" = true ]; then
  # Installer SDKMAN
  log "Installation of sdkman."
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  # Installer OpenJDK
  log "Installation of Java."
  sdk install java $java_version
fi

if [ "$nvm_node_install" = true ]; then
  # Install NVM (Node Version Manager)
  log "Installation of NVM."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  source ~/.nvm/nvm.sh
  # Install Node.js
  log "Installation of Node."
  nvm install $node_version
  nvm alias default $node_version
  node -v
fi

if [ "$sublime_text_install" = true ]; then
  echo -e "${GREEN}Installation of sublime-text.${NC}"
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt update && sudo apt install -y sublime-text
fi

if [ "$idea_ultimate_install" = true ]; then
  log "Installation of Intellj IDEA Ultimate."
  sudo snap install intellij-idea-ultimate --classic
fi

if [ "$docker_compose_install" = true ]; then
  log "Installation of Docker Compose."
  sudo apt install -y docker-compose
  sudo newgrp docker <<EONG
  sudo usermod -aG docker $USER
EONG
  log "Stop (or not) ssh and docker services."
  if $docker_service_stop; then
    # Stop Docker service if not running
    if systemctl is-active --quiet docker.service; then
      log "Stopping Docker service..."
      sudo systemctl stop docker.service
    fi
  fi
fi

if [ "$openssh_server_install" = true ]; then
  log "Installation of SSH server."
  sudo apt install -y openssh-server
  if $ssh_service_stop; then
    # Stop SSH service if not running
    if systemctl is-active --quiet ssh.service; then
      log "Stopping SSH service..."
      sudo systemctl stop ssh.service
    fi
  fi
fi

if [ "$spotify_install" = true ]; then
  log "Installation of spotify."
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7A3A762FAFD4A51F
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update && sudo apt-get install -y spotify-client
fi

if [ "$git_install" = true ]; then
  log "Installation of Git."
  sudo apt install -y git
  git config --global user.name "$git_user_name"
  git config --global user.email "$git_email"
  git config --global credential.helper store
  git config --global init.defaultBranch develop
  git config --global alias.st status
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.cp cherry-pick
  git config --global alias.erase 'reset --hard HEAD'
fi

if [ "$maven_install" = true ]; then
  log "Installation of Maven."
  wget -c https://dlcdn.apache.org/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz
  tar xvzf apache-maven-${maven_version}-bin.tar.gz
  rm apache-maven-${maven_version}-bin.tar.gz
  sudo mv apache-maven-${maven_version} /usr/local
  sudo chown -R root:root /usr/local/apache-maven-${maven_version}/
  sudo ln -s /usr/local/apache-maven-${maven_version} /usr/local/maven
  echo 'export PATH="$PATH:/usr/local/maven/bin"' >>~/.bashrc
fi

if [ "$ansible_install" = true ]; then
  log "Installation of Ansible."
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt update
  sudo apt install ansible
fi

if [ "$aliases_install" = true ]; then
  # Define variables
  ALIAS_BLOCK="# Alias block start -- Do not remove or modify this line --"

  # Check if .bashrc_aliases exists and create it if it doesn't
  if [[ ! -f ~/.bash_aliases ]]; then
    touch ~/.bash_aliases
  fi

  # Check if the aliases block exists and add it if it doesn't
  if ! grep -q "$ALIAS_BLOCK" ~/.bash_aliases; then
    log "Adding alias block."
    interpretAndCreateTmp ./home/.bash_aliases
    sudo sh -c 'cat tmp >> ~/.bash_aliases'
    rm tmp
  fi
fi

log "Cleaning..."
sudo apt -y autoremove

source ~/.bashrc ~/.bash_aliases
