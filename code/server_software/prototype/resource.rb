require 'net/http'
require 'httparty'

class Resource 
	include HTTParty

	# TODO -  Need to add in some error handling with the HTTP requests
	# TODO - Maybe use HTTP Party to do error handling etc for me
	# https://github.com/jnunemaker/httparty
	def getResource(rawURL)
		res = HTTParty.get(rawURL);
		return res.body;
	end 

end
