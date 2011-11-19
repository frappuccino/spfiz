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

package :imagemagic do
	apt 'imagemagick' 
	verify do
		has_apt 'imagemagic'
	end
end
