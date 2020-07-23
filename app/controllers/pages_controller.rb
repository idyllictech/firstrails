class PagesController < ApplicationController

	layout 'admin'

	before_action :confirm_logged_in
	before_action :find_subject

	def index
		#redirect_to(:controller => 'subjects')
		redirect_to '/subjects/'
		#list
		#Here is to render another view on this current view				
		#render :list
		#render :controller => 'subjects'		
	end

	def list		
	@pages = Page.sorted.where(["pages.subjects_id = ?", "#{params[:subject_id]}"])
	# Note the "sorted" is a scope created in the model
	end

	def show
		@page = Page.find(params[:id])
	end

	 def new	 	
	 	#Here the new is pre - selecting a subject that load from url	 	
	 	@page = Page.new({:subjects_id => @subject.id})
	 	@page_count = @subject.pages.size + 1
	 	#@subjects = Subject.order('position ASC')
	 	
	 	#This page build is not needed when nesting the page
	 	#@page.build_subject
	 end

	def create
		new_position = params[:page].delete(:position)
		# Instantiate a new object using form parameters

		@page = Page.new permitted_params
		# Save the object
		if @page.save
			@page.move_to_position(new_position)
			# If save succeeds, redirect to the list action	
			flash[:notice] = "New Page created."
			#redirect_to(:action => 'list', :subject_id => @page.subjects_id )
			redirect_to(:action => 'list', :id => @page.id, :subject_id => @page.subjects_id)
			#redirect_to(:controller => 'subjects')
		else
			# If save fails, redisplay the form so user can fix problems
			flash[:notice] = "ERROR: Page was not created"
			@page_count = @subject.pages.size + 1
	 		render('new')
		end
	end

	def edit
		@page = Page.find(params[:id])
		@page_count = @subject.pages.size
	end

	def update
		# Find object using form parameters
		@page = Page.find(params[:id])	
		
		# Update the object
		new_position = params[:page].delete(:position) 
		if @page.update_attributes(permitted_params)
			@page.move_to_position(new_position)
			# If update succeeds, redirect to the list action			#
			flash[:notice] = "Page Updated."
			#redirect_to(:controller => 'subjects')
			#redirect_to(:action => 'show', :id => @page.id, :subject_id => @page.subject_id)
			redirect_to(:action => 'list', :id => @page.id, :subject_id => @page.subjects_id)
			#redirect_to(:action => 'list')
		else
			# If update fails, redisplay the form so user can fix problems
			flash[:notice] = "ERROR: Page was not updated"
			@page_count = @subject.pages.size
	 		render('edit')
		end
		
	end

	def delete
		@page = Page.find(params[:id])
	end

	def destroy
		#@page = Page.find(params[:id])
		#@page.destroy

		#ALternate One step to delete and destroy
		page = Page.find(params[:id])
		page.move_to_position(nil)
		page.destroy
		flash[:notice] = "Page destroyed."
		#redirect_to(:action => 'list', :subjects_id => @subject.id)
		redirect_to(:controller => 'subjects')
	end

	#Here below is called strong parameters, which is used in submitting new record
	private
	def permitted_params
  		params.require(:page).permit(:name,:permalink, :position, :visible, :subjects_id) 		
	end

	private
	def find_subject
		if params[:subject_id]
			@subject = Subject.find_by_id(params[:subject_id])
		end
	end
end
