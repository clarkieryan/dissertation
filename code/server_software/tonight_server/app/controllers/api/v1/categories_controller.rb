class API::V1::CategoriesController  < ApplicationController

	doorkeeper_for :all	

	def index 
		cats = Category.find(:all, :order => "name");
		render json: cats;
	end

	def show 
		cat = Category.find(params[:id])
		render json: cat;
	end

	#Get categories by city
	def catsByCity
		city = City.joins(:venues).find(params[:city_id]);
		cats = Category.joins(:events).where('events.venue_id' => city.venues).group('categories.id');
		render json: cats;
	end

end