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
		stub_request(:get, "https://graph.facebook.com/search?access_token=dmmsddd%7Cndm%3Bnnl&center=52.4796,-1.9030&distance=50&q=Birmingham%20Night%20Clubs&type=page").to_return(:status => 200, :body => venues, :headers => {})

		venue = File.read('spec/fixtures/facebook/venue.json');
		stub_request(:get, "https://graph.facebook.com/224699987546240/?access_token=dmmsddd%7Cndm%3Bnnl").to_return(:status => 200, :body => venue, :headers => {});

		events = File.read('spec/fixtures/facebook/events.json')
		stub_request(:get, "https://graph.facebook.com/224699987546240/events/?access_token=dmmsddd%7Cndm%3Bnnl").to_return(:status => 200, :body => events, :headers => {});

		event = File.read('spec/fixtures/facebook/event.json')
		stub_request(:get, "https://graph.facebook.com/204504813084059/?access_token=dmmsddd%7Cndm%3Bnnl").to_return(:status => 200, :body => event, :headers => {});
		    

		FactoryGirl.create(:job)
		Rake::Task['scheduler:RunJobs'].invoke
		#:run_rake_task

	end

end