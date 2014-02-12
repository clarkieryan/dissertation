require_relative "../googlePlaces";

require 'yaml'
require "json"
require 'spec_helper'

	
describe GooglePlaces do
	
	before :each do
		#Instantiate a new GooglePlaces class
		@googleplaces = GooglePlaces.new( "AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk");
	end

	it ".getApiKey" do
		expect(@googleplaces.getApiKey).to eq( "AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk");
	end	

	it ".getBaseURI" do
		expect(@googleplaces.getBaseURI).to eq("https://maps.googleapis.com/maps/api/place");
	end

	it ".getVenue" do
		venue = File.read(File.dirname(__FILE__) + '/fixtures/googleplaces/venue.json');
		@venueJSON = JSON.parse(venue);
		  stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk&reference=328e4dc5e8f41286bddd70df00d4e56ec76facc3&sensor=false").to_return(:body => @venueJSON);
		expect(@googleplaces.getVenue("328e4dc5e8f41286bddd70df00d4e56ec76facc3")).to eq(@venueJSON);
	end

	it ".getVenues" do
		venues = File.read(File.dirname(__FILE__) + '/fixtures/googleplaces/venues.json');
		@venuesJSON = JSON.parse(venues);
		stub_request(:get, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=52.41649271,-4.07785633&radius=500&sensor=false&key=AIzaSyDvq9AffhVGnPL6byYitdUB54gxlPtTCgg").to_return(:body => @venuesJSON);

		expect(@googleplaces.getVenues).to eql(@venuesJSON);
	end
end