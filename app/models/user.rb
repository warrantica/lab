class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password

	before_save { |user| user.email = email.downcase }

	validates :name, presence: true, length: { maximum: 50 }
	VALIDATE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
		format: { with: VALIDATE_EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true


end
