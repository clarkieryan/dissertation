class API::V1::VenuesController < ApplicationController

	doorkeeper_for :all
	
	def index
		@venues = Venue.all
		render json: @venues;
			
	end

	def show
		@venue = Venue.find(params[:id])
		render json: @venue;
	end

end