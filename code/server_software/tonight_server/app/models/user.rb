require 'digest/sha1'
#http://security.stackexchange.com/questions/4781/do-any-security-experts-recommend-bcrypt-for-password-storage
class User < ActiveRecord::Base

	before_save :encrypt_password
	after_save :clear_password

	attr_accessor  :password

	#EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, :uniqueness => true
	validates :password, presence: true
	validates_length_of :password, :in => 6..20, :on => :create

	has_and_belongs_to_many :events


	def name 
		return "#{first_name} #{last_name}"
	end

	def self.authenticate(email, password)
		user  = User.where(email: email);
		if(user.count == 1 ) 
			encrypted_password = BCrypt::Engine.hash_secret(password, user[0].salt)
			if(user[0].enc_password == encrypted_password)
				return user[0];
			else 
				return false;
			end
		else 
			return false;
		end
	end

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.enc_password= BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def clear_password
		password = nil
	end
end