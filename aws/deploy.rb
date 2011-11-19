# deploy.rb

set :user, 'root'
# set :password, ''
# ssh_options[:keys] = [File.join(ENV["HOME"], "Downloads", "ec2-keyname")]

set :run_method, :run

role :app, "#{$servername}.#{$serverdomain}"

default_run_options[:pty] = true

