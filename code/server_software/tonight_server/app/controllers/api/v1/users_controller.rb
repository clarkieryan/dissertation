class API::V1::UsersController < ApplicationController

	def index 

		@users = User.all
		render json: @users;
	end

	#Function to authorise a user
	def authorise
		

		#Set's a session
	end

	private 
		def user_params
			params.require(:user).permit(:usernamer, :password);
		end
end