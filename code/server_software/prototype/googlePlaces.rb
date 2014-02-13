require "./resource.rb";
require "json"

class GooglePlaces < Resource

	

	def initialize(api_key)
		@api_key = api_key;
		@base_uri = "https://maps.googleapis.com/maps/api/place";
		@available_filters = {"keyword" => "string", "language" => "", "name" => "string", "rankby" => {"prominence" => "", "distance" => "int"}, "types" => "string" };
	end

	def getApiKey 
		return @api_key
	end

	def getBaseURI 
		return@base_uri;
	end

	def getAvailableFilters 
		return @available_filters;
	end

	def getVenue(venueID)
		@url = "#{@base_uri}/details/json?key=#{@api_key}&sensor=false&reference=#{venueID}";
		return self.getResource(@url);
	end

	def getVenues()
		@url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=52.41649271,-4.07785633&radius=500&sensor=false&key=AIzaSyDvq9AffhVGnPL6byYitdUB54gxlPtTCgg";
		return self.getResource(@url);
	end

end