#!/bin/bash
FLAKE_DOCKER_IMAGE_NAME=$(eval echo "$PARAM_FLAKE_DOCKER_IMAGE_NAME")

nix build .#${FLAKE_DOCKER_IMAGE_NAME}
EXIT_CODE=$?

set -e

# TODO figure out if we still need this crap
if [ $EXIT_CODE -neq 0 ]
then
  echo "double build!"
  sudo chmod -R 777 /nix/store/$(ls /nix/store/ | grep crates-io | grep -v '.drv$')
  nix build .#${FLAKE_DOCKER_IMAGE_NAME}
fi

docker load < result 
docker tag ${FLAKE_DOCKER_IMAGE_NAME}:latest ${AWS_ECR_ACCOUNT_URL}/${FLAKE_DOCKER_IMAGE_NAME}:latest
docker push ${AWS_ECR_ACCOUNT_URL}/${FLAKE_DOCKER_IMAGE_NAME}:latest
docker tag ${FLAKE_DOCKER_IMAGE_NAME}:latest ${AWS_ECR_ACCOUNT_URL}/${FLAKE_DOCKER_IMAGE_NAME}:0.0.${CIRCLE_BUILD_NUM}
docker push ${AWS_ECR_ACCOUNT_URL}/${FLAKE_DOCKER_IMAGE_NAME}:0.0.${CIRCLE_BUILD_NUM}
docker tag ${FLAKE_DOCKER_IMAGE_NAME}:latest ${AWS_ECR_ACCOUNT_URL}/${FLAKE_DOCKER_IMAGE_NAME}:${CIRCLE_SHA1:0:7}
docker push ${AWS_ECR_ACCOUNT_URL}/${FLAKE_DOCKER_IMAGE_NAME}:${CIRCLE_SHA1:0:7}
