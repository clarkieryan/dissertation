class API::V1::UserController < ApplicationController

	doorkeeper_for :all

	def index 
		render json: current_resource_owner
	end

	def update 
		user = User.find(params[:id])
		if user.update(user_params) 
			render json: user
		else
			render json: {:message => user.errors}
		end	
	end

	def feed 
		render json: {:message => "To be implemented"}
	end

	private
		def current_resource_owner
			User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
		end

		def user_params
			puts params;
			params.require(:user).permit(:id, :first_name, :last_name, :email, :password)
		end

end