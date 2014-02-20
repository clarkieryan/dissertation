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

		it 'redirects to the index page' do
			jobDetails = FactoryGirl.attributes_for(:job);
			post :create, job: jobDetails
			expect(response).to redirect_to(:action => "index")
		end

		it 'shows flash message when an error occurs' do
			pending "Implement this"
		end

		it 'shows flash when succesfully added' do
			jobDetails = FactoryGirl.attributes_for(:job);
			post :create, job: jobDetails
			expect(flash[:success]).to eq("Job added")  
		end

	end

	describe '.destroy' do
		
		it 'redirects to index page after deletion' do
			jobInstance = FactoryGirl.create(:job)
			delete :destroy, :id => jobInstance[:id]
			expect(response).to redirect_to(:action => "index")
		end

		it 'removes the correct job' do
			jobInstance = FactoryGirl.create(:job)
			delete :destroy, :id => jobInstance[:id]
			expect(Job.all.count).to eq(0);
		end

	end


end