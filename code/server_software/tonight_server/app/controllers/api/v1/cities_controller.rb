class API::V1::CitiesController < ApplicationController

	doorkeeper_for :all

	def index 
		cities = City.order('name ASC');
		render json: cities;
	end

	def show
		city = City.find(params[:id])
		render json: city;
	end

end