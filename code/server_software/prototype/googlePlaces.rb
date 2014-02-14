require "./resource.rb";
require "json"

class GooglePlaces < Resource

	

	def initialize(api_key)
		@api_key = api_key;
		@base_uri = "https://maps.googleapis.com/maps/api/place";
		@available_filters = {"keyword" => "string", "language" => "", "name" => "string", "rankby" => {"prominence" => "", "distance" => "int"}, "types" => "string", "radius" => "int" };
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

	def getVenues(filters)
		#Loop through and get filters
		@filters = self.buildParams(filters);
		@url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json#{@filters}key=#{@api_key}";
		return self.getResource(@url);
	end

end