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
			@venues.each_with_index do | venue, index |
			 	#Progress indicator if in development mode
				if Rails.env.production?
				 	system "clear" or system "cls"
				 	puts "#{index}/#{@venues.count}"
				 	puts venue['name']
				end
				#Create the venue object to be inputted
				venueDetails = @api_instance.buildVenue(@api_instance.getVenue(venue['id']));
				#Add the venue to the DB. 
				@newVenue = Venue.where(venueDetails).first_or_create
				#Get all the events at the current venue
			 	@events = @api_instance.getEvents(venue['id']);
			 	#Loop through and get event details
			 	@events.each do | event |
			 		#Get the event details and do stuff with it.
			 		eventDetails = @api_instance.buildEvent(@api_instance.getEvent(event['id']));
			 		@newEvent = @newVenue.events
			 		@newEvent.where(eventDetails).first_or_create
			 	end
			end
			job.update({:completed => true});
		end

	end
end