require 'spec_helper'

describe "admin/jobs/index" do

	before :each do
		FactoryGirl.create(:job);
		assign(:jobs, Job.all)
		assign(:available_apis, Job::VALID_MODULES)
	end

	it "displays all the jobs" do
		render
		expect(rendered).to include("Facebook Test")
	end

	it 'displays the available apis' do
		FactoryGirl.create(:job);
		render
		expect(rendered).to include('facebook')
	end

  end