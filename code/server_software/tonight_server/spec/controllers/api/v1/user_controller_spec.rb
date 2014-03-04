require 'spec_helper'

describe API::V1::UserController do 

	before :each do
		@user = FactoryGirl.create(:user)
	end
	
	describe '.index' do

		it 'error if the user is not authorised' do
			get :index
			expect(response.body).to eq({"error" : "You need to pass authorisation"});
		end

		it 'shows relevant access tokens for OAuth' do
			
		end

	end

	describe '.show' do
		
		it 'get\'s an individual page' do
			get :show :id => @user.id

			expect(response).to be_success

			json = JSON.parse(response.body)
			 expect(json['name']).to eq(@event.name) 
		end

	end

end