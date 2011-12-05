package :libssldev do
  apt 'libssl-dev'
    verify do
      has_apt 'libssl-dev'
    end
end

package :subversion do
  apt 'subversion'
    verify do
      has_apt 'subversion'
    end
end

package :dbstuff do
  apt 'libmysqlclient-dev libxml2 libxml2-dev libxslt1-dev'
  verify do
    has_apt 'libmysqlclient-dev'
    has_apt 'libxml2'
    has_apt 'libxml2-dev'
    has_apt 'libxslt1-dev'
  end
end

package :webutilities do
  # need this for htpasswd
  apt 'apache2-utils'
  verify do 
    has_apt 'apache2-utils'
  end
end

package :postfix do
  apt 'postfix'
  verify do 
    has_apt 'postfix'
  end
end

package :postfix_local do
  requires :postfix
  replace_text 'inet_interfaces = all', 'inet_interfaces = 127.0.0.1', '/etc/postfix/main.cf'
  verify { file_contains '/etc/postfix/main.cf', 'inet_interfaces = 127.0.0.1' }
end

package :imagemagic do
  apt 'imagemagick' 
  verify do
    has_apt 'imagemagick'
  end
end

package :nginx do
  apt 'nginx-full'	
  verify do
    has_apt 'nginx-full'
  end
end

package :monit do
  requires :postfix_local
  apt 'monit'
  verify do
    has_apt 'monit'
  end
end

package :curl do
  apt 'curl'
  verify do 
    has_apt 'curl'
  end
end

package :pkgconfig do
  apt 'pkg-config'
  verify do
    has_apt 'pkg-config'
  end
end

package :libpcre do
  apt 'libpcre3-dev'
  verify do 
    has_apt 'libpcre3-dev'
  end
end

package :ntp do
  apt 'ntp' do
    pre :install, 'ntpdate pool.ntp.org'  # it's a good idea to set the clock before starting ntp
  end
  verify do
    has_apt 'ntp'
  end
end

