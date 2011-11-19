# install.rb
#
# TO USE: 
#   Install Ruby / Sprinkle.
#   PRE SPRINKLE : 
#       (remote) Spin up and EC2 instance; set the timezone; set login method (key / password)
#       (local) Copy config.rb.example to pvt/config.rb and adjust as necessary.
#
#   POST SPRINKLE: 
#      - Create a password file
#          # htpasswd -c  /etc/nginx/htpasswd.< servername >
#        or comment out the auth_basic directives from nginx
#      - Copy certificate files to 
#             /etc/nginx/ssl/servername.domainname.{key|crt} 

# TO TEST:
# sprinkle -t -v -c -s install.rb

# TO RUN:
# sprinkle -v -c -s install.rb

# PURPOSE: 
# Provision an running alestic-based Ubuntu 11.10 EC2 instance with rvm, 
#    ruby 1.9.3, and nginx.
# Global variables are used in facilitate the `naming` of EC2 instances and 
#    the creation of custom nginx configuration files.  That is to say, simply
#    adjust the pvt/config.rb file with new information and the next sprinkle run
#    will provision a new server.

# NOTE: 
# This sprinkle script is usually followed by  a cap deploy of a rails application 
#    that includes necessary unicorn file to tie-in with these nginx configuration files. 

##  - Setting some global variables to simply things
$thisdir = Dir.pwd
$time = Time.new
$myt = $time.strftime("%Y%m%d-%H:%M")
$filesdir = "#{$thisdir}/files"
SERVERNAME = $servername
DOMAINNAME = $domainname
MYTIME     = $myt

require "#{$thisdir}/pvt/config.rb"
require "#{$thisdir}/packages/essential"
require "#{$thisdir}/packages/rvm-package"
require "#{$thisdir}/packages/ruby193"
require "#{$thisdir}/packages/setname"
require "#{$thisdir}/packages/nginx-package"
require "#{$thisdir}/packages/nginx-files"

deployment do

  # mechanism for deployment
  delivery :capistrano do
    recipes 'deploy'
  end

  # source based package installer defaults
  #source do
  #  prefix   '/usr/local'           # where all source packages will be configured to install
  #  archives '/usr/local/sources'   # where all source packages will be downloaded to
  #  builds   '/usr/local/build'     # where all source packages will be built
  #end
end

policy :myapp, :roles => :app do
  requires :setname
  requires :copysetname
  requires :nginx
  requires :ruby193p0
#  requires :bundler
  requires :subversion
  requires :dbstuff
  requires :webutilities
  requires :linkrvm
  requires :nxconf
  requires :copynxconf
  requires :nxvirt
  requires :copynxvirt
end
