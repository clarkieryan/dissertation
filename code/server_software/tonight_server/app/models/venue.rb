class Venue < ActiveRecord::Base

	has_many :events
	belongs_to :city

	validates :ref_id,  uniqueness: true
end
