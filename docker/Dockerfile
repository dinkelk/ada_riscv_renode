#
# $ docker build -t $DOCKER_IMAGE_NAME -f Dockerfile .
#
# For best results use the ./build_image.sh and ./create_container.sh scripts
# provided in this directory.
#
FROM ubuntu:22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# install common dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    software-properties-common \
    apt-utils \
    locales \
    curl \
    lsb-release \
    sudo \
    python3 \
    git \
    build-essential \
    wget \
    ca-certificates \
    netcat \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq clean

# ensure we have the en_US.UTF-8 locale available
RUN locale-gen en_US.UTF-8

# setup the user
ARG DOCKER_USER=user
ENV HOME=/home/$DOCKER_USER
RUN mkdir -p $HOME \
    && if ! getent passwd $DOCKER_USER; then useradd -d /home/$DOCKER_USER -m -s /bin/bash $DOCKER_USER; fi \
    && echo $DOCKER_USER:$DOCKER_USER | chpasswd \
    && echo "$DOCKER_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && mkdir -p /etc/sudoers.d \
    && echo "$DOCKER_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$DOCKER_USER \
    && chmod 0440 /etc/sudoers.d/$DOCKER_USER \
    && chown -R $DOCKER_USER:$DOCKER_USER $HOME

RUN rm /etc/apt/apt.conf.d/docker-clean

# Install Alire:
FROM base AS install_alire
ENV ALIRE_VERSION="1.2.2"
ENV ALIRE_FILE=alr-$ALIRE_VERSION-bin-x86_64-linux.zip
ENV ALIRE_URL=https://github.com/alire-project/alire/releases/download/v$ALIRE_VERSION/$ALIRE_FILE
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq wget unzip \
    && mkdir -p /root/alire \
    && cd /root/alire \
    && wget $ALIRE_URL \
    && rm -rf bin \
    && unzip $ALIRE_FILE

# Construct the final image from the multi-step build images above:
FROM base AS final
LABEL org.opencontainers.image.source=https://github.com/dinkelk/ada-riscv-renode
LABEL org.opencontainers.image.description="Examples running Ada on a Renode emulated RISC-V core"
LABEL org.opencontainers.image.licenses=MIT
USER root
ENV BIN_DIR=/usr/local/bin
COPY --from=install_alire /root/alire/bin/alr $BIN_DIR
RUN cp /root/.bashrc $HOME/.bashrc \
    && echo "cd $HOME" >> $HOME/.bashrc \
    && chown -R $DOCKER_USER:$DOCKER_USER $HOME

# Install Renode
# Copied from https://github.com/renode/renode-docker/blob/master/Dockerfile
USER root
ARG RENODE_VERSION=1.14.0
RUN wget https://github.com/renode/renode/releases/download/v${RENODE_VERSION}/renode_${RENODE_VERSION}_amd64.deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends ./renode_${RENODE_VERSION}_amd64.deb python3-dev && \
    rm ./renode_${RENODE_VERSION}_amd64.deb && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install -r /opt/renode/tests/requirements.txt --no-cache-dir

# Make sure user is root at end.
USER root
