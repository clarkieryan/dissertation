class API::V1::FollowingController < ApplicationController

	doorkeeper_for :all
	after_filter only: [:index] { paginate(:events) }
	protect_from_forgery except: :followEvent

	#Responds with events the logged in user is following
	def index 
		@events = current_resource_owner.events;
		render json: @events, only: [:id, :name]
	end

	#Follow an event
	def followEvent
		relation  = current_resource_owner.follow!(event_params[:id]);
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
		def event_params
			params.require(:event).permit(:id, :name)
		end

		def current_resource_owner
			User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
		end

end