class Admin::StaticController < ApplicationController
	#Set the layout to be admin
	layout 'admin'

	#Ensure they are authorised - Can be replaced with proper auth
	before_filter :admin_required;

	def index 
		
	end

end