# Proxy Configuration Script

This script automates the setup of a proxy configuration on a Linux system. It creates tree hierarchy for proxy files, templates the configuration files and adds proxy scripts to the bashrc.

## Prerequisites

- Bash shell
- `envsubst` command

## Usage

1. Clone the repository and navigate to the directory:

   ```bash
   git clone https://github.com/example/proxy-config.git
   cd proxy-config
   ```

2. Set the required environment variables:

   ```bash
   export PROXY_BACKUP_LOCATION=/path/to/proxy/backup
   export PROXY_BASENAME=proxy.example.com
   export PROXY_PORT=8080
   export PROXY_WHITELIST=localhost,127.0.0.1
   export PROXY=$PROXY_BASENAME:$PROXY_PORT
   ```

   - `PROXY_BACKUP_LOCATION`: The directory where the backup files will be stored.
    - `PROXY_BASENAME`: The basename of the proxy.
    - `PROXY_PORT`: The port number of the proxy.
    - `PROXY_WHITELIST`: A list of domains to bypass the proxy.
    - `PROXY`: The full URL of the proxy.


   Note: If any of the above environment variables are not set, the script will exit.

3. Run the script:

   ```bash
   ./install-proxy.sh
   ```

   The script will create tree hierarchy for proxy files, template the configuration files and add proxy scripts to the bashrc.

4. Restart the system or reload bashrc:

   ```bash
   source ~/.bashrc
   ```

   Note: If the system is not restarted or bashrc is not reloaded, the proxy configuration may not take effect.


### Setting the Proxy

To set the proxy, run the following command:

```
setProxy
```

This will create a backup of the existing configuration files and replace them with the proxy configuration files. It will also configure `npm` to use the proxy.

### Unsetting the Proxy

To unset the proxy, run the following command:

```
unsetProxy
```

This will remove the proxy configuration files and restore the backup of the original configuration files. It will also unset `npm` proxy settings.


## File Structure

```
.
├── install-proxy.sh # Main script
├── proxy-functions.sh # Proxy functions
├── templates # Configuration templates
│   ├── docker
│   │   ├── config.json.template
│   │   └── http-proxy.conf.template
│   ├── etc
│   │   ├── apt
│   │   │   └── apt.conf.d
│   │   │       └── 05proxy.template
│   │   └── environment.template
│   └── maven
│       └── settings.xml.template
└── README.md # This file
```
