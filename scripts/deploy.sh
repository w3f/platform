#!/bin/sh
set -e

cd ./modules/${DEPLOYMENT}

if [ "${DEPLOYMENT}" = development ] || [ "${DEPLOYMENT}" = playground ] || [ "${DEPLOYMENT}" = engineering ]; then
    echo -n "${GOOGLE_APPLICATION_CREDENTIALS_CONTENT}" > credentials.json
    export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/credentials.json"

    terraform init

    terraform apply -auto-approve
else
    terraform init \
              -backend-config="access_key=$SPACES_ACCESS_TOKEN" \
              -backend-config="secret_key=$SPACES_SECRET_KEY" \
              -backend-config="bucket=$SPACES_BUCKET_NAME" \
              -backend-config="endpoint=$SPACES_ENDPOINT"

    terraform apply -auto-approve

    terraform output kubeconfig &> kubeconfig.yaml
    export KUBECONFIG=$(pwd)/kubeconfig.yaml

    if [ ! $(kubectl get sa -n kube-system | grep tiller) ]; then
        kubectl -n kube-system create sa tiller
    fi

    if [ ! $(kubectl get clusterrolebinding | grep tiller) ]; then
        kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
    fi
    helm init --service-account tiller --history-max=5

    helm upgrade --install --namespace kube-system -f metrics-server-values.yaml metrics stable/metrics-server
fi
