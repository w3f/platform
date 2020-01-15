#!/bin/sh
set -xe

cd ./modules/${DEPLOYMENT}

if [ "${DEPLOYMENT}" = development ] || [ "${DEPLOYMENT}" = development-runners ] || [ "${DEPLOYMENT}" = engineering ]; then
    echo "${GOOGLE_APPLICATION_CREDENTIALS_CONTENT}" | tee credentials.json
    export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/credentials.json"
fi

terraform init
terraform validate
terraform plan
