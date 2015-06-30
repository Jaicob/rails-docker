# rails-docker
Everything you need to start developing and deploying your rails apps with Docker

About
-----
This repo exists to facilitate the process of setting up your project to develop and deploy using docker. Currently the project assumes you are using Rails 4.2.1, Ruby 2.2.0, Postgres, Unicorn and Nginx. The Dockerfiles can be modified to change this or it can be requested to add any additional versions/technologies to the project.

Getting Started
-----

### Windows or Mac OS X:

Docker requires a Linux environment to run, and the folks at Docker have created a lightweight VM called Boot2Docker that runs your Docker commands for you.

On Windows systems, visit https://docs.docker.com/windows/started/ to get started with download and installation.

On Mac OS X (10.6 or later), visit https://docs.docker.com/mac/started/ to get started with download and installation.
Additionally on Mac OS X with zsh, you can run the setup script below which does the following.
- Installs/starts boot2docker
- Installs Docker
- Installs docker-compose
- Adds some convenient aliases
`sh -c "$(curl -fsSL https://raw.github.com/jaicob/rails-docker/master/setup_docker_osx.sh)"`

Development
-----
For development I find it most convenient to use docker-compose to spin up my working environment. The example docker-compose.yml found in the repo provides a basic setup that links your application to a postgres container.

Production
----


Configuring
----

Troubleshooting
----

Tips & Tricks
----
- After using `Docker run` you can simply start that container again using `Docker start [CONTAINER]` this saves you disk space since each time you use the `Docker Run` command it creates a new container

Contributing
-----

In the works
----
- Adding the docker-compose.yml
- Improving documentation


