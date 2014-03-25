require 'spec_helper'

describe API::V1::CitiesController do
  	
	let (:user) {FactoryGirl.create(:user)}
	let(:token) { double :accessible? => true, :resource_owner_id => user.id }

	before do	
	 	allow(controller).to receive(:doorkeeper_token){token}
	end

	describe 'index' do
		
		it 'should return a 200' do
			get :index;
			expect(response.code).to eq("200");
		end


	end

end