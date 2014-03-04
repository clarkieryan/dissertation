class API::V1::EventsController < ApplicationController

	def index
		venue = Venue.find(params['venue_id']);
		events  = venue.events
		render json: events
	end

	def show 
		venue = Venue.find(params['venue_id']);
		events= venue.events.find(params['id'])
		render json: events
	end

end