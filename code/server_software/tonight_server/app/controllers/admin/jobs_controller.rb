class Admin::JobsController < Admin::BaseController

	before_filter :admin_required;

	#Index will list the various jobs here
	def index 
		@jobs = Job.all;
		@available_apis = Job::VALID_MODULES.to_a;
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
		@job = Job.find(params[:id])
		if @job.update(job_params)
			render json: @job
		else 
			flash[:danger] = "Something went wrong editing that job"
			redirect_to :action => 'index'
		end
	end

	#Removes a job
	def destroy
		if Job.find(params[:id]).destroy
			flash[:success] = "Job #{params[:id]} deleted"
		else 
			flash[:danger] ="Something went wrong deleting that record"
		end
		redirect_to :action => "index"
	end

	private 
		def job_params 
			params.require(:job).permit(:id, :name, :desc, :api, :filters, :toe);
		end

end
