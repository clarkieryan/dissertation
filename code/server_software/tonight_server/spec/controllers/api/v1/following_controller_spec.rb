require 'spec_helper'

describe API::V1::FollowingController do 
	
	let (:user) {FactoryGirl.create(:user)}
	let(:event){FactoryGirl.create(:event)}
	let(:token) { double :accessible? => true, :resource_owner_id => user.id }

	before do	
		allow(controller).to receive(:doorkeeper_token){token}
	end

	describe '.index' do

		it 'responds with 200' do
			get :index
			expect(response.status).to eq(200)
		end

		pending('responds with events logged in user follows')
	end

	describe ".followEvent" do

		it "responds with success" do
			post :followEvent, :id => event.id
			usersEvents = EventUser.all;
			jsonResponse = JSON.parse(response.body)
			expect(jsonResponse['code']).to eq("201"); 
		end
			
	end

	pending('Implement the following venue stuff');

end