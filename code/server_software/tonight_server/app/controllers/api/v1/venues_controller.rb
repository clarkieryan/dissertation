class API::V1::VenuesController < ApplicationController

	doorkeeper_for :all

	after_filter only: [:index, :venuesByCity] { paginate(:venues) }
	
	def index
		@venues = Venue.all
		render json: @venues;
	end

	def show
		@venue = Venue.find(params[:id])
		render json: @venue;
	end

	def venuesByCity
		@venues = City.find(params[:city_id]).venues.all;
		render json: @venues;
	end

end