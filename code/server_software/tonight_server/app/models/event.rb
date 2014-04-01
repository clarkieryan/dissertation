class Event < ActiveRecord::Base
	
	
	belongs_to :venue

	has_and_belongs_to_many :categories
	has_and_belongs_to_many :users,  -> { uniq }
	
	validates :ref_id, uniqueness: true


end
