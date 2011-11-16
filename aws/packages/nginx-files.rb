SERVERNAME = $servername
DOMAINNAME = $domainname
MYTIME     = $myt
tmpnx    = "/tmp/nginx.conf"
bknx     = "/tmp/nginx.conf." + $myt
filenx   = "/etc/nginx/nginx.conf"

tmpvirt	 = "/tmp/nginx.virtual.conf"
bkvirt   = "/tmp/nginx.virtual.conf." + $myt
filevirt = "/etc/nginx/sites-available/#{$servername}"


package :nxconf do	
	transfer "#{$filesdir}/nginx.conf.template", '/tmp/nginx.conf.template', :render => true 

end

package :nxvirt do
        transfer "#{$filesdir}/nginx.virtual.template", '/tmp/nginx.virtual.template', :render => true
end

package :copynxconf do

	requires :nxconf
 
	runner 'if [ "X(md5sum #{tmpnx} |cut -d\" \" -f 1)" != "X(md5sum #{filenx} |cut -d\" \" -f 1)" ]; then cp "#{tmpnx}" "#{filenx}; fi' do     
	   pre :install, "if [ -f #{filenx} ]; then cp #{filenx} #{bknx}; fi"
	end
end

package :copynxvirt do

	requires :nxvirt

	runner 'if [ "X(md5sum #{tmpvirt} |cut -d\" \" -f 1)" != "X(md5sum #{filevirt} |cut -d\" \" -f 1)" ]; then cp "#{tmpvirt}" "#{filevirt}"; fi' do     
	   pre :install, "if [ -f #{filevirt} ]; then cp #{filevirt} #{bkvirt}; fi"
	end


	runner "cp /tmp/nginx.virtual.template #{filevirt}" do
	# backup existing file
	   pre :install, "if [ -f #{filevirt} ]; then cp #{filevirt} #{bkvirt}; fi"
	end

	# Verification: Figure out a way to compare two remote files
end
