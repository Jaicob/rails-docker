FROM jaicob/rails:test
MAINTAINER jaicob(jaicob@icloud.com)

# Install basics, postgres, supervisor, nginx
RUN \
	sudo apt-get update -qq && \
    sudo apt-get install -y build-essential vim && \
    sudo apt-get install -y libpq-dev && \
	sudo apt-get install -y supervisor && \
	sudo add-apt-repository -y ppa:nginx/stable && \
	sudo apt-get update && \
	sudo apt-get install -y nginx && \
	sudo chown -R www-data:www-data /var/lib/nginx && \
	gem install bundler 

# Default configs for supervisor, nginx, unicorn, setup
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx-app-site.conf /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/nginx.conf
COPY unicorn.rb /etc/my-app/unicorn.rb
COPY unicorn_init.sh /etc/init.d/unicorn
COPY setup.sh /etc/my-app/setup.sh

# Set environment variables
ENV RAILS_ENV production
