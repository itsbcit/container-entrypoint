#!/bin/bash

set -e

RUNUID=1000100000

if [ -z "$1" ];then
    echo ${0} runuser
    exit 1
fi

case "$1" in
    root) DENV="";                DUSER="";                        DWHO="root" ;;
    none) DENV="-e RUNUSER=none"; DUSER="--user ${RUNUID}"; DWHO="" ;;
    *)    DENV="-e RUNUSER=${1}"; DUSER="--user ${RUNUID}"; DWHO=$1 ;;
esac

# Create test harness container
container_name=$(podman run -d ${DENV} ${DUSER} bcit/container-entrypoint:latest /bin/sh -c "tail -f /dev/null")

# Capture username of container runner
container_dwho=$(podman exec ${container_name} whoami || exit 0 )

# Clean up harness container
podman kill $container_name >/dev/null
podman rm $container_name >/dev/null

# Compare container reported user
if [ "$container_dwho" = "$DWHO" ];then
    echo Success
else
    echo 10-resolve-userid.sh failed. Got whoami=\"${container_dwho}\", expecting whoami=\"${DWHO}\"
    exit 1
fi

