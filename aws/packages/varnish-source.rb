package :varnish_302_from_source do
  requires :pkgconfig
  requires :libpcre
  source 'http://repo.varnish-cache.org/source/varnish-3.0.2.tar.gz'
  verify  { has_executable '/usr/local/sbin/varnishd' }
end

package :trash do
  runner 'echo "hello"'
  verify { has_magic_beans('ranch') }
end

package :test1 do
  runner 'echo "Just a simple test"'
  verify { matches_my_local "#{$filesdir}/pvt/fizbeaux.com.crt", "/etc/nginx/ssl/fizbeaux.com.crt" }
end
