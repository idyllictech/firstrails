class AdminUsersController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in

  def index
    list    
    render :list
  end

  def list
    #@admin_users = AdminUser.order("admin_users.last_name ASC").order("admin_users.first_name ASC")
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(user_params)
    # Save the object
    if @admin_user.save
      # If save succeeds, redirect to the list action 
      flash[:notice] = "Admin User created."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so user can fix problems      
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    # Find object using form parameters
    @admin_user = AdminUser.find(params[:id])  
    
    # Update the object
    if @admin_user.update_attributes(userupdate_params)
      # If update succeeds, redirect to the list action 
      #redirect_to(:action => 'show', :id => @page.id)
      flash[:notice] = "Admin User Updated."
      redirect_to(:action => 'list')
    else
      # If update fails, redisplay the form so user can fix problems
      flash[:notice] = "ERROR: Admin User was not updated"
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    AdminUser.find(params[:id]).destroy
    flash[:notice] = "Admin User destroyed."
    redirect_to(:action => 'list')
  end

  private
  def user_params
      params.require(:admin_user).permit(:last_name,:first_name, :username, :email, :password)     
  end
  def userupdate_params
      params.require(:admin_user).permit(:last_name,:first_name, :username, :password)     
  end
end
