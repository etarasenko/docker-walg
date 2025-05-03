#!/bin/sh
set -e

VERSION=$1
BUILD_OPTS=$2

IMAGE=docker.io/etarasenko/walg

if [ "$VERSION" = "latest" ]; then
    ALPINE_TAG=alpine
    DEBIAN_TAG=latest
    GIT_VERSION=master
else
    ALPINE_TAG=$VERSION-alpine
    DEBIAN_TAG=$VERSION
    GIT_VERSION=v$VERSION
fi

docker build \
    --build-arg GIT_VERSION=$GIT_VERSION \
    --file Dockerfile.alpine \
    --pull \
    --tag $IMAGE:$ALPINE_TAG \
    $BUILD_OPTS \
    .

docker build \
    --build-arg GIT_VERSION=$GIT_VERSION \
    --file Dockerfile.debian \
    --pull \
    --tag $IMAGE:$DEBIAN_TAG \
    $BUILD_OPTS \
    .
