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

function add_to_profile() {
    printf "$@" >> $HOME/.bashrc
    source ~/.bashrc
}

function install_java() {
    mkdir -p $JAVA_INSTALL_LOCATION
    cd $JAVA_INSTALL_LOCATION
    tar xvzf '/tmp/downloads/jdk-8u121-linux-x64.tar.gz'
    ln -s $PWD/jdk1.8.0_121 $JAVA_INSTALL_LOCATION/jdk

    add_to_profile "# Java Exports\n"
    add_to_profile "export JAVA_HOME=$JAVA_INSTALL_LOCATION/jdk\n"
    add_to_profile "export JDK_HOME=\$JAVA_HOME\n"
    add_to_profile "export JRE_HOME=\$JAVA_HOME/jre\n"
    add_to_profile "export CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib\n"
    add_to_profile "export PATH=\$PATH:\$JAVA_HOME/bin\n"
    add_to_profile "\n"
}

function main() {
    pushd .

    if [[ ! -f '/tmp/downloads/jdk-8u121-linux-x64.tar.gz' ]]; then
        download_java
    fi

    install_java

    popd
}

main "$@"

