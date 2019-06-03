#!/bin/sh
set -xe

if [ "${DEPLOYMENT}" = w3f ]; then
    NODE_COUNT=4
else
    NODE_COUNT=3
fi

cd ./modules/${DEPLOYMENT}
terraform init \
          -backend-config="access_key=$SPACES_ACCESS_TOKEN" \
          -backend-config="secret_key=$SPACES_SECRET_KEY" \
          -backend-config="bucket=$SPACES_BUCKET_NAME" \
          -backend-config="endpoint=$SPACES_ENDPOINT"

terraform apply -auto-approve -var node_count=${NODE_COUNT}

terraform output kubeconfig &> kubeconfig.yaml
export KUBECONFIG=$(pwd)/kubeconfig.yaml

helm init --client-only
helm upgrade --install --namespace kube-system -f metrics-server-values.yaml metrics stable/metrics-server
