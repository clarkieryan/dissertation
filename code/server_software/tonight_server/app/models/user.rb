class User < ActiveRecord::Base

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	validates :password, presence: true

	def name 
		return "#{first_name} #{last_name}"
	end

end
# t.string :first_name
# t.string :last_name
# t.string :password
# t.string :email