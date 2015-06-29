RAILS_ENV=$RAILS_ENV
: ${RAILS_ENV:="development"}
export RAILS_ENV

SECRET_KEY_BASE=$SECRET_KEY_BASE
: ${SECRET_KEY_BASE:="f38c575fcf0b2a0e7c7f002a873d54d78104581ebe069bf2b1afad04014d1e10245b259b872b0e12189ef2ce3fca4c73a9b5103aaf4aad1f4"}
export SECRET_KEY_BASE=$SECRET_KEY_BASE

## Setting DB
DB_NAME="my_app_${RAILS_ENV}"
#DATABASE_URL="mysql2://root:root@localhost/${DB_NAME}"

# Trap sigkill and sigterm: otherwise dockr stop/start will complain for stale unicorn pid
trap "pkill unicorn_rails ; exit " SIGINT SIGTERM SIGKILL

echo "Stopping  unicorn_rails, if already running"
pkill unicorn_rails

# echo "Cleaning tmp files"
# rm -rf /home/rails/my-app/tmp/*
mkdir ./shared && \
mkdir ./tmp/pids && \
mkdir ./tmp/sessions && \
mkdir ./tmp/sockets && \
ln -s /home/rails/my-app/tmp/cache /home/rails/my-app/shared/cache && \
ln -s /home/rails/my-app/tmp/pids /home/rails/my-app/shared/pids && \
ln -s /home/rails/my-app/tmp/sessions /home/rails/my-app/shared/sessions && \
ln -s /home/rails/my-app/tmp/sockets /home/rails/my-app/shared/sockets && \
ln -s /home/rails/my-app/log /home/rails/my-app/shared/log 

echo "Setting up database"
RAILS_ENV=production rake db:create db:migrate

# echo "Running unicorn"

#bundle exec unicorn_rails -c /etc/web-app/unicorn.rb -E $RAILS_ENV -d
