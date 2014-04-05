class API::V1::UserController < ApplicationController

	doorkeeper_for :all,:except => :register
	# after_filter only: [ :feed ] { paginate(:events) }

	protect_from_forgery except: :index

	def index 
		render json: current_resource_owner, except: [:enc_password, :salt]
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
=begin
		Get all of the events similar
		usersEvents = EventUser.find(current_resource_owner)
		EventUser.where(EVENT_ID contains userEvents),group(USER_ID)

		Find % difference

		Loop through found users
		Check array of ints against the users  -> Find % similarity (Add to hash)?
		
		FInd the events a user is not following that the top 10% similar are + include ones that the user is following -> (Personal feed)
=end

		@events ||= Array.new
		#Get all of the users following events
		userEvents = current_resource_owner.events;
		#Get the similar users events (SQL for optimisation)
		usersEvents = User.joins(:events).find_each(:conditions => { 'events.id' => userEvents }) do | user |
			#Check if it's the same as the current user		
			if user != current_resource_owner
				#Remove the users events already following
				@events.concat(user.events - userEvents);
				#Sort and output
				@events = @events.group_by { |e | e }.sort_by{| e | e[1].count}.map{|e, i| e }.reverse.take(10);
			end
		end

		@events = @events | userEvents

		render json: @events.uniq;
	end

	def register 
		user = User.new(user_params)
		if user.save 
			render json: {:message => "User created", :user => user};
		else 
			render json: {:error => user.errors.full_messages} 
		end
	end

	private
		def current_resource_owner
			User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
		end

		def user_params
			params.require(:user).permit(:id, :first_name, :last_name, :email, :password)
		end

end