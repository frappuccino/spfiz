package :varnish_302_from_source do
  requires :pkgconfig
  requires :libpcre
  source 'http://repo.varnish-cache.org/source/varnish-3.0.2.tar.gz'
  verify  { has_executable '/usr/local/sbin/varnishd' }
end

package :test1 do
  runner 'echo "Just a simple test"'
  verify { match_local_remote "#{$filesdir}/pvt/fizbeaux.com.crt", "/etc/nginx/ssl/fizbeaux.com.crt" }
end
