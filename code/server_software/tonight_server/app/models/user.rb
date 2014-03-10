require 'digest/sha1'
#http://security.stackexchange.com/questions/4781/do-any-security-experts-recommend-bcrypt-for-password-storage
class User < ActiveRecord::Base

	before_save :encrypt_password
	after_save :clear_password

	attr_accessor  :password_in

	#EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, :uniqueness => true
	validates :password_in, presence: true
	validates_length_of :password_in, :in => 6..20, :on => :create

	def name 
		return "#{first_name} #{last_name}"
	end

	def self.authenticate(email, password)
		user  = User.where(email: email);
		if(user.count == 1 ) 
			encrypted_password = BCrypt::Engine.hash_secret(password, user[0].salt)
			if(user[0].password == encrypted_password)
				return true;
			else 
				return false;
			end
		else 
			return false;
		end
	end

	def encrypt_password
		if password_in.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password= BCrypt::Engine.hash_secret(password_in, salt)
		end
	end

	def clear_password
		password_in = nil
	end
end