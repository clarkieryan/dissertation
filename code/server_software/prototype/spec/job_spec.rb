require_relative "../lib/scheduler/job";


require 'yaml'
require "json"
require 'spec_helper'

describe Job do
	
	before :each do
		@filters = {"location" => [52, 0.4], "keyword" => "chinese"};
		@job = Job.new("facebook", @filters);
	end

	it "Instantiates a class" do
		expect(@job).to be_a Job
	end

	it "creates variable with the api to use" do
	 	expect(@job.getAPI).to eq("facebook");
	end

	it 'creates a variable of the filters to use' do
		expect(@job.getFilters).to eq(@filters);
	end

	it 'starts a job, with the set api and filters' do
		facebook = @job.startJob
		expect(facebook).to be_a Facebook
	end

end