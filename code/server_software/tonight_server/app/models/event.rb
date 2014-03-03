class Event < ActiveRecord::Base

	belongs_to :venue

	validates :ref_id, uniqueness: true

end
