require "./resource.rb";
require "json"

class GooglePlaces < Resource

	def initialize(api_key)
		@api_key = api_key;
	end

	def getApiKey 
		return @api_key
	end

end