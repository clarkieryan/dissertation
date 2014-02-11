require "./resource.rb";
require "json"

class Facebook < Resource

	
	

	def initialize(app_id, app_secret)
		#Set the app oAuth details
		@app_id = app_id;
		@app_secret = app_secret;
		# Set the base URI
		@base_uri = "http://graph.facebook.com"
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

	def getEvent(eventID)
		@url = "#{@base_uri}/#{eventID}";
		return self.getResource(@url);
	end

	def getVenue(venueID) 
		@url = "#{@base_uri}/#{venueID}";
		return self.getResource(@url);
	end


end