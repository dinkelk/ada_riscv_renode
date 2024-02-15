#!/bin/sh -e

DOCKER_CONTAINER_NAME="ada_riscv_renode_container"
DOCKER_IMAGE_NAME="ghcr.io/dinkelk/ada_riscv_renode:latest"
export DOCKER_CONTAINER_NAME
export DOCKER_IMAGE_NAME

# Helper function to print out command as executed:
execute () {
  echo "$ $@"
  eval "$@"
}
