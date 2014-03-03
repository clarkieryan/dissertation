require_relative "resource.rb";
require "json"

class Facebook < Resource

	def initialize()
		# Set the base URI
		@base_uri = "https://graph.facebook.com"
		@access_token = "";
		@api_tokens = {};
		@app_id =""
		@app_secret =""
		@available_filters = {"q" => "string", "type" => ["page", "event", "place"], "center" => {"latitude" => "int", "longitude" => "int"}, "distance" => "int"};
	end

	def setAPITokens(api_tokens)
		@app_id = api_tokens[:app_id];
		@app_secret = api_tokens[:app_secret];
		self.getOAuthToken
	end

	def getAPITokens
		return @api_tokens;
	end

	def getBaseUri 
		return @base_uri;
	end

	def getAppID 
		return @app_id;
	end

	def getAppSecret 
		return @app_secret;
	end

	def getAccessToken 
		return @access_token;
	end

	def getAvailableFilters
		return @available_filters;
	end

	def getEvent(eventID)
		@url = "#{@base_uri}/#{eventID}/?access_token=#{@access_token}";
		return JSON.parse(self.getResource(@url));
	end

	def getVenue(venueID) 
		@url = "#{@base_uri}/#{venueID}/?access_token=#{@access_token}";
		return JSON.parse(self.getResource(@url));
	end

	def getEvents(venueID)
		@url = "#{@base_uri}/#{venueID}/events/?access_token=#{@access_token}";
		response = JSON.parse(self.getResource(@url));
		return response['data'];
	end

	def getVenues(params)
		paramString = self.buildParamString(params);
		url = "#{@base_uri}/search#{paramString}access_token=#{@access_token}";
		response = JSON.parse(self.getResource(url));
		return response['data'];
	end

	def getOAuthToken 
		@url = "#{@base_uri}/oauth/access_token?client_id=#{@app_id}&client_secret=#{@app_secret}&grant_type=client_credentials&redirect_uri=http://localhost";
		@access_token = self.getResource(@url);
		@access_token.slice! "access_token="
	end

	def buildVenue(venueDetails)
		return {:ref_id => venueDetails['id'], :name => venueDetails['name'], :desc => venueDetails['description'], :street => venueDetails['location']['street'], :city => venueDetails['location']['city'], :county => venueDetails['location']['state'], :country => venueDetails['location']['country'], :post_code => venueDetails['location']['zip'], :lat => venueDetails['location']['latitude'], :lon => venueDetails['location']['longitude'], :phone => venueDetails['phone'], :website => venueDetails['website']}
	end

	def buildEvent(eventDetails)
		return {:ref_id => eventDetails['id'], :name => eventDetails['name'], :desc => eventDetails['description'], :start_time => eventDetails['start_time'], :end_time => eventDetails['end_time'], :timezone => eventDetails['timezone'], :updated_at => eventDetails['updated_at'] }
	end

end