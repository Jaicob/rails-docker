FROM pendragondev/rails
MAINTAINER jordan(jordan@getvitaminc.com)

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

# For nokogiri
RUN sudo apt-get install -y libxml2-dev libxslt1-dev

# Install application source
RUN mkdir /home/rails/my-app
WORKDIR /home/rails/my-app
ONBUILD COPY . /home/rails/my-app
ONBUILD RUN sudo chown -R rails /home/rails/my-app

# Install gems with binstubs
#ONBUILD RUN \
#  rbenv install 2.2.2 && \
#  rbenv global 2.2.2 && \
#  gem install rails

# Configure unicorn
COPY unicorn.rb /etc/my-app/unicorn.rb
COPY unicorn_init.sh /etc/init.d/unicorn

# Add entrypoint script TODO change to say setup
COPY setup.sh /etc/my-app/setup.sh

# Set environment variables
ENV RAILS_ENV development

# Expose port 80
EXPOSE 80



