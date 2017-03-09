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
AMI_ID=$2

case "$APP_ENVIRONMENT" in
    "dev"|"prod" ) ;;
    * ) echo "environment must be either \"dev\" or \"prod\"" && exit 1;;
esac

pushd "providers/aws/us_east_1_$APP_ENVIRONMENT"
terraform remote config \
    -backend=S3 \
    -backend-config="bucket=doge-application" \
    -backend-config="key=terraform/${APP_ENVIRONMENT}-env-terraform.tfstate" \
    -backend-config="region=us-east-1"

terraform plan -var ami_id=$AMI_ID
terraform apply -var ami_id=$AMI_ID
popd

popd

