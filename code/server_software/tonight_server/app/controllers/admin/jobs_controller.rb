class Admin::JobsController < Admin::BaseController

	before_filter :admin_required;

	#Index will list the various jobs here
	def index 
		@jobs = Job.all;
		@available_apis = ["facebook", "googlePlaces"];
	end

	#Create a new job
	def create 
		render :json => job_params
	end

	#Updates a job
	def update

	end

	#Removes a job
	def destroy

	end

	private 
		def job_params 
			params.require(:job).permit(:name, :desc, :api, :filters, :toe);
		end

end
