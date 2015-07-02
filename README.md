# rails-docker
Everything you need to start developing and deploying your rails apps with Docker.

This repo exists to facilitate the process of setting up your project to develop and deploy using docker. Currently the project assumes you are using Rails 4.2.1, Ruby 2.2.0, Postgres, Unicorn and Nginx. The Dockerfiles can be modified to change this or it can be requested to add any additional versions/technologies to the project.

Table of Contents
=================
  * [Getting Started](#getting-started)
    * [Windows](#windows)
    * [Mac OS X](#mac-os-x)
  * [Development](#development)
    * [Starting and Stopping](#starting-and-stopping-the-application) 
    * [Running one off commands](#running-one-off-commands)
    * [Opening a shell](#opening-a-shell)
    * [Cleaning up](#cleaning-up)
  * [Production](#production)
  * [Configuring](#configuring)
  * [Troubleshooting](#troubleshooting)
  * [Tips & Tricks](#tips--tricks)
  * [Contributing](#contributing)


Getting Started
-----
Docker requires a Linux environment to run, and the folks at Docker have created a lightweight VM called Boot2Docker that runs your Docker commands for you.

####Windows
On Windows systems, visit https://docs.docker.com/windows/started/ to get started with download and installation.

####Mac OS X
On Mac OS X (10.6 or later), visit https://docs.docker.com/mac/started/ to get started with download and installation.

Additionally, on Mac OS X with zsh, you can run the setup script below which does the following. This assumes you have virtual box already. You can modify the script to have the alias written to wherever you like to keep your aliases.
- Installs/starts boot2docker
- Installs Docker
- Installs docker-compose
- Adds some convenient aliases

`sh -c "$(curl -fsSL https://raw.github.com/jaicob/rails-docker/master/setup_docker_osx.sh)"`


Development
-----
For development I find it most convenient to use docker-compose to spin up my working environment. The example docker-compose.yml found in the repo provides a basic setup that links your application to a postgres container.

In order to get started using docker-compose with your project you must provide your own docker-compose.yml file. Documentation on how to write that can be found [here](https://docs.docker.com/compose/)
Once in your directory run the following command to setup your project initially.

####Starting and stopping the application
To build your container and start running it use the command below. 

`docker-compose up`
Or simply `dc up` if you are using the aliases supplied above

After that simply use the commands below to start and stop the container you built using the command above.

`docker-compose stop` and `docker-compose-start` to start and stop your project

Docker allows you to mount volumes so this means that changes you make on your local machine will also be reflected in your docker container and vis versa if you so specify. This was shown in the example [docker-compose.yml](https://github.com/Jaicob/rails-docker/blob/master/docker-compose.yml) 

####Running one off commands 

In order to run just one command on a container you use the `docker-compose run` command. The table below shows examples of what some common commands would look like.

| Regular command                |  Docker-compose command                                    |
|------------------------------- |:----------------------------------------------------------:|
| `bundle install`               |  `docker-compose run web bundle install`                   |
| `rails s`                      |  `docker-compose run web rails s`                          |
| `rspec spec/path/to/spec.rb`   |  `docker-compose run web rspec spec/path/to/spec.rb`       |
| `RAILS_ENV=test rake db:create`|  `docker-compose run -e RAILS_ENV=test web rake db:create` |
| `tail -f log/development.log`  |  `docker-compose run web tail -f log/development.log`      |  

####Opening a shell 

Sometimes you may want to do more than just run a one off command. In these cases, it is also possible for you to open a shell within your running container. There are several ways to accomplish this.

######With docker-compose
`docker-compose run web /bin/bash`

Note: you can repalce "web" with whatever docker-compose task names you have in your docker-compose.yml 

######With just docker
`docker exec -it [NAME OR ID OF CONTAINER] /bin/bash`

####Cleaning up
During development it is not uncommon for many untagged images to accrue and stopped containers to linger around. This can start to take up a significant amount of memory. I find it useful to run the following commands from time to time to help combat this. 

`docker rmi $(docker images | grep "<none>" | awk '{print($3)}')`

`docker ps -a | cut -c-12 | xargs docker rm`

These get rid of the above mentioned images and containers respectively. 


Production
----
Everyone's hosting for production varies, but using this setup you should be able to simply run your dockerized application wherever you plan on hosting your application, so long as it is able to run docker. Nginx and unicorn are run using supervisor which you can also easily configure yourself.


Configuring
----
Within the [example dockerfile](https://github.com/Jaicob/rails-docker/blob/master/Dockerfile.example) I indicated how you would provide your own configurations for nginx, unicorn and your own setup scripts. When you're writing you would include these lines for your own configs.

#####Unicorn 
```
# Place custom unicorn configs here
ADD config/unicorn.rb /etc/my-app/config/unicorn.rb				
ADD unicorn_init.sh /etc/init.d/unicorn
```

#####Nginx 
```
# Place custom nginx configs here
COPY nginx-app-site.conf /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/nginx.conf
```
#####Supervisor 
```
# Configure supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
```

#####Custom setup script
```
# Add custom setup script here, this is run just before starting the services
COPY setup.sh /etc/my-app/setup.sh
```


Troubleshooting
----

#####Weird unwarranted network issues
- First line of defense is to simply turn it off then on again. Boot2docker can be wonky sometimes so when I get strange network errors the following commands are used to restart it. I would recommend aliasing this.

```
boot2docker stop
boot2docker start
boot2docker shellinit
```

- Next up, it may be an issue with Boot2docker concerning certificate validation in version 1.7.0. You can find the issue [here](https://github.com/boot2docker/boot2docker/issues/938) and a proposed fix [here](https://gist.github.com/garthk/d5a17007c277aa5c76de).


Tips & Tricks
----
- After using `Docker run` you can simply start that container again using `Docker start [CONTAINER]` this saves you disk space since each time you use the `Docker Run` command it creates a new container


Contributing
-----
If you find areas in need of improvement please do not hesitate to submit an issue or pull-request. We are also currently working out a system to have different version of rails, ruby etc. 




