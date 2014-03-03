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
		 stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk&reference=328e4dc5e8f41286bddd70df00d4e56ec76facc3&sensor=false").to_return(:body => venue);
		expect(@googleplaces.getVenue("328e4dc5e8f41286bddd70df00d4e56ec76facc3")).to eq(venueJSON);
	end

	it ".getVenues" do
		venues = File.read(File.dirname(__FILE__) + '/fixtures/googleplaces/venues.json');
		venuesJSON = JSON.parse(venues);
		stub_request(:get, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk&location=52.41649271,-4.07785633&radius=500&sensor=false").to_return(:body => venues);
		#Set the relevant filters for this search
		params = {"location" => {"latitude" => "52.41649271", "longitude" => "-4.07785633"}, "radius" => 500, "sensor" => "false"}

		expect(@googleplaces.getVenues(params)).to eql(venuesJSON);
	end

	it '.buildVenue' do
		venue = File.read(File.dirname(__FILE__) + '/fixtures/googleplaces/venue.json');
		venueJSON = JSON.parse(venue);
		 stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk&reference=328e4dc5e8f41286bddd70df00d4e56ec76facc3&sensor=false").to_return(:body => venue);

		output = @googleplaces.buildVenue(@googleplaces.getVenue("328e4dc5e8f41286bddd70df00d4e56ec76facc3"));
		expect(output).to eq({:ref_id=>"328e4dc5e8f41286bddd70df00d4e56ec76facc3", :name=>"Shilam Tandoori", :street=>"Alexandra Rd", :city=>"United Kingdom", :county=>"SY23 1LH", :country=>"Aberystwyth", :post_code=>"Alexandra Rd", :lat=>52.413954, :lon=>-4.08183, :phone=>"01970 615015", :website=>"http://test.com"})
	end

	it '.buildEvent' do
		venue = File.read(File.dirname(__FILE__) + '/fixtures/googleplaces/venue.json');
		venueJSON = JSON.parse(venue);
		 stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk&reference=328e4dc5e8f41286bddd70df00d4e56ec76facc3&sensor=false").to_return(:body => venue);

		output = @googleplaces.buildEvent(@googleplaces.getVenue("328e4dc5e8f41286bddd70df00d4e56ec76facc3"));
		expect(output).to eq({:ref_id=>"9lJ_jK1GfhX", :name=>nil, :desc=>"<p>A visit from author John Doe, who will read from his latest book.</p><p>A limited number of signed copies will be available.</p>", :start_time=>1293865200})		
	end
end