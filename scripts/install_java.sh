#!/bin/bash -eu

pushd .

if [[ ! -z $PROXY_HOST ]]; then
    export http_proxy="http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT"
    echo "Acquire::http::Proxy \"http://$PROXY_UNAME:$PROXY_PASSWORD@$PROXY_HOST:$PROXY_PORT\";" \
        > /etc/apt/apt.conf.d/00AscenaProxy
else
    printf 'Continuing without proxy...\n'
fi

apt-get update
apt-get install -y libc6-i386

if [[ ! -f '/tmp/downloads/jdk-8u121-linux-i586.tar.gz' ]]; then
    mkdir -p /tmp/downloads
    cd /tmp/downloads
    apt-get install -y curl
    printf 'Downloading Java... (This might take a while)\n'
    curl -s -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k \
        "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-i586.tar.gz"
fi

cd /usr/local/lib/
tar xvzf '/tmp/downloads/jdk-8u121-linux-i586.tar.gz'
ln -s $PWD/jdk1.8.0_121 /usr/local/lib/java

printf "\
export JAVA_HOME=/usr/local/lib/java
export JDK_HOME=\$JAVA_HOME
export JRE_HOME=\$JAVA_HOME/jre
export CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib
export PATH=\$PATH:\$JAVA_HOME/bin
" >> ~/.bashrc

popd
