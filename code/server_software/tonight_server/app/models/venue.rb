class Venue < ActiveRecord::Base

	has_many :events, dependent: :destroy

	validates :ref_id,  uniqueness: true
end
