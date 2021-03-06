FROM jaicob/rails
MAINTAINER jaicob(jaicob@icloud.com)

# Install basics and postgres
RUN \
	sudo apt-get update -qq && \
    sudo apt-get install -y build-essential vim && \
    sudo apt-get install -y libpq-dev 

# Install supervisor
RUN sudo apt-get install -y supervisor 

# Configure supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install Nginx.
RUN \
	sudo add-apt-repository -y ppa:nginx/stable && \
	sudo apt-get update && \
	sudo apt-get install -y nginx && \
	sudo chown -R www-data:www-data /var/lib/nginx

# Configure nginx
COPY nginx-app-site.conf /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/nginx.conf

# Install application source
RUN mkdir /home/rails/my-app
WORKDIR /home/rails/my-app
ONBUILD COPY . /home/rails/my-app
ONBUILD RUN sudo chown -R rails /home/rails/my-app  

# Configure unicorn
COPY unicorn.rb /etc/my-app/unicorn.rb
COPY unicorn_init.sh /etc/init.d/unicorn

# Add default setup script
COPY setup.sh /etc/my-app/setup.sh

# Set environment variables
ENV RAILS_ENV production
