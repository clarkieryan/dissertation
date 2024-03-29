require 'spec_helper'

describe API::V1::UserController do 
	
	let (:user) {FactoryGirl.create(:user)}
	let(:token) { double :accessible? => true, :resource_owner_id => user.id }

	before do	
	 	allow(controller).to receive(:doorkeeper_token){token}
	end

	describe '.index' do

		it 'responds with 200' do
			get :index
			expect(response.status).to eq(200)
		end

		it 'responds with user details' do
			get :index
			toCheck = user.to_json(:except => [:enc_password, :salt])
			expect(response.body).to eq(toCheck);
		end

	end

	describe '.update' do

		it 'Updates a users personal record' do
			@params = FactoryGirl.attributes_for(:user)
			@params[:first_name] = "test";
			put :update, user: @params, id: user[:id]
			expect(response.body).to_not eq(user.to_json)
		end
	
	end

	describe '.feed' do

		it 'responds with 200' do
			get :feed, :format => :json
			expect(response.status).to eq(200)
		end

		pending("Implement the feed")
	
	end

	describe '.register' do

		it 'adds a new user' do
			user  = FactoryGirl.attributes_for(:user);
			post :register, user: user;
			output = JSON.parse(response.body);
			expect(output['message']).to eq("User created");
		end
	
	end

end