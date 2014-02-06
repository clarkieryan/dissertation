require 'net/http'

class Resource 

	def getResource(rawURL)
		url = URI.parse(rawURL)
		req = Net::HTTP::Get.new(url.path)
		res = Net::HTTP.start(url.host, url.port) {|http|
			http.request(req)
		}
		return res.body;
	end 

end
