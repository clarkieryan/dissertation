require_relative "../lib/resources/facebook";

require 'yaml'
require "json"
require 'spec_helper'
 
describe Facebook do
 	
 	before :each do
 		stub_request(:get, "http://graph.facebook.com/oauth/access_token?client_id=app_id&client_secret=app_secret&grant_type=client_credentials&redirect_uri=http://localhost").to_return(:body => "access_token=accesstoken");
		@facebook = Facebook.new;
		@api_tokens = { :app_id =>"app_id", :app_secret => "app_secret"};
		@facebook.setAPITokens(@api_tokens);
	end

	it "'sets the relevant api access details" do

		expect(@facebook.getAppSecret).to eq(@api_tokens[:app_secret]);
		expect(@facebook.getAppID).to eq(@api_tokens[:app_id]);
	end

	it "when instantiated get an OAuth access token" do	
		@facebook.getAccessToken.should eq("accesstoken")
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

	it ".getAvailableFilters" do
		filters = {"q" => "string", "type" => ["page", "event", "place"], "center" => {"latitude" => "int", "longitude" => "int"}, "distance" => "int"}
		expect(@facebook.getAvailableFilters).to eq(filters);
	end

	it "#getOAuthToken" do
		stub_request(:get, "http://graph.facebook.com/oauth/access_token").to_return(:body => "access_token=access|token");
		@facebook.getOAuthToken;
		@facebook.getAccessToken.should eq("accesstoken")
	end

	it "gets an event from it's ID" do
 		#Reads in the example JSON reply
 		@event = File.read(File.dirname(__FILE__) + '/fixtures/facebook/event.json');
 		#Convert to String to JSON
 		eventJSON = JSON.parse(@event);
 		stub_request(:get, "http://graph.facebook.com/204504813084059").to_return(:body => eventJSON);
 		@facebook.getEvent('204504813084059').should eq(eventJSON);
	end

	it "gets an event from it's ID" do
		#Read in the example JSON reply
		 venue = File.read(File.dirname(__FILE__) + '/fixtures/facebook/venue.json');
 		#Convert to String to JSON
 		venueJSON = JSON.parse(venue);
		stub_request(:get, "http://graph.facebook.com/224699987546240").to_return(:body => venueJSON);
		@facebook.getVenue("224699987546240"). should eq(venueJSON);
	end

	it "gets a list of events from a venue" do
		events = File.read(File.dirname(__FILE__) + '/fixtures/facebook/events.json');
		eventsJSON  = JSON.parse(events);
		stub_request(:get, "http://graph.facebook.com/204504813084059/events").to_return(:body => eventsJSON);
		#getEvents
		@facebook.getEvents("204504813084059").should eq(eventsJSON);
	end

	it "searches for various venues" do
		venues = File.read(File.dirname(__FILE__) + '/fixtures/facebook/venues.json');
		venuesJSON  = JSON.parse(venues);
		stub_request(:get, "http://graph.facebook.com/search?access_token=accesstoken&center=52.41649271,-4.07785633&distance=500&q=Pub&type=place").to_return(:body => venuesJSON);
		params = { "q" => "Pub", "distance" => 500, "center" => "52.41649271,-4.07785633", "type" => "place"}

		expect(@facebook.getVenues(params)).to eq(venuesJSON);
	end

end