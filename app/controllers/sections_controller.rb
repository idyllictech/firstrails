class SectionsController < ApplicationController
	layout 'admin'

	before_action :confirm_logged_in
	before_action :find_page

	def index
		redirect_to(:controller => 'subjects')
		#list
		#render :list
	end

	def list
		#@sections = Section.order("sections.position ASC")
		@sections = Section.sorted.where(["sections.pages_id = ?", "#{params[:page_id]}"])

		# Note the "sorted" is a scope created in the model
	end

	def show
		@section = Section.find(params[:id])
	end

	 def new
	 	#This is necessary so to initiate default values to show on the text input
	 	#@section = Section.new
	 	# @section = Section.new
	 	# @section_count = Section.count + 1	 	
	 	# @section.build_page
	 	@section = Section.new({:pages_id => @page.id})
	 	@section_count = @page.sections.size + 1
	 end

	def create
		# Instantiate a new object using form parameters
		new_position = params[:section].delete(:position)		
		@section = Section.new permitted_params
		
		# Save the object
		if @section.save			
			@section.move_to_position(new_position)
			# If save succeeds, redirect to the list action	
			flash[:notice] = "New Section created."
			#redirect_to(:action => 'list', :page_id => @section.page_id)
			#redirect_to(:action => 'list', :id => @section.id, :page_id => @section.pages_id)
			redirect_to(:action => 'list', :page_id => @section.pages_id)
			#redirect_to(:controller => 'subjects')
		else
			# If save fails, redisplay the form so user can fix problems
			flash[:notice] = "ERROR: Section was not created"
			#@section_count = Section.count + 1
			@section_count = @page.sections.size + 1
	 		render('new')
		end
	end

	def edit
		@section = Section.find(params[:id])
		@section_count = @page.sections.size
	end

	def update
		# Find object using form parameters
		@section = Section.find(params[:id])	
		
		# Update the object
		new_position = params[:section].delete(:position)
		if @section.update_attributes(permitted_params)
			@section.move_to_position(new_position)
			# If update succeeds, redirect to the list action	
			#redirect_to(:action => 'show', :id => @page.id)
			flash[:notice] = "Section Updated."			
			redirect_to(:action => 'list', :page_id => @section.pages_id)			
			
		else
			# If update fails, redisplay the form so user can fix problems
			flash[:notice] = "ERROR: Section was not updated"
			#@section_count = Section.count
			@page_count = @subject.pages.size
	 		render('edit')
		end
		
	end

	def delete
		@section = Section.find(params[:id])
	end

	def destroy
		
		#Alternate One step to delete and destroy
		section = Section.find(params[:id])
		section.move_to_position(nil)
		section.destroy
		flash[:notice] = "Section destroyed."		
		#redirect_to(:action => 'list', :page_id => @page.id)		
		redirect_to(:controller => 'subjects')
	end

	#Here below is called strong parameters, which is used in submitting new record
	private

	def permitted_params
  		params.require(:section).permit(:name, :position, :visible,:content_type,:content, :pages_id) 		
	end

	private
	def find_page
		if params[:page_id]
			@page = Page.find_by_id(params[:page_id])
		end
	end

end
