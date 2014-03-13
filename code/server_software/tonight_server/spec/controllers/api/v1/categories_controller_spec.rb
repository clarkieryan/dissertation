require 'spec_helper'

describe API::V1::UserController do 
	
	let (:user) {FactoryGirl.create(:user)}
	let(:token) { double :accessible? => true, :resource_owner_id => user.id }

	before do	
	 	controller.stub(:doorkeeper_token) { token }
	end

	describe '.index' do

		it "should return 200" do
			get :index
			expect(response.code).to eq("200")
		end

	end

	describe '.catsByCity' do

		it 'should list the categories by city' do
			venue = FactoryGirl.create(:venue)
			event = FactoryGirl.build_attributes(:event)
			get :catsByCity 
			event  = venue.create(event);
			puts venue

		end

	end

end