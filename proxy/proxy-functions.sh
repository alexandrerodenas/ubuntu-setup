# Set proxy
function setProxy() {
    export HTTP_PROXY=${PROXY}
    export HTTPS_PROXY=${PROXY}
    export http_proxy=${PROXY}
    export https_proxy=${PROXY}
    sudo cp ${PROXY_BACKUP_LOCATION}/etc/apt/apt.conf.d/05proxy.bak /etc/apt/apt.conf.d/05proxy
    sudo cp ${PROXY_BACKUP_LOCATION}/etc/systemd/system/docker.service.d/http-proxy.conf.bak /etc/systemd/system/docker.service.d/http-proxy.conf
    cp ${PROXY_BACKUP_LOCATION}/home/.docker/config.json.bak  ~/.docker/config.json
    cp ${PROXY_BACKUP_LOCATION}/home/.m2/settings.xml.bak ~/.m2/settings.xml
    sudo sh -c "cat ${PROXY_BACKUP_LOCATION}/etc/environment-proxy-block >> /etc/environment"

    npm config set proxy "${PROXY}"

    sudo systemctl daemon-reload
    sudo systemctl restart docker
}

# Unset proxy
function unsetProxy() {
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset http_proxy
    unset https_proxy
    sudo rm /etc/apt/apt.conf.d/05proxy
    sudo rm /etc/systemd/system/docker.service.d/http-proxy.conf
    rm ~/.docker/config.json
    rm ~/.m2/settings.xml
    sudo sh -c "sed -i.bak \"/Proxy block start/,/Proxy block end/d\" /etc/environment"
    npm config delete proxy
    npm cache clean --force

    sudo systemctl daemon-reload
    sudo systemctl restart docker
}
