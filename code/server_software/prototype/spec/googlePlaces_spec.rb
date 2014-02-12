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

end