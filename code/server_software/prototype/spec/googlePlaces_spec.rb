require_relative "../lib/resources/googlePlaces";

require 'yaml'
require "json"
require 'spec_helper'

	
describe GooglePlaces do
	
	before :each do
		#Instantiate a new GooglePlaces class
		@googleplaces = GooglePlaces.new;
		@googleplaces.setAPIKey('AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk');
	end

	it ".getApiKey" do
		expect(@googleplaces.getApiKey).to eq( "AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk");
	end	

	it ".getBaseURI" do
		expect(@googleplaces.getBaseURI).to eq("https://maps.googleapis.com/maps/api/place");
	end

	it ".getAvailableFilters" do
		available_filters = {"keyword" => "string", "language" => "", "name" => "string", "rankby" => {"prominence" => "", "distance" => "int"}, "types" => "string", "radius" => "int" };
		expect(@googleplaces.getAvailableFilters).to eq(available_filters);
	end

	it ".getVenue" do
		venue = File.read(File.dirname(__FILE__) + '/fixtures/googleplaces/venue.json');
		venueJSON = JSON.parse(venue);
		  stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk&reference=328e4dc5e8f41286bddd70df00d4e56ec76facc3&sensor=false").to_return(:body => venueJSON);
		expect(@googleplaces.getVenue("328e4dc5e8f41286bddd70df00d4e56ec76facc3")).to eq(venueJSON);
	end

	it ".getVenues" do
		venues = File.read(File.dirname(__FILE__) + '/fixtures/googleplaces/venues.json');
		venuesJSON = JSON.parse(venues);
		stub_request(:get, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk&location=52.41649271,-4.07785633&radius=500&sensor=false").to_return(:body => venuesJSON);
		#Set the relevant filters for this search
		params = {"location" => {"latitude" => "52.41649271", "longitude" => "-4.07785633"}, "radius" => 500, "sensor" => "false"}

		expect(@googleplaces.getVenues(params)).to eql(venuesJSON);
	end
end