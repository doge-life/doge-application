#!/bin/bash

if [[ $# -eq 2 ]] ; then
    echo "Usage: [NEXUS_USER, NEXUS_PW, NEXUS_REGISTRY_URL]"
    exit 1;
fi

user=$1
pw=$2
NEXUS_REGISTRY_URL=$3
version=${4:-$(cat VERSION)}

docker login -u ${user} -p ${pw} ${NEXUS_REGISTRY_URL}
docker tag doge-life/doge-application:latest ${NEXUS_REGISTRY_URL}/doge-life/doge-application:${version}
docker push ${NEXUS_REGISTRY_URL}/doge-life/doge-application:${version}
