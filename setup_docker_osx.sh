#!/bin/sh
brew update
brew install boot2docker
boot2docker init
boot2docker up
brew install docker
docker version


# Some handy aliases, if not using zsh just modify where they are echoed to

# Shortcut for docker-compose
echo 'alias dc='\''docker-compose'\''' >> ~/.zshrc
# Clean docker containers
echo 'alias docker-clean-c='\''docker ps -a | cut -c-12 | xargs docker rm'\''' >> ~/.zshrc
# Clean untagged images
echo 'alias docker-clean-i='\''docker rmi $(docker images | grep "<none>" | awk '\''\'\'''\''{print($3)}'\''\'\'''\'')'\''' >> ~/.zshrc
# Command for docker/boot2docker
echo 'eval '\''$(boot2docker shellinit)'\''' >> ~/.zshrc
# Reset boot2docker when it acts weird
echo 'alias fix-b2d='\''boot2docker stop && boot2docker start && exec zsh'\''' >> ~/.zshrc
# Add boot2docker ip to etc/hosts
echo 'Adding boot2docker ip to /etc/hosts as Dockerhost'
# Add Dockerhost to /etc/hosts
echo "$(boot2docker ip 2)" " Dockerhost" | sudo tee -a /etc/hosts
