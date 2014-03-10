class Event < ActiveRecord::Base

	belongs_to :venue
	belongs_to :cities

	has_and_belongs_to_many :categories
	
	validates :ref_id, uniqueness: true

end
