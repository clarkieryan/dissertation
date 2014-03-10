class User < ActiveRecord::Base

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, :uniqueness => true,
	validates :password, presence: true

	def name 
		return "#{first_name} #{last_name}"
	end

	def self.authenticate(email, password)
		user  = User.where(email: email, password: password)
		user.count == 1 ? (return user[0]) : (return false);
	end

end
# t.string :first_name
# t.string :last_name
# t.string :password
# t.string :email