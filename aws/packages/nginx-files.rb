SERVERNAME   = $servername   # see pvt/config.rb
SERVERDOMAIN = $serverdomain # see pvt/config.rb
SITENAME     = $sitename     # see pvt/config.rb
SITEDOMAIN   = $sitedomain   # see pvt/config.rb
IDENTITY     = $identity     # see pvt/config.rb
SOCKETNAME   = $socketname   # see pvt/config.rb
AKA	     = $identity     # nginx's site_name can be completely defined by identity?
# AKA        = "#{$idenity} www.#{$identity}"  # nginx's site_name needs "www" when you've set sitename="" 
MYTIME     = $myt

# /etc/nginx.conf
tmpnx    = "/tmp/nginx.conf.template"
bknx     = "/tmp/nginx.conf." + $myt
filenx   = "/etc/nginx/nginx.conf"

# /etc/nginx/sites-available/<identity>
tmpvirt	 = "/tmp/#{$identity}.template"
bkvirt   = "/tmp/#{$identity}." + $myt
filevirt = "/etc/nginx/sites-available/#{$identity}"


package :nxconf do	
	transfer "#{$filesdir}/nginx.conf.template", "#{tmpnx}", :render => true 
end

package :nxvirt do
        transfer "#{$filesdir}/nginx.virtual.template", "#{tmpvirt}", :render => true
end

package :copynxconf do
       requires :nxconf
       runner 'if [ "X(md5sum /tmp/nginx.conf.template |cut -d\" \" -f 1)" != "X(md5sum /etc/nginx/nginx.conf |cut -d\" \" -f 1)" ]; then cp /tmp/nginx.conf.template /etc/nginx/nginx.conf; fi' do     
	   pre :install, "if [ -f #{filenx} ]; then cp #{filenx} #{bknx}; fi"
	end

 end

package :copynxvirt do
	requires :nxvirt 
	runner "if [ \"X\(md5sum #{tmpvirt} | awk \'{print $1}\' \)\" != \"X\(md5sum #{filevirt} | awk \'{print $1}\' \)\" ]; then cp #{tmpvirt} #{filevirt}; fi" do
	   pre :install, "if [ -f #{filevirt} ]; then cp #{filevirt} #{bkvirt}; fi"
	end

end



# IF THE ABOVE RUNNER LINES FAIL, USE THIS METHOD
# ---------------------------------------

# Alternative method for copying files
# verifiedcopy = "#{$filesdir}/verified.copy.bash.template"

# package :copynxconf do
	# TMPFILE = tmpnx
	# REALFILE = filenx	
        # BKFILE = bknx
	# requires :nxconf

	# transfer "#{verifiedcopy}", "/tmp/copy.nginx.conf.bash", :render => true
	# runner   "/tmp/copy.nginx.conf.bash"
# end

# package :copynxvirt do
	# TMPFILE = tmpvirt
	# REALFILE = filevirt
	# requires :nxvirt

	# transfer "#{verifiedcopy}", "/tmp/copy.nginx.#{sitename}.#{sitedomain}.bash", :render => true
	# runner   "/tmp/copy.#{sitename}.#{sitedomain}.bash"
# end
