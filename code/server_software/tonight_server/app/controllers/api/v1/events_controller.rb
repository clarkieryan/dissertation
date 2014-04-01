class API::V1::EventsController < ApplicationController

	doorkeeper_for :all
	after_filter only: [:index, :eventsByVenue, :eventsByCity, :eventsByCategory] { paginate(:events) }
	
	def index
		@events  = Event.all
		render json: @events.to_json(:methods => :following)
	end

	def eventByID
		event = Event.find(params[:id])
		render json: event
	end

	def eventsByVenue 
		venue = Venue.find_by_id(params[:id]);
		@events= venue.events
		render json: @events
	end

	def eventsByCity
		city = City.find(params[:id]);
		venues = city.venues.all
		@events = Event.where(:venue_id => venues);
		render json: @events;
	end

	def eventsByCategory
		category = Category.find(params[:id]);
		@events = category.events.all
		render json: @events;
	end

	private
		def current_resource_owner
			User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
		end



end