class API::V1::FollowingController < ApplicationController

	#Responds with events the logged in user is followinf
	def index 
		render json: current_resource_owner.events
	end

	#Follow an event
	def followEvent
		
	end

	def followVenue

	end

	private
		def current_resource_owner
			User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
		end

end