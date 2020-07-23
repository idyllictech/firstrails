require 'position_mover'
class Page < ApplicationRecord
	
	include PositionMover

	belongs_to :subject, foreign_key: "subjects_id"
	has_many :sections,  foreign_key: "pages_id" 
	accepts_nested_attributes_for :subject

	# July 03, 2020 Note below this is used for Nested association forms
	# We Add the accepts_nested_attributes_for method to the model that our main form is for, 
	# in our example, Pages.
	# This is a class method that defines an attribute writer for the specified association (subjects).
	

	# This below is used to define the joining table(s) admin_user and page
	has_and_belongs_to_many	:editors, :class_name => "AdminUser"

	#validation Processes
	# validates_presence_of :name
	# validates_length_of :name, :maximum => 255
	# validates_presence_of :permalink
	# validates_length_of :permalink, :within => 3..255
  	# use presence with length to disallow spaces
  	#validates_uniqueness_of :permalink
    # for unique values by subject, :scope => :subject_id
	

	#Using "sexy" validation methods
	validates :name, :presence => true, :length => {:maximum => 255}
	validates :permalink, :presence => true, :length => {:within => 3..255},
		:uniqueness => true

	
	scope :visible, -> {where(:visible => true)}
  	scope :invisible, -> {where(:visible => false)}
	scope :sorted, -> {order('pages.position ASC')}

	private
	def position_scope
		"pages.subjects_id = #{subjects_id.to_i}"
	end
end
