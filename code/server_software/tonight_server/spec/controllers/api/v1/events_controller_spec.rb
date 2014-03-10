require 'spec_helper'

describe API::V1::EventsController do 

	before :each do
		@venue = FactoryGirl.create(:venue)
		@event = FactoryGirl.create(:event, venue: @venue)
	end
	
	describe '.index' do

		it 'responds with a 200' do
			get :index, :venue_id => @venue.id
			expect(response.status).to eq(200) 
		end

		it 'responds with a list of the current attributes' do
			get :index, :venue_id => @venue.id
			json = JSON.parse(response.body)
	   		expect(json.length).to eq(1);
		end

	end

	describe '.show' do
		
		it 'get\'s an individual page' do
			get :show, :venue_id => @venue.id, :id => @event.id

			expect(response).to be_success

			json = JSON.parse(response.body)
			 expect(json['name']).to eq(@event.name) 
		end

	end

	describe '.eventsByVenue' do

		it 'gets the events by venue' do

		end
	
	end

	describe '.eventsByCity' do

		it "gets events by city" do
			
		end

	end

	describe '.eventsByCategory' do

		it "gets event by category" do
			
		end

	end

end