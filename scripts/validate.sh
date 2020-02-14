#!/bin/sh
set -e

cd ./modules/${DEPLOYMENT}

if [ "${DEPLOYMENT}" = development ] || [ "${DEPLOYMENT}" = playground ] || [ "${DEPLOYMENT}" = engineering ]; then
    echo -n "${GOOGLE_APPLICATION_CREDENTIALS_CONTENT}" > credentials.json
    export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/credentials.json"

    terraform init
else
    terraform init -backend-config="access_key=$SPACES_ACCESS_TOKEN" \
              -backend-config="secret_key=$SPACES_SECRET_KEY" \
              -backend-config="bucket=$SPACES_BUCKET_NAME" \
              -backend-config="endpoint=$SPACES_ENDPOINT"
fi

terraform validate
terraform plan
