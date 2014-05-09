require 'spec_helper'

describe Admin::VenuesController do

	describe '.index' do

		it 'responds succesfully with a 200' do
			get :index 
			expect(response).to be_success
			expect(response.status).to eq(200)
		end

		it 'renders the index template' do
			get :index
			 expect(response).to render_template("index")
		end

	end

	describe '.create' do

		before :each do
			@venue = FactoryGirl.attributes_for(:venue)
		end

		it 'redirects to the index page' do
			post :create, venue: @venue;
			expect(response).to redirect_to(:action => "index")
		end

		pending('shows flash message when an error occurs')

		it "shows flash when successfully added" do
			post :create, venue: @venue;
			expect(flash[:success]).to eq("Venue created");
		end			

	end

	describe '.update' do

		before :each do
			@venue = FactoryGirl.create(:venue);
		end

		pending('redirects to the index page')

		it 'updates a record' do
			prev_updated = @venue[:updated_at];
			put :update, :venue => {:name => "New name"}, :id => @venue[:id];
			@venue.reload;
			expect(@venue[:updated_at]).to_not eq(prev_updated);
		end
	end


	describe '.destroy' do

		before :each do
			@venue = FactoryGirl.create(:venue);
		end

		it 'redirects to the index page' do
			delete :destroy, :id => @venue[:id];
			expect(response).to redirect_to(:action => "index");
		end

		it 'removes the correct user' do
			delete :destroy, :id => @venue[:id];
			expect(Venue.all.count).to eq(0);
		end

	end

end
