class Venue < ActiveRecord::Base

	has_many :events

	validates :ref_id,  uniqueness: true
end
