class CategoryEvent < ActiveRecord::Base

	belongs_to :events
	belongs_to :categories
	
end