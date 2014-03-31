require 'spec_helper'

describe API::V1::EventsController do 

	let (:user) {FactoryGirl.create(:user)}
	let(:event){FactoryGirl.create(:event)}
	let(:token) { double :accessible? => true, :resource_owner_id => user.id }

	before :each do
		allow(controller).to receive(:doorkeeper_token){token}
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

	describe '.eventByID' do
		
		it 'get\'s an individual page' do
			get :eventByID, :id => @event.id
			expect(response).to be_success
			 expect(response.body).to eq(@event.to_json) 
		end

	end

	describe '.eventsByVenue' do

		it 'gets the events by venue' do
			get :eventsByVenue, :id => @venue.id
			expect(response.body).to eq(@venue.events.to_json)
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