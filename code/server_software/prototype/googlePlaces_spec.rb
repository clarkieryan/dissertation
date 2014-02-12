require_relative "../googlePlaces";

require 'yaml'
require "json"
require 'spec_helper'

	
describe GooglePlaces do
	
	before :each do
		#Instantiate a new GooglePlaces class
		@googleplaces = New.GooglePlaces( "AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk");
	end

	it ".getApiKey" do
		expect(@googleplaces.getApiKey).to equal( "AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk");
	end	

end

api_key = "AIzaSyAsU5XpnhyRwiuxqSHxtJnmFJ9nAYsq-Kk";