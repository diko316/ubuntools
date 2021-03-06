#!/bin/sh

if [ "${DOCKER_FILE_EXISTS}" != "true" ]; then
    echo "! Dockerfile do no exist in this directory." >&2
    exit 21;
fi

######################
# destroy containers
######################
CONTAINERS=$(docker ps -a -q -f name=${REF_NAME})
if [ "${CONTAINERS}" ]; then
    container stop ${REF_NAME}
fi

######################
# destroy images
######################
IMAGES=$(docker images -q ${REF_NAME})
if [ "${IMAGES}" ]; then
    echo "* Destroying image..."
    if ! docker rmi $(docker images -q ${REF_NAME}); then
        echo "! Unable to destroy image ${REF_NAME}" >&2
        exit 31
    fi
fi
exit 0
