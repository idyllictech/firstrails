require 'digest/sha1'   
#This require is used to set the hashing encryption of users password
class AdminUser < ApplicationRecord		
	has_and_belongs_to_many	:pages #this below is used to define the joining table(s) admin_user and page
	has_many :section_edits,  foreign_key: "admin_users_id"
	has_many :sections, :through => :section_edits

	
	attr_accessor :password
	#This is called non-database attribute, which means it has no value in the db

	#validation of user 

	#Validating format of email using email regular exptressions
	#EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i #Old Email reular expression

	#New Email reular expression
	EMAIL_REGEX = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\Z/i
  
	# standard validation methods  	
	# validates_presence_of :first_name
	# validates_length_of :first_name, :maximum => 25
	# validates_presence_of :last_name
	# validates_length_of :last_name, :maximum => 50
	# validates_presence_of :username
	# validates_length_of :username, :within => 8..25
	# validates_uniqueness_of :username
	# validates_presence_of :email
	# validates_uniqueness_of :email
	# validates_length_of :email, :maximum => 100
	# validates_format_of :email, :with => EMAIL_REGEX	
	# validates_confirmation_of :email


	# New "sexy" validation Methods
	validates :last_name, :presence => true, :length => { :maximum => 50 }
	validates :first_name, :presence => true, :length => { :maximum => 25 }  	
  	validates :username, :length => { :within => 8..25 }, :uniqueness => true
  	validates :email, :presence => true, :length => { :maximum => 100 }, 
    :format => EMAIL_REGEX, :confirmation => true


    # only on create, so other attributes of this user can be changed
  	validates_length_of :password, :within => 8..25, :on => [:create, :update]

  	before_save :create_hashed_password 
  	after_save :clear_password
  	after_update :clear_password

  	#here to before_save and after_save are the callbacks of rails in validation/database inter

  	#Note here the above accept the hashed_password from user as password 
  	# the above is used to convert/create it to the hashed_password


	scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}
	scope :sorted, -> {order("admin_users.last_name ASC, admin_users.first_name ASC")}
	#scope :named, lambda {|first,last| where(["first_name LIKE ?", "%#{first}%"]).where(["last_name LIKE ?", "%#{last}%"])}
	#scope :named, lambda {|query| where(["first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", "%#{query}%","%#{query}%","%#{query}%"])}
	#The above is used for searching through three different column for one parameter

	#This is how to define a simple model named :name
	def name
		"#{first_name} #{last_name}"
	end
	
	# Authenticate User Method

	def self.authenticate(username="", password="")
	    user = AdminUser.find_by_username(username)
	    if user && user.password_match?(password)
	      return user
	    else
	      return false
	    end
  	end

  	# The same password string with the same hash method and salt
	# should always generate the same hashed_password.
	def password_match?(password="")
	    hashed_password == AdminUser.hash_with_salt(password, salt)
	end

	#Authenticating using hashing salting the password

	#Salting the password of the user for hih level security
	def self.make_salt(username="")
		Digest::SHA1.hexdigest("use #{username} with #{Time.now} to make salt")
	end

	def self.hash_with_salt(password="", salt="")
		Digest::SHA1.hexdigest("Put #{salt} on the #{password}")	
	end

	#Hashing the password alone without salting
	# def self.hash(password="")
	# 	Digest::SHA1.hexdigest(password)
	# end


	 private
  
	  def create_hashed_password
	    # Whenever :password has a value hashing is needed
	    unless password.blank?
	      # always use "self" when assigning values
	      self.salt = AdminUser.make_salt(username) if salt.blank?
	      self.hashed_password = AdminUser.hash_with_salt(password, salt)
	    end
	  end

	  def clear_password
	    # for security and b/c hashing is not needed
	    self.password = nil
	  end

	 
end
