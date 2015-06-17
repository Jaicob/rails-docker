FROM jaicob/rails:base
MAINTAINER jaicob(jaicob@icloud.com)
USER rails

RUN \
	sudo apt-get update -qq 
 && sudo apt-get install -y build-essential vim

# for postgres
RUN sudo apt-get install -y libpq-dev

# Install Nginx.
RUN \
  sudo add-apt-repository -y ppa:nginx/stable && \
  sudo apt-get update && \
  sudo apt-get install -y nginx && \
  #rm -rf /var/lib/apt/lists/* && \
  chown -R www-data:www-data /var/lib/nginx

#configure nginx
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

# for nokogiri
RUN sudo apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
#RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

#RUN RAILS_ENV=production bundle exec rake assets:precompile --trace

#ENV RAILS_ENV production


