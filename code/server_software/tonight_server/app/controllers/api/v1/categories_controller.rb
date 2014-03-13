class API::V1::CategoriesController  < ApplicationController

	#doorkeeper_for :all	

	def index 
		cats = Category.find(:all, :order => "name");
		render json: cats;
	end

	#Get categories by city
	def catsByCity
		city = City.find(params[:city_id]);
		venues = city.venues.all
		cats = Category.joins(:events).where('events.venue_id' => venues).group('categories.id');
		render json: cats;
	end

end