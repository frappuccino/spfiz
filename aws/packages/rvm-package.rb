package :rvm do
	apt 'ruby-rvm'
	
	verify do
		has_apt 'ruby-rvm'
	end
end
