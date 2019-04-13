#!/usr/bin/env bash

function usage {
    echo "./dwbh.sh [build|usage|remove]"
}

function remove {
    docker rmi -f kaleidos-docker-registry.bintray.io/dwbh/dwbh:latest
}

function build {
    docker build -t kaleidos-docker-registry.bintray.io/dwbh/dwbh:latest .
}

case $1 in
    build)
        build
        ;;
    remove)
        remove
        ;;
    *)
        usage
        ;;
esac
