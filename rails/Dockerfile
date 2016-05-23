# Pull base image.
FROM ubuntu:14.04
MAINTAINER jaicob(jaicob@icloud.com)

# Install add non root user, install basics and dependencies
RUN \
    echo 'rails ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    groupadd rails && \
    useradd rails -m -g rails -g sudo && \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y software-properties-common && \
    apt-get install -y byobu curl git htop man unzip vim wget && \
    apt-get install -y libffi-dev && \
    rm -rf /var/lib/apt/lists/*  && \
    apt-add-repository ppa:ubuntu-sdk-team/ppa && sudo apt-get update && \
    apt-get install -y  build-essential \
                        curl \
                        git-core \
                        imagemagick \
                        libssl-dev \
                        libsqlite3-dev \
                        python-software-properties \
                        sqlite3 \
                        qt5-default \
                        libqt5webkit5-dev \
                        qtdeclarative5-dev \
                        g++

# Swich to user, Rails
USER rails

# Install rbenv as rails and install rbenv plugin: ruby-build for rails rbenv installation
RUN \
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"' | tee -a ~/.bashrc ~/.profile && \
    echo 'eval "$(rbenv init -)"' | tee -a ~/.bashrc ~/.profile && \
    echo 'export PATH="$HOME/.rbenv/bin:/usr/bin:/bin:$PATH"' | tee -a ~/.bashrc ~/.profile && \
    mkdir ~/.rbenv/plugins && \
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' | tee -a ~/.bashrc ~/.profile && \
    echo "gem: --no-ri --no-rdoc" > ~/.gemrc && \
     . ~/.bashrc

# Set Env path for Rbenv
ENV RBENV_ROOT /home/rails/.rbenv 
ENV PATH $RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.rbenv/bin:/usr/bin:/bin:$PATH

# Install ruby
RUN \
    rbenv install 2.2.0 && \
    rbenv global 2.2.0 && \
    gem install bundler && \
    rbenv rehash && \
    sudo add-apt-repository ppa:chris-lea/node.js && \
    sudo apt-get update && \
    sudo apt-get install -y nodejs && \
    gem install rails --version=4.2.1 && \
    rbenv rehash
