#!/bin/sh
set -xe

NODE_COUNT=3

cd ./modules/k8s
terraform init \
          -backend-config="access_key=$SPACES_ACCESS_TOKEN" \
          -backend-config="secret_key=$SPACES_SECRET_KEY" \
          -backend-config="bucket=$SPACES_BUCKET_NAME" \
          -backend-config="endpoint=$SPACES_ENDPOINT"

terraform apply -auto-approve -var node_count=${NODE_COUNT}

terraform output kubeconfig &> kubeconfig.yaml
export KUBECONFIG=$(pwd)/kubeconfig.yaml

helm init --client-only
helm upgrade --install --name metrics stable/metrics-server --namespace kube-system -f metrics-server-values.yaml
