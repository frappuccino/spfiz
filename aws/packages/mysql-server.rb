package :mysqlserver do
	# this will force install mysql server without a password
	# Be sure to login after and set a password 
	# This command will do the trick "mysqladmin -u root password NEWPASSWORD"
	apt 'mysql-server'
	verify do
		has_apt 'mysql-server'
	end
end

