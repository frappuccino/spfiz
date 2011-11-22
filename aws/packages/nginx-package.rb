package :nginx do
  apt 'nginx-full'
	
  verify do
    has_apt 'nginx-full'
  end
end
