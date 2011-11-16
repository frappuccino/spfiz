SERVERNAME = $servername
DOMAINNAME = $domainname
MYTIME     = $myt

package :nxconf do	
	transfer "#{$filesdir}/nginx.conf.template", '/tmp/nginx.conf.template', :render => true 

end

package :nxvirt do
        transfer "#{$filesdir}/nginx.virtual.template", '/tmp/nginx.virtual.template', :render => true
end

package :copynxconf do

	requires :nxconf
	
	bknx = "/tmp/nginx.conf." + $myt
        filenx = "/etc/nginx/nginx.conf"

	# Overwrite /etc/nginx/nginx.conf with custom /tmp/nginx.conf.tmp 
	runner "if [ -f /tmp/nginx.conf.tmp ]; then cp /tmp/nginx.conf.template /etc/nginx/nginx.conf" do
	   # backup existing file
	   pre :install, "if [ -f #{filenx} ]; then cp #{filenx} #{bknx}; fi"
	end

	# Verification: Figure out a way to compare two remote files
end

package :copynxvirt do

	requires :nxvirt

	bkvirt = "/tmp/nginx.virtual.conf." + $myt
	filevirt = "/etc/nginx/sites-available/#{$servername}"

	runner "cp /tmp/nginx.virtual.template #{filevirt}" do
	# backup existing file
	   pre :install, "if [ -f #{filevirt} ]; then cp #{filevirt} #{bkvirt}; fi"
	end

	# Verification: Figure out a way to compare two remote files
end
