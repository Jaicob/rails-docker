FROM jaicob/rails:base
MAINTAINER jaicob(jaicob@icloud.com)
USER rails

# Install basics
RUN \
	sudo apt-get update -qq \
 && sudo apt-get install -y build-essential vim

# for postgres
RUN sudo apt-get install -y libpq-dev

# Install Nginx.
RUN \
  sudo add-apt-repository -y ppa:nginx/stable && \
  sudo apt-get update && \
  sudo apt-get install -y nginx && \
  sudo chown -R www-data:www-data /var/lib/nginx

#configure nginx
ADD nginx-app-site.conf /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/nginx.conf

# for nokogiri
RUN sudo apt-get install -y libxml2-dev libxslt1-dev

# install app source
RUN mkdir /home/rails/app
ADD . /home/rails/app
WORKDIR /home/rails/app
RUN sudo chown -R rails /home/rails/app

# install gems with binstubs 
RUN \
	bundle update \
 &&	bundle install \
 &&	bundle binstubs unicorn \
 &&	bundle binstubs rake \
 &&	rbenv rehash \
 && RAILS_ENV=production bundle exec rake assets:precompile --trace

# Add unicorn config here 
ADD unicorn.rb /etc/app/unicorn.rb
ADD unicorn_init.sh /etc/init.d/unicorn

#Add Run script
ADD app_entrypoint.sh /etc/app/app_entrypoint.sh

# Set environment variables
ENV RAILS_ENV production
EXPOSE 80

CMD /etc/app/app_entrypoint.sh


