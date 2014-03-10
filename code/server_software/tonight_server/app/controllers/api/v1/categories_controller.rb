class API::V1::CategoriesController  < ApplicationController

	doorkeeper_for :all	

	def index 
		cats = Category.find(:all, :order => "cat_name");
		render json: cats;
	end

end