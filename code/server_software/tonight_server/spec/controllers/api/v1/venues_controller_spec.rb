require 'spec_helper'

describe API::V1::VenuesController do 

	before :each do
		@venue = FactoryGirl.create(:venue)
	end
	
	describe '.index' do

		it 'responds with a 200' do
			get :index
			expect(response.status).to eq(200) 
		end

		it 'responds with a list of the current attributes' do
			get :index
			json = JSON.parse(response.body)
	   		expect(json.length).to eq(1);
		end

	end

	describe '.show' do
		
		it 'get\'s an individual page' do
			get :show, :id => @venue.id

			expect(response).to be_success

			json = JSON.parse(response.body)
			 expect(json['name']).to eq(@venue.name) 
		end

	end

end