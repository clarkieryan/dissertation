require 'net/http'

class Resource 

	# TODO -  Need to add in some error handling with the HTTP requests
	def getResource(rawURL)
		url = URI.parse(rawURL)
		req = Net::HTTP::Get.new(url.path)
		res = Net::HTTP.start(url.host, url.port) {|http|
			http.request(req)
		}
		return res.body;
	end 

end
