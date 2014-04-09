class Event < ActiveRecord::Base
	
	
	belongs_to :venue
	cattr_accessor :current_user

	has_and_belongs_to_many :categories
	has_and_belongs_to_many :users,  -> { uniq }
	
	validates :ref_id, uniqueness: true

	def following(user = nil)
		 user ||= current_user
		if self.users.where(:id => user.id).empty?
			return true
		else
			return false;
		end
	end

end
