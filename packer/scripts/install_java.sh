#!/bin/bash -eu

JAVA_INSTALL_LOCATION="$HOME/java_install"

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
        download_java
    fi

    install_java

    popd
}

function as_root() {
    if [[ $EUID != 0 ]]; then
        sudo "$@"
    else
        "$@"
    fi
}

as_root main "$@"
