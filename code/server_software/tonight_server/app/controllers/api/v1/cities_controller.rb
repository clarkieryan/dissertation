class API::V1::CitiesController < ApplicationController

	doorkeeper_for :all

	def index 
		cities = City.order('name ASC');
		render json: cities;
	end

end