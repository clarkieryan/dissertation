class API::V1::EventsController < ApplicationController

	doorkeeper_for :all
	
	def index
		events  = Event.all
		render json: events
	end

	def eventByID
		event = Event.find(params[:id])
		render json: event
	end

	def eventsByVenue 
		venue = Venue.find(params[:id]);
		events= venue.events.all
		render json: events
	end

	def eventsByCity
		city = City.find(params[:id]);
		events = city.events.all
		render json: city;
	end

	def eventsByCategory
		category = Category.find(params[:id]);
		events = category.events.all
		render json: events;
	end

end