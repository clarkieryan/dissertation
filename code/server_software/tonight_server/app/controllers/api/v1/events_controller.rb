class API::V1::EventsController < ApplicationController

	#Add in OAuth for all route
	doorkeeper_for :all
	before_filter :set_current_user
	#Add in pagination
	after_filter only: [:index, :eventsByVenue, :eventsByCity, :eventsByCategory] { paginate(:events) }
	
	
	def index
		@events  = Event.all
		render json: @events, :methods => :following
	end

	def eventByID
		event = Event.find(params[:id])
		render json: event, :methods => :following
	end

	def eventsByVenue 
		venue = Venue.find_by_id(params[:id]);
		@events= venue.events
		render json: @events, :methods => :following
	end

	def eventsByCity
		city = City.find(params[:id]);
		venues = city.venues.all
		@events = Event.where(:venue_id => venues);
		render json: @events, :methods => :following
	end

	def eventsByCategory
		category = Category.find(params[:id]);
		@events = category.events.all
		render json: @events, :methods => :following
	end

	private
		def current_resource_owner
			User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
		end

		def set_current_user 
			Event.current_user = current_resource_owner
		end


end