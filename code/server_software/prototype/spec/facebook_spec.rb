require_relative "../facebook";

require 'yaml'
require "json"
require 'spec_helper'
 
describe Facebook do
 	
 	before :each do
 		stub_request(:get, "http://graph.facebook.com/oauth/access_token?client_id=app_id&client_secret=app_secret&grant_type=client_credentials&redirect_uri=http://localhost").to_return(:body => "access_token=access|token");
		@facebook = Facebook.new('app_id',  'app_secret')
	end

	it "when instantiated get an OAuth access token" do	
		@facebook.getAccessToken.should eq("access|token")
	end

	it "has a constant of the base url " do
		@facebook.getBaseUri.should  eq("http://graph.facebook.com")
	end

	it "has an app id set" do
		@facebook.getAppSecret.should  eq("app_secret")
	end

	it "has an app secret set" do
		@facebook.getAppID.should  eq("app_id")
	end

	it "#getOAuthToken" do
		stub_request(:get, "http://graph.facebook.com/oauth/access_token").to_return(:body => "access_token=access|token");
		@facebook.getOAuthToken;
		@facebook.getAccessToken.should eq("access|token")
	end

	it "gets an event from it's ID" do
 		#Reads in the example JSON reply
 		event = File.read(File.dirname(__FILE__) + '/fixtures/facebook/event.json');
 		#Convert to String to JSON
 		@eventJSON = JSON.parse(event);
 		stub_request(:get, "http://graph.facebook.com/204504813084059").to_return(:body => @eventJSON);
 		@facebook.getEvent('204504813084059').should eq(@eventJSON);
	end

	it "gets an event from it's ID" do
		 venue = File.read(File.dirname(__FILE__) + '/fixtures/facebook/venue.json');
 		#Convert to String to JSON
 		@venueJSON = JSON.parse(venue);
		stub_request(:get, "http://graph.facebook.com/224699987546240").to_return(:body => @venueJSON);
		@facebook.getVenue("224699987546240"). should eq(@venueJSON);
	end

end