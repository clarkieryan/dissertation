class Admin::BaseController < ApplicationController
	#Set the default layout to be the admin 
	layout 'admin'
	#Ensure authenticaiton for all pages
	before_filter :admin_required;
end