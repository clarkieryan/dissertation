require 'spec_helper'

describe Admin::EventsController do

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
			@event = FactoryGirl.attributes_for(:event)
		end

		it 'redirects to the index page' do
			post :create, event: @event;
			expect(response).to redirect_to(:action => "index")
		end

		pending("shows flash message when an error occurs");

		it "shows flash when successfully added" do
			post :create, event: @event;
			expect(flash[:success]).to eq("Event created");
		end			

	end

	describe '.update' do

		before :each do
			@event = FactoryGirl.create(:event);
		end

		pending('redirects to index after update');

		it 'updates a record' do
			prev_updated = @event[:updated_at];
			put :update, :event => {:name => "New name"}, :id => @event[:id];
			@event.reload;
			expect(@event[:updated_at]).to_not eq(prev_updated);
		end
	end


	describe '.destroy' do

		before :each do
			@event = FactoryGirl.create(:event);
		end

		it 'redirects to the index page' do
			delete :destroy, :id => @event[:id];
			expect(response).to redirect_to(:action => "index");
		end

		it 'removes the correct user' do
			delete :destroy, :id => @event[:id];
			expect(Event.all.count).to eq(0);
		end

	end

end
