require 'position_mover'
class Subject < ApplicationRecord
	
	include PositionMover

	has_many :pages, foreign_key: "subjects_id" #Use for One to Many Association NB :pages
	
	#has_one :page, foreign_key: "subjects_id" 	#Use for One to One Association NB :page
	#has_many :page, foreign_key: "subjects_id"

	#NAME_REGEX = /\A[a-zA-Z0-9]*\z/ # This Name regExp does not allows
	NAME_REGEX = /\A([\w\s\.%\+\-]*)\Z/i # This Name regExp allows space and hyphen
	#To validates special Characters from entering name
	
  	#Here using "sexy" validation method
  	validates :name, :presence => true, :length => {:maximum => 255},
  		:uniqueness => true, :format => NAME_REGEX

  	#Using scope
  	scope :visible, -> {where(:visible => true)}
  	scope :invisible, -> {where(:visible => false)}
	scope :sorted, -> {order('subjects.position ASC')}	
	scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

	#scope :newname, -> {select('name','visible')}		 
	# How to select only one column eg. subjects = Subject.select('column_name')
	
end
