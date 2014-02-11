require "./resource.rb";
require "json"

class Facebook < Resource

	def initialize(app_id, app_secret)
		#Set the app oAuth details
		@app_id = app_id;
		@app_secret = app_secret;
		# Set the base URI
		@base_uri = "http://graph.facebook.com"
		@access_token = "";
		self.getOAuthToken;
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

	def getEvent(eventID)
		@url = "#{@base_uri}/#{eventID}";
		return self.getResource(@url);
	end

	def getVenue(venueID) 
		@url = "#{@base_uri}/#{venueID}";
		return self.getResource(@url);
	end

	def getOAuthToken 
		@url = "#{@base_uri}/oauth/access_token?client_id=#{@app_id}&client_secret=#{@app_secret}&grant_type=client_credentials&redirect_uri=http://localhost";
		@access_token = self.getResource(@url);
		@access_token.slice! "access_token="
	end

end