working_directory "/root/PassServer/"

pid "/root/PassServer/tmp/pids/unicorn.pid"

stderr_path "/root/PassServer/log/unicornerr.log"
stdout_path "/root/PassServer/log/unicornout.log"

listen "/root/PassServer/tmp/sockets/unicorn.sock", :backlog => 64
listen 3032, :tcp_nopush => true

worker_processes 2

# preload_app true

timeout 30

before_fork do |server, worker|
  defined?(ActiveRecored::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
