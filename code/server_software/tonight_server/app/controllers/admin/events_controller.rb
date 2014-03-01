class Admin::EventsController < Admin::BaseController

	def index 
		@events = Event.all
	end

	def create 
		@event = Event.new
		if @event.save 
			flash[:success] = "Event added"
			redirect_to :action => "index"
		else
			flash[:danger] = "Something went wrong"
			redirect_to :action => "index"
		end
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			render json: @job
		else 
			flash[:danger] = "something went wrong"
			redirect_to :action => 'index'
		end
	end

	def destroy
		if Event.destroy(params[:id])
			flash[:success] = "Event #{params[:id]} has been deleted"
		else
			flash[:danger] = "Something went wrong"
		end
		redirect_to :action => "index"
	end

	private
		def event_params
			params.require(:event).permit();
		end

end
