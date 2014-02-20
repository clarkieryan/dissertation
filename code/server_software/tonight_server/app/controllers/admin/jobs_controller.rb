class Admin::JobsController < Admin::BaseController

	before_filter :admin_required;

	#Index will list the various jobs here
	def index 
		@jobs = Job.all;
		@available_apis = ["facebook", "googlePlaces"];
	end

	#Create a new job
	def create 
		@job = Job.new(job_params)
		if @job.save
			flash[:success] = "Job added"
			redirect_to :action => "index"
		else 
			flase[:danger] ="Something went wrong"
			redirect_to :action => "index"
		end
	end

	#Updates a job
	def update
		
	end

	#Removes a job
	def destroy
		Job.find(params[:id]).destroy
		flash[:success] = "Job #{params[:id]} deleted"
		redirect_to :action => "index"
	end

	private 
		def job_params 
			params.require(:job).permit(:id, :name, :desc, :api, :filters, :toe);
		end

end
