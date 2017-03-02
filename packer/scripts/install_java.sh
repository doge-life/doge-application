#!/bin/bash -eu

JAVA_INSTALL_LOCATION="$HOME/java_install"

function configure_proxy() {
    if [[ ! -z $PROXY_HOST ]]; then
        export http_proxy="http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT"
        echo "Acquire::http::Proxy \"http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT\";" \
            > /etc/apt/apt.conf.d/00AscenaProxy
    else
        printf 'PROXY_HOST does not seem to have been set...\n'
        printf 'If a proxy is needed, please set these environment variables:\n'
        printf 'ASCENA_PROXY_HOST\n'
        printf 'ASCENA_PROXY_PORT\n'
        printf 'ASCENA_PROXY_UNAME\n'
        printf 'ASCENA_PROXY_PASSWORD\n'
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

function bashrc() {
    printf "$@" >> $HOME/.bashrc
}

function install_java() {
    mkdir -p $JAVA_INSTALL_LOCATION
    cd $JAVA_INSTALL_LOCATION
    tar xvzf '/tmp/downloads/jdk-8u121-linux-x64.tar.gz'
    ln -s $PWD/jdk1.8.0_121 $JAVA_INSTALL_LOCATION/jdk

    bashrc "export JAVA_HOME=$JAVA_INSTALL_LOCATION/jdk\n"
    bashrc "export JDK_HOME=\$JAVA_HOME\n"
    bashrc "export JRE_HOME=\$JAVA_HOME/jre\n"
    bashrc "export CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib\n"
    bashrc "export PATH=\$PATH:\$JAVA_HOME/bin\n"
    bashrc "\n"
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

