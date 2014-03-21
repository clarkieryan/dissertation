require 'spec_helper'

describe API::V1::FollowingController do 
	
	let (:user) {FactoryGirl.create(:user)}
	let(:token) { double :accessible? => true, :resource_owner_id => user.id }

	before do	
	 	controller.stub(:doorkeeper_token) { token }
	end

	describe '.index' do

		it 'responds with 200' do
			get :index
			expect(response.status).to eq(200)
		end

		it 'responds with events logged in user follows' do
			get :index
			
		end
	end

	

end