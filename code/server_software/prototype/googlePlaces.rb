require "./resource.rb";
require "json"

class GooglePlaces < Resource

	def initialize(api_key)
		@api_key = api_key;
		@base_uri = "https://maps.googleapis.com/maps/api/place";
	end

	def getApiKey 
		return @api_key
	end

	def getBaseURI 
		return@base_uri;
	end

end