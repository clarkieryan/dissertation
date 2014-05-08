require_relative "resource.rb";
require "json"

class GooglePlaces < Resource

	def initialize()
		@api_key = "";
		@base_uri = "https://maps.googleapis.com/maps/api/place";
		@available_filters = {"keyword" => "string", "language" => "", "name" => "string", "rankby" => {"prominence" => "", "distance" => "int"}, "types" => "string", "radius" => "int" };
	end

	def 	setAPIKey(api_key)
		@api_key  = api_key;
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
		return JSON.parse(self.getResource(@url)); 
	end

	def getVenues(filters)
		#Loop through and get filters
		@filters = self.buildParamString(filters);
		@url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json#{@filters}key=#{@api_key}";
		return JSON.parse(self.getResource(@url));
	end

	def buildVenue(venueDetail)
		venueDetails =  venueDetail['result'];
		return {:ref_id => venueDetails['id'], :name => venueDetails['name'],  :street => venueDetails['address_components'][1]['long_name'], :city => venueDetails['address_components'][2]['long_name'], :county => venueDetails['address_components'][3]['long_name'], :country => venueDetails['address_components'][4]['long_name'], :post_code => venueDetails['address_components'][5]['long_name'], :lat => venueDetails['geometry']['location']['lat'], :lon => venueDetails['geometry']['location']['lng'], :phone => venueDetails['formatted_phone_number'], :website => venueDetails['website']};
	end

	def buildEvent(eventDetail)
		eventDetails =  eventDetail['result']['events'][0];
		return {:ref_id => eventDetails['event_id'], :name => eventDetails['name'], :desc => eventDetails['summary'], :start_time => eventDetails['start_time']}
	end

end