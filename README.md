## Shell script to create cozy dev environment

This is a shell script with the purpose of facilitating the installation of common tools and dependencies in Ubuntu. The script can be executed by running the following command: `./start.sh`. It comes along with a script to install proxy and make it toggleable. See [proxy script](./proxy/install-proxy.sh).

### Prerequisites
- Ubuntu
- Root or superuser privileges
- Internet connection

### Usage
To execute the script, navigate to the directory where the script is located and execute the following command:
```
./bin/install.sh
```

### Options
The script provides some options that can be enabled or disabled to perform specific installations. These options are set to `true` by default.
Those options are defined in `./configuration/config`.
The following options are available:

#### Kernel headers
If this option is enabled, the script will install kernel headers.

#### Upgrade packages
If this option is enabled, the script will update and upgrade existing packages.

#### Basic Dependencies
If this option is enabled, the script will install the following dependencies:
- build-essential 
- curl 
- vim 
- snapd 
- apt-transport-https 
- net-tools 
- htop
- pinta
- gimp
- libreoffice

#### Java
If this option is enabled, the script will install:
- SDKMAN
- JAVA (you can give a specific version, default is 20-open)

#### Node
If this option is enabled, the script will install:
- NVM (Node Version Manager)
- Node.js (you can give a specific version, default is 20)

#### Maven
If this option is enabled, the script will install:
- Maven (you can give a specific version, default is 3.9.1)

#### Git
If this option is enabled, the script will install:
- Git
- Configure user.name and user.email
- Widely spread aliases

#### IntelliJ IDEA Ultimate
If this option is enabled, the script will install:
- IntelliJ IDEA Ultimate

#### SSH server
If this option is enabled, the script will install:
- OpenSSH server
- Stop (or not) the SSH service if it is running

#### Docker
If this option is enabled, the script will install:
- Docker Compose
- Stop (or not) the Docker service if it is running

#### Ansible
If this option is enabled, the script will install Ansible.

#### Brave browser
If this option is enabled, the script will install Brave browser.

#### Sublime Text
If this option is enabled, the script will install Sublime Text.

#### Spotify
If this option is enabled, the script will install Spotify.

