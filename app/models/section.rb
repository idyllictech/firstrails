require 'position_mover'
class Section < ApplicationRecord
	
	include PositionMover

	#belongs_to	:page, optional: true
	belongs_to	:page, foreign_key: "pages_id"	
	has_many :section_edits,  foreign_key: "sections_id" 
	has_many :editors, :through => :section_edits, :class_name => "AdminUser"


	accepts_nested_attributes_for :page
	# July 03, 2020 Note below this is used for Nested association forms
	# We Add the accepts_nested_attributes_for method to the model that our main form is for, 
	# in our example, Sections.
	# This is a class method that defines an attribute writer for the specified association (pages).


	CONTENT_TYPES = ['text','HTML']

	#validation Processes
	# validates_presence_of :name
	# validates_length_of :name, :maximum => 255
	# validates_inclusion_of :content_type, :in => CONTENT_TYPES,
	# 	:message => "must be of: #{CONTENT_TYPES.join(', ')}"
	# validates_presence_of :content


	#Using "sexy" validation method
	validates :name, :presence => true, :length => {:maximum => 255}
	validates :content_type, :inclusion => {:in => CONTENT_TYPES,
		:message => "must be of: #{CONTENT_TYPES.join(', ')}"}
	validates :content, :presence => true

	scope :visible, -> {where(:visible => true)}
  	scope :invisible, -> {where(:visible => false)}
	scope :sorted, -> {order('sections.position ASC')}

	private
	def position_scope
		"sections.pages_id = #{pages_id.to_i}"
	end
end
