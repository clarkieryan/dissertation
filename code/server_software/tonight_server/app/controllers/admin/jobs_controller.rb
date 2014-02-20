class Admin::JobsController < Admin::BaseController

	before_filter :admin_required;

	#Index will list the various jobs here
	def index 
		@jobs = Job.all;
	end

	#Create a new job
	def create 

	end

	#Updates a job
	def update

	end

	#Removes a job
	def destroy

	end

end
