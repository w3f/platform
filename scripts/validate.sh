#!/bin/sh
set -e

cd ./modules/${DEPLOYMENT}

case "${DEPLOYMENT}" in
    w3f|community)
        terraform init -backend-config="access_key=$SPACES_ACCESS_TOKEN" \
                  -backend-config="secret_key=$SPACES_SECRET_KEY" \
                  -backend-config="bucket=$SPACES_BUCKET_NAME" \
                  -backend-config="endpoint=$SPACES_ENDPOINT"
        ;;
    china)
        terraform init
        ;;
    *)
        echo -n "${GOOGLE_APPLICATION_CREDENTIALS_CONTENT}" > credentials.json
        export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/credentials.json"
        terraform init
        ;;
esac

terraform validate
terraform plan
