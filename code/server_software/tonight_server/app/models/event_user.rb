class EventUser < ActiveRecord::Base

	belongs_to :events
	belongs_to :users

	validates_uniqueness_of :event_id, :scope => :user_id
	
end