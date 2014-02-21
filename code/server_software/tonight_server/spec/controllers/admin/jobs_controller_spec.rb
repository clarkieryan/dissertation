require 'spec_helper'

describe Admin::JobsController do

	describe '.index' do
		it "responds succesfully with a 201" do
			get :index
			expect(response).to be_success
			expect(response.status).to eq(200)
		end

		it "renders the index template" do
			get :index
			expect(response).to render_template("index")
		end

		it "produces a set of jobs" do
			job = FactoryGirl.create(:job)
			get :index
			 expect(assigns(:jobs)).to eq([job]);
		end
	end

	describe '.create' do

		before :each do
			@jobDetails = FactoryGirl.attributes_for(:job);
		end

		it 'redirects to the index page' do
			post :create, job: @jobDetails
			expect(response).to redirect_to(:action => "index")
		end

		it 'shows flash message when an error occurs' do
			pending "Implement this"
		end

		it 'shows flash when succesfully added' do
			post :create, job: @jobDetails
			expect(flash[:success]).to eq("Job added")  
		end

	end

	describe '.update' do

		before :each do
			@jobInstance = FactoryGirl.create(:job);
		end

		it 'redirects to the index page after an update' do
			# jobInstance = FactoryGirl.create(:job);
			# jobInstance[:name] = "Edited Job jobInstance";
			# put :update, :job => jobInstance
			# expect(response).to  redirect_to('index') 
		end

		it 'updates a record' do
			prev_updated = @jobInstance[:updated_at]
			@jobInstance[:name] = "Edited job";
			put :update, :job => {:name => "test"}, :id => @jobInstance[:id]
			@jobInstance.reload
			expect(@jobInstance[:updated_at]).tocl_not eql(prev_updated)
		end

	end

	describe '.destroy' do
		
		before :each do 
			@jobInstance = FactoryGirl.create(:job)
		end

		it 'redirects to index page after deletion' do
			delete :destroy, :id => @jobInstance[:id]
			expect(response).to redirect_to(:action => "index")
		end

		it 'removes the correct job' do
			delete :destroy, :id => @jobInstance[:id]
			expect(Job.all.count).to eq(0);
		end

	end

end