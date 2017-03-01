#!/bin/bash
pushd .

if [[ -z $PROXY_HOST ]]; then
		printf "Acquire::http::Proxy \"http://$PROXY_UNAME:$PROXY_PASSWORD@L02PIPROXY01.corp.local:80\";" > /etc/apt/apt.conf.d/00DogeProxy
fi

apt-get update
apt-get install -y libc6-i386

if [[ ! -f '/tmp/jdk/jdk-8u121-linux-i586.tar.gz' ]]; then
    cd /tmp/jdk
    apt-get install -y curl
    curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-i586.tar.gz"
fi

cd /usr/local/lib/
tar xvzf '/tmp/jdk/jdk-8u121-linux-i586.tar.gz'

ln -s $PWD/jdk1.8.0_121 /usr/local/lib/java

printf "\
export JAVA_HOME=/usr/local/lib/java
export JDK_HOME=\$JAVA_HOME
export JRE_HOME=\$JAVA_HOME/jre
export CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib
export PATH=\$PATH:\$JAVA_HOME/bin
" >> ~/.bashrc

popd
