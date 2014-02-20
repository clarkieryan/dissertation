require 'spec_helper'

describe Admin::JobsController do

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
