# Pull base image.
FROM ubuntu:14.04
MAINTAINER jaicob(jaicob@icloud.com)

# Install basics.
RUN \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y software-properties-common && \
    apt-get install -y byobu curl git htop man unzip vim wget && \
    apt-get install -y libffi-dev && \
    rm -rf /var/lib/apt/lists/* 

# Install some dependencies
RUN apt-get update
RUN apt-get install -y  build-essential \
                        curl \
                        git-core \
                        imagemagick \
                        libssl-dev \
                        libreadline-dev \
                        libyaml-dev \
                        libsqlite3-dev \
                        libxml2-dev \
                        libxslt1-dev \
                        libcurl4-openssl-dev \
                        libqt4-dev \
                        libxml2-dev \
                        libxslt1-dev \
                        libmagickcore-dev \
                        libmagickwand-dev \
                        python-software-properties \
                        sqlite3 \
                        zlib1g-dev 


# Add a non-root user with sudo abilities
RUN \
    echo 'rails ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    groupadd rails && \
    useradd rails -m -g rails -g sudo

# Swich to user, Rails
USER rails

# Install rbenv as rails 
RUN \
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"' | tee -a ~/.bashrc ~/.profile && \
    echo 'eval "$(rbenv init -)"' | tee -a ~/.bashrc ~/.profile && \
    echo 'export PATH="$HOME/.rbenv/bin:/usr/bin:/bin:$PATH"' | tee -a ~/.bashrc ~/.profile

# Install rbenv plugin: ruby-build for rails rbenv installation
RUN \
    mkdir ~/.rbenv/plugins && \
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' | tee -a ~/.bashrc ~/.profile 

# Do not copy gem package documentation
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

# Restart shell
RUN . ~/.bashrc

# Set Env path for Rbenv
ENV RBENV_ROOT /home/rails/.rbenv 
ENV PATH $RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.rbenv/bin:/usr/bin:/bin:$PATH

# Install ruby
RUN rbenv install 2.2.0
RUN rbenv global 2.2.0

# Install bundler
RUN gem install bundler
RUN rbenv rehash

# Install Rails dependencies
RUN \
    sudo apt-get install -y software-properties-common && \
    sudo add-apt-repository ppa:chris-lea/node.js && \
    sudo apt-get update && \
    sudo apt-get install -y nodejs 
  
# Install Rails
RUN gem install rails --version=4.2.1
RUN rbenv rehash
