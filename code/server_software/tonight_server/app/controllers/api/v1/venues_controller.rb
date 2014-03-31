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
		city = City.find(params[:city_id])
		@venues = city.venues
		render json: @venues;
	end

end