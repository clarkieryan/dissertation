require 'spec_helper'

describe Admin::UsersController do

	describe '.index' do

		it"responds successfully with a 201" do
			get :index
			expect(response).to be_success
			expect(response.status).to eq(200);  
		end

		it "renders the index template" do
			get :index
			expect(response).to render_template("index") 
		end

	end

	describe '.create' do

		before :each do 
			@user = FactoryGirl.attributes_for(:user);
		end

		it 'redirects to the index page' do
			post :create, user: @user;
			expect(response).to redirect_to(:action => "index");
		end

		it "shows flash message when an error occurs" do
			user = FactoryGirl.attributes_for(:user);
			user[:password] = "";
			post :create, user: user
			expect(flash[:danger]).to eq("Something went wrong");
		end  

		it "shows flash when successfully added" do
			post :create, user: FactoryGirl.attributes_for(:user);
			expect(flash[:success]).to eq("User added");
		end
	end

	describe '.update' do

		before :each do
			@user = FactoryGirl.create(:user);
		end

		pending('redirects to the index page' )

		it 'updates a record' do
			prev_updated = @user[:updated_at];
			put :update, :user => {:first_name => "Bob"}, :id => @user[:id];
			@user.reload;
			expect(@user[:updated_at]).to_not eq(prev_updated);
		end

	end

	describe '.destroy' do

		before :each do
			@user = FactoryGirl.create(:user);
		end

		it 'redirects to the index page' do
			delete :destroy, :id => @user[:id];
			expect(response).to redirect_to(:action => "index");
		end

		it 'removes the correct user' do
			delete :destroy, :id => @user[:id];
			expect(Job.all.count).to eq(0);
		end

	end

end
