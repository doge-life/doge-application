#!/bin/bash -eu

function configure_proxy() {
    if [[ ! -z $PROXY_HOST ]]; then
        export http_proxy="http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT"
        echo "Acquire::http::Proxy \"http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT\";" \
            > /etc/apt/apt.conf.d/00DogeProxy
    else
        printf 'PROXY_HOST does not seem to have been set...\n'
        printf 'If a proxy is needed, please set these environment variables:\n'
        printf '    DOGE_PROXY_HOST\n'
        printf '    DOGE_PROXY_PORT\n'
        printf '    DOGE_PROXY_UNAME\n'
        printf '    DOGE_PROXY_PASSWORD\n'
        printf 'Continuing without proxy...\n'
    fi
}

function download_java() {
    mkdir -p /tmp/downloads
    cd /tmp/downloads
    apt-get update
    apt-get install -y curl
    printf 'Downloading Java... (This might take a while)\n'
    curl -s -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k \
        "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz"
}

function install_java() {
    cd /usr/local/lib/
    tar xvzf '/tmp/downloads/jdk-8u121-linux-x64.tar.gz'
    ln -s $PWD/jdk1.8.0_121 /usr/local/lib/java

    printf "\
    export JAVA_HOME=/usr/local/lib/java
    export JDK_HOME=\$JAVA_HOME
    export JRE_HOME=\$JAVA_HOME/jre
    export CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib
    export PATH=\$PATH:\$JAVA_HOME/bin
    " >> ~/.bashrc

}

function main() {
    pushd .

    if [[ ! -f '/tmp/downloads/jdk-8u121-linux-x64.tar.gz' ]]; then
        configure_proxy
        download_java
    fi

    install_java

    popd
}

main "$@"

