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

# BE SURE customverify is the first required file
require "#{$thisdir}/custom/customverify"
# BE SURE customverify is the first required file 

require "#{$thisdir}/pvt/config.rb"
require "#{$thisdir}/packages/varnish-source"
require "#{$thisdir}/packages/essential"
require "#{$thisdir}/packages/rvm-package"
require "#{$thisdir}/packages/ruby193"
require "#{$thisdir}/packages/setname"
require "#{$thisdir}/packages/nginx-files"
require "#{$thisdir}/packages/unicorn-monit-files"
require "#{$thisdir}/packages/mysql-server"
# require "#{$thisdir}/packages/varnish-package"
require "#{$thisdir}/packages/varnish-source"

deployment do
  # mechanism for deployment
  delivery :capistrano do
    recipes 'deploy'
  end
# 
#   # source based package installer defaults
  source do
    prefix   '/usr/local'           # where all source packages will be configured to install
    archives '/usr/local/sources'   # where all source packages will be downloaded to
    builds   '/usr/local/build'     # where all source packages will be built
  end
end
# 
policy :myapp, :roles => :app do
#   requires :setname
#   requires :copy_setname
#   requires :nginx
#   requires :ruby193p0
# #  requires :bundler
#   requires :subversion
#   requires :dbstuff
#   requires :mysqlserver
#   requires :webutilities
#   requires :imagemagic
#   requires :linkrvm
#   requires :copy_nxconf
#   requires :copy_nxvirt
  requires :copy_ssl_crt
  requires :copy_ssl_key
#   requires :site_enable
#   requires :activate_unicorn_startup
#   requires :copy_monit_global
#   requires :copy_monit_site
# #  requires :varnish_lts_install
  requires :varnish_302_from_source
  requires :test1
end

