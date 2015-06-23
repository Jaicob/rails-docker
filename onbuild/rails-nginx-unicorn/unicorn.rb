app_dir = "/home/rails/my-app"
shared_dir = "#{app_dir}/shared"
working_directory app_dir
puts " APP DIR #{app_dir}"

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen "#{app_dir}/tmp/sockets/unicorn.app.sock",  :backlog => 1024

# Logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{app_dir}/tmp/pids/unicorn.pid"