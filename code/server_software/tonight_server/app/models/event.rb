class Event < ActiveRecord::Base

	belongs_to :venue

	has_and_belongs_to_many :categories
	
	validates :ref_id, uniqueness: true

end
