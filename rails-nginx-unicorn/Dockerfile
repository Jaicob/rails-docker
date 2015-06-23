FROM jaicob/rails:base
MAINTAINER jaicob(jaicob@icloud.com)

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
COPY nginx-app-site.conf /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/nginx.conf

# for nokogiri
RUN sudo apt-get install -y libxml2-dev libxslt1-dev

# install app source
RUN mkdir /home/rails/my-app
COPY . /home/rails/my-app
WORKDIR /home/rails/my-app
# RUN \
# 	sudo chown -R rails /home/rails/my-app  
# 	#echo 'export SECRET_KEY_BASE=`rake secret`' | tee -a ~/.bashrc ~/.profile  \

# install gems with binstubs 
RUN \
	bundle update \
 &&	bundle install \
 &&	bundle binstubs unicorn \
 &&	bundle binstubs rake \
 &&	rbenv rehash \
 && RAILS_ENV=production bundle exec rake assets:precompile --trace

# Add unicorn config here 
COPY unicorn.rb /etc/my-app/unicorn.rb
COPY unicorn_init.sh /etc/init.d/unicorn

# Add entrypoint script
COPY app_entrypoint.sh /etc/my-app/app_entrypoint.sh

# Set environment variables
ENV RAILS_ENV production

#expose port 80
EXPOSE 80

# Default command to run if none is provided
CMD /etc/my-app/app_entrypoint.sh


