class SubjectsController < ApplicationController
	
	#This is use to specify the layout to use by the controller
	# Else the controller will use default layout of the application
	layout 'admin' 

	before_action :confirm_logged_in
	def index
		list
		#Here is to render another view on this current view				
		render :list

		#Here is to render plain text alone
		#render plain: "Ok" 

		#Here is to redirect to another path
		#redirect_to '/subjects/list'
	end
	def id

	end

	def list
		@subjects = Subject.order("subjects.position ASC")
	end

	def show
		@subject = Subject.find(params[:id])
	end

	 def new
	 	#This is necessary so to initiate default values to show on the text input
	 	@subject = Subject.new(:name => 'default')
	 	@subject_count = Subject.count + 1
	 end

	def create
		# Instantiate a new object using form parameters
		new_position = params[:subject].delete(:position)
		
  		# This is the recommended form:
		@subject = Subject.new(permitted_params)
		# Save the object
		if @subject.save
			@subject.move_to_position(new_position)
			# If save succeeds, redirect to the list action	
			flash[:notice] = "Subject created."
			redirect_to(:action => 'list')
		else
			# If save fails, redisplay the form so user can fix problems
	 		@subject_count = Subject.count + 1
	 		render('new')
		end
	end

	def edit
		@subject = Subject.find(params[:id])
		@subject_count = Subject.count 
	end

	def update
		# Find object using form parameters
		@subject = Subject.find(params[:id])	
		
		# Update the object
		new_position = params[:subject].delete(:position)
		if @subject.update_attributes(permitted_params)
			@subject.move_to_position(new_position)
			# If update succeeds, redirect to the list action	
			#redirect_to(:action => 'show', :id => @subject.id)
			flash[:notice] = "Subject Updated."
			redirect_to(:action => 'list')
		else
			# If update fails, redisplay the form so user can fix problems
	 		@subject_count = Subject.count
	 		render('edit')
		end
		
	end

	def delete
		#@subject = Subject.find(params[:id])
		@subject = Subject.find(params[:id])
	end

	def destroy
		#@subject = Subject.find(params[:id])
		#@subject.destroy

		#ALternate One step to delete and destroy
		subject = Subject.find(params[:id])
		subject.move_to_position(nil)
		subject.destroy
		flash[:notice] = "Subject destroyed."
		redirect_to(:action => 'list')
	end

	#Here below is called strong parameters, which is used in submitting new record
	private

	def permitted_params
  		params.require(:subject).permit(:name, :position, :visible)
 		#permit(:position, :visible, :name)
	end

end
