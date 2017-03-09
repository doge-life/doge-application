#!/bin/bash -e

pushd `dirname "$0"` 

help() {
    echo "Usage: deploy.sh <environment> <ami name>"
    exit 0
}

case "$1" in
    "--help"|"-h"|"" ) help;;
esac

if [ $# -ne 2 ]
then
    help
fi

APP_ENVIRONMENT=$1
AMI_NAME=$2

./providers/aws/us_east_1_$APP_ENVIRONMENT/plan $AMI_NAME
./providers/aws/us_east_1_$APP_ENVIRONMENT/apply $AMI_NAME

popd
