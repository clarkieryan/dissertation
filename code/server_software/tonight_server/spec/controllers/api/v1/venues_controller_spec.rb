require 'spec_helper'

describe API::V1::VenuesController do 

	let (:user) {FactoryGirl.create(:user)}
	let(:token) { double :accessible? => true, :resource_owner_id => user.id }

	before :each do
		allow(controller).to receive(:doorkeeper_token){token}
		@venue = FactoryGirl.create(:venue)
	end
	
	describe '.index' do

		it 'responds with a 200' do
			get :index
			expect(response.status).to eq(200) 
		end

		it 'responds with a list of the current attributes' do
			get :index
	   		expect(response.body).to eq(Venue.all.to_json);
		end

	end

	describe '.show' do
		
		it 'get\'s an individual page' do
			get :show, :id => @venue.id
			expect(response).to be_success
			expect(response.body).to eq(@venue.to_json) 
		end

	end

	describe ".venuesByCity" do
		
		it "Returns all the venues of a particular city" do
			get :venuesByCity, city_id: @venue.city.id
			expect(response.body).to eq(Venue.all.to_json); 
		end

	end

end