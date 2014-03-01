class Admin::VenuesController < Admin::BaseController

	before_filter :admin_required;

	def  index 
		@venues = Venue.all
	end

	def create
		@venue = Venue.create(venue_params)
		if @venue.save 
			flash[:success] = "Venue created"
		else
			flash[:danger] = "Something went wrong"
		end
		redirect_to :action => "index"
	end

	def  update
		@venue = Venue.find(params[:id])
		if @venue.update(venue_params)
			render json: @venue
		else 
			flash[:danger] = "Something went wrong"
			redirect_to :action => "index"
		end 

	end

	def destroy
		if Venue.find(params[:id]).destroy
			flash[:success] = "Venue #{params[:id]} deleted"
		else 
			flash[:danger] = "Something went wrong"
		end
		redirect_to :action => "index"
	end

	private
		def venue_params
			params.require(:venue).permit()
		end


end
