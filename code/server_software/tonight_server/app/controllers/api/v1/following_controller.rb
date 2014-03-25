class API::V1::FollowingController < ApplicationController

	doorkeeper_for :all

	#Responds with events the logged in user is followinf
	def index 
		render json: current_resource_owner.events
	end

	#Follow an event
	def followEvent
		relation  = current_resource_owner.follow!(params[:id]);
		if relation.errors.any?
			render json: {:error => "400", :message => relation.errors.full_messages}
		else 
			render json: {:code => "201", :message => "User is now following event"}
		end
	end

	#Implement later
	def followVenue

	end

	private
		def current_resource_owner
			User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
		end

end