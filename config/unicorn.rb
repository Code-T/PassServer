working_directory "/home/PassServer/"

pid "/home/PassServer/tmp/pids/unicorn.pid"

stderr_path "/home/PassServer/log/unicornerr.log"
stdout_path "/home/PassServer/log/unicornout.log"

listen "/home/PassServer/tmp/sockets/unicorn.sock", :backlog => 64
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
