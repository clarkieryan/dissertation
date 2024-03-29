require_relative "resource.rb";
require "json"

class Facebook < Resource

	def initialize()
		# Set the base URI
		@base_uri = "http://graph.facebook.com"
		@access_token = "";
		@api_tokens = {};
		@app_id ="ff"
		@app_secret ="ff"
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
		@url = "#{@base_uri}/#{eventID}";
		return self.getResource(@url);
	end

	def getVenue(venueID) 
		@url = "#{@base_uri}/#{venueID}";
		return self.getResource(@url);
	end

	def getEvents(venueID)
		@url = "#{@base_uri}/#{venueID}/events";
		return self.getResource(@url);
	end

	def getVenues(params)
		paramString = self.buildParamString(params);
		url = "#{@base_uri}/search#{paramString}access_token=#{@access_token}";
		return self.getResource(url);
	end

	def getOAuthToken 
		@url = "#{@base_uri}/oauth/access_token?client_id=#{@app_id}&client_secret=#{@app_secret}&grant_type=client_credentials&redirect_uri=http://localhost";
		@access_token = self.getResource(@url);
		@access_token.slice! "access_token="
	end

end