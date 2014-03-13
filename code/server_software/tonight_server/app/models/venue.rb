class Venue < ActiveRecord::Base

	has_many :events
	belongs_to :cities, :foreign_key => "city"

	validates :ref_id,  uniqueness: true
end
