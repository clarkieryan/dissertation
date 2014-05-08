require 'spec_helper'

describe API::V1::CategoriesController do 
	
	let (:user) {FactoryGirl.create(:user)}
	let(:token) { double :accessible? => true, :resource_owner_id => user.id }

	before do	
	 	allow(controller).to receive(:doorkeeper_token){token}
	end

	describe '.index' do

		it "should return 200" do
			get :index
			expect(response.code).to eq("200")
		end

		#TODO - Add test to add show the sorted categories

	end

	describe '.catsByCity' do

		it 'should list the categories by city' do
			FactoryGirl.create(:city);
			event = FactoryGirl.create(:event_with_category)
			get :catsByCity, city_id: event.venue.city[:id];
			#TODO - Update to expect the city events
			expect(response.body).to eq(event.categories.to_json);
		end

	end

end