#!/bin/bash
echo Deploying to k8s "${PARAM_CLUSTER_NAME}" cluster
if [ "${PARAM_CLUSTER_NAME}" = "pl-stage" ]
then
  echo 'export KUBE_AWS_REGION="us-east-1"' >> $BASH_ENV
else
  echo 'export KUBE_AWS_REGION="eu-central-1"' >> $BASH_ENV
fi
echo 'export ARTIFACT_VERSION="${PARAM_GIT_SHA1}"' >> $BASH_ENV