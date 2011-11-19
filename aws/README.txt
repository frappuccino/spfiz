PURPOSE: 
    Provision an running alestic-based Ubuntu 11.10 EC2 instance with rvm, ruby 1.9.3, and nginx.

TO USE: 
   (local) Install Ruby / Sprinkle / Erubis / i18n 
   (remote) Spinup and EC2 instance
   (remote) # dpkg-reconfigure tzdata
   (remote) If configuring sprinkle to using root-level password-based logins: 
               # sudo passwd root
               Enable "PasswordAuthentication" in /etc/ssh/sshd_config's 
               # service ssh restart
   (local) Copy config.rb.example to pvt/config.rb and adjust as necessary
   (local) # sprinkle -t -v -c -s install.rb
   (local) # sprinkle    -v -c -s install.rb 
   
After server is provisioned, manually follow up with: 
   (remote) # htpasswd -c  /etc/nginx/htpasswd.< servername >
   (local/remote) Copy certificate files to /etc/nginx/ssl/servername.domainname.{key|crt} 
   (remote) # reboot 

NOTE: 
 This sprinkle script is usually followed by  a cap deploy of a rails application 
    that includes necessary unicorn file to tie-in with these nginx configuration files. 
