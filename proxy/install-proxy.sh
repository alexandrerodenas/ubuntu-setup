if [ -z ${PROXY_BACKUP_LOCATION+x} ]; then echo "proxy backup location is unset" && exit 0; else echo "Proxy backup location is set to '$PROXY_BACKUP_LOCATION'"; fi
if [ -z ${PROXY_BASENAME+x} ]; then echo "proxy basename is unset" && exit 0; else echo "Proxy basename is set to '$PROXY_BASENAME'"; fi
if [ -z ${PROXY_PORT+x} ]; then echo "proxy port is unset" && exit 0; else echo "Proxy port is set to '$PROXY_PORT'"; fi
if [ -z ${PROXY_WHITELIST+x} ]; then echo "proxy whitelist is unset" && exit 0; else echo "Proxy whitelist is set to '$PROXY_WHITELIST'"; fi
if [ -z ${PROXY+x} ]; then echo "proxy full name is unset" && exit 0; else echo "Proxy full name is set to '$PROXY'"; fi

echo "Creating tree hierarchy for proxy files..."
# APT
mkdir -p $PROXY_BACKUP_LOCATION/etc/apt/apt.conf.d
# Global
mkdir -p $PROXY_BACKUP_LOCATION/etc
# Docker
mkdir -p $PROXY_BACKUP_LOCATION/etc/systemd/system/docker.service.d
mkdir -p $PROXY_BACKUP_LOCATION/home/.docker
# Maven
mkdir -p $PROXY_BACKUP_LOCATION/home/.m2

echo "Templating..."
envsubst < templates/etc/apt/apt.conf.d/05proxy.template > ${PROXY_BACKUP_LOCATION}/etc/apt/apt.conf.d/05proxy.bak
envsubst < templates/etc/environment.template > ${PROXY_BACKUP_LOCATION}/etc/environment-proxy-block
envsubst < templates/docker/config.json.template > ${PROXY_BACKUP_LOCATION}/home/.docker/config.json.bak
envsubst < templates/docker/http-proxy.conf.template > ${PROXY_BACKUP_LOCATION}/etc/systemd/system/docker.service.d/http-proxy.conf.bak
envsubst < templates/maven/settings.xml.template > ${PROXY_BACKUP_LOCATION}/home/.m2/settings.xml.bak

export PROXY_BLOCK_START="# Proxy block start -- Do not delete those lines"

if ! grep -q "$PROXY_BLOCK_START" ~/.bashrc; then
  echo "Adding proxy scripts in bashrc"
  echo "${PROXY_BLOCK_START}" >> ~/.bashrc
  envsubst < proxy-functions.sh >> ~/.bashrc
  source ~/.bashrc
fi
