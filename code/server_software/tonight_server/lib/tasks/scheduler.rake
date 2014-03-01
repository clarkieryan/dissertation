namespace :scheduler do
	
	desc "This task runs all the current jobs"
	task :RunJobs => :environment do
		
		#Needs to get only completed jobs
		@jobs = Job.all
		#Loop through the jobs
		@jobs.each do | job | 
			#Load in the correct class
			require job.api+'.rb';
			klass = job.api.camelcase.constantize;
			@api_instance = klass.new;	
			#Grab the auth tokens defined in application.rb
			api_tokens = "TonightServer::#{job.api.upcase}_API_TOKENS".constantize
			#Authorise the app
			@api_instance.setAPITokens(api_tokens);

			#Get the venues
			#Using eval as the filters value is stored as a string. 
			@venues = @api_instance.getVenues(eval(job.filters));
			 @venues['data'].each_with_index do | venue, index |
			 	#Progress indicator if in development mode
			 	if Rails.env.development?
				 	system "clear" or system "cls"
				 	puts "#{index}/#{@venues['data'].count}"
				 	puts venue['name']
				end
				#Create the venue
				venueDetails = @api_instance.getVenue(venue['id']);

				details = {:name => venueDetails['name'], :desc => venueDetails['description'], :street => venueDetails['location']['street'], :city => venueDetails['location']['city'], :county => venueDetails['location']['state'], :country => venueDetails['location']['country'], :post_code => venueDetails['location']['zip'], :lat => venueDetails['location']['latitude'], :lon => venueDetails['location']['longitude'], :phone => venueDetails['phone'], :website => venueDetails['website']}
				newVenue = Venue.create(details)
			 	@events = @api_instance.getEvents(venue['id']);
			 	#Loop through and get event details
			 	@events['data'].each do | event |
			 		#Get the event details and do stuff with it.
			 		eventDetails = @api_instance.getEvent(event['id']);
			 		record = {:ref_id => eventDetails['id'], :name => eventDetails['name'], :desc => eventDetails['description'], :start_time => eventDetails['start_time'], :end_time => eventDetails['end_time'], :timezone => eventDetails['timezone'], :updated_at => eventDetails['updated_at'] }
			 		newVenue.events.create(record)

			 	end
			 end
		end

	end
end