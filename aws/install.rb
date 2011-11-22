# install.rb
#
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
require "#{$thisdir}/packages/mysql-server.rb"

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
  requires :mysqlserver
  requires :webutilities
  requires :imagemagic
  requires :linkrvm
  requires :nxconf
  requires :copynxconf
  requires :nxvirt
  requires :copynxvirt
  requires :sslkeys
  requires :siteenable
end
