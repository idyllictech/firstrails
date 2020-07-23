class PublicController < ApplicationController

  before_action :setup_navigation

  def index
  	#Intro Text
  end

  def show
  	@page = Page.where(:permalink => params[:id], :visible =>true).first
  	redirect_to(:action => 'index') unless @page 	
  	
  end

  private
  def setup_navigation
  	@subjects = Subject.visible.sorted
  end
end
