require "spec_helper"
require 'rake'

describe "RunJobs" do
	
	before :each do
		Rake.application.rake_require "tasks/scheduler"
    		Rake::Task.define_task(:environment)
	end

	let :run_rake_task do
		Rake::Task['scheduler:RunJobs'].invoke
	end

	it 'Outputs all the jobs' do 
		#Stub the oAuth request
		stub_request(:get, "https://graph.facebook.com/oauth/access_token?client_id=230119533786354&client_secret=2021cab2843592bfaee52fa8e0ea001e&grant_type=client_credentials&redirect_uri=http://localhost").to_return(:status => 200, :body => "access_token=dmmsddd|ndm;nnl", :headers => {})
		#Stub the venue request
		venues = File.read('spec/fixtures/facebook/venues.json');
		stub_request(:get, "https://graph.facebook.com/search?access_token=dmmsddd%7Cndm%3Bnnl&center=52.29,-1.52&distance=50&q=club&type=page").to_return(:status => 200, :body => venues, :headers => {})



		FactoryGirl.create(:job)
		Rake::Task['scheduler:run_jobs'].invoke
		:run_rake_task
		
	end

end