THEENV     = $theenv      # see pvt/config.rb
SITEDOMAIN = $sitedomain  # see pvt/config.rb
IDENTITY   = $identity    # see pvt/config.rb

tmpucorn = "/tmp/unicorn.#{$sitedomain}.template"
ucorn    = "/etc/init.d/unicorn.#{$sitedomain}"
bkucorn  = "/tmp/unicorn." + $myt

package :unicorn_startup do
  transfer "#{$filesdir}/unicorn.template", "#{tmpucorn}", :render => true 
end

package :copyunicorn_startup do
  requires :unicorn_startup
  runner "if [ \"X\(md5sum #{tmpucorn} | awk \'{print $1}\' \)\" != \"X\(md5sum #{ucorn} | awk \'{print $1}\' \)\" ]; then cp #{tmpucorn} #{ucorn}; fi" do
    pre :install, "if [ -f #{ucorn} ]; then cp ${ucorn} ${bkucorn}; fi"
    post :install, "if [ ! -h /etc/rc3.d/S20unicorn.#{$sitedomain} ]; update-rc.d unicorn.#{$sitedomain} defaults; fi"
  end
end

package :monit do
  apt 'monit'
  verify do
    has_apt 'monit'
  end
end
