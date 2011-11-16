package :setname do
  	SERVERNAME = $servername
	DOMAINNAME = $domainname
        MYTIME     = $myt
	transfer "#{$filesdir}/rc.local.template", "/tmp/rc.local.template", :render => true 

#	verify do
	   # compare the erb file to a tmp copy; this is a less than ideal verification, 
 	   # but it should work provided the post :install copy is in place 
	   ## ISSUES WITH Sprinkle's match_local; working on fixing them.
#	   matches_local "#{$filesdir}/rc.local.template", "/tmp/rc.local.tmp"
#	end
end

package :copysetname do
	
	requires :setname

	bkrclocal = "/tmp/rc.local." + $myt

	runner 'if [ "X(md5sum /tmp/rc.local.template |cut -d\" \" -f 1)" != "X(md5sum /etc/rc.local |cut -d\" \" -f 1)" ]; then cp /tmp/rc.local.template /etc/rc.local; fi' do     
	   pre :install, "if [ -f /etc/rc.local ]; then cp /etc/rc.local #{bkrclocal}; fi"
	end
end

