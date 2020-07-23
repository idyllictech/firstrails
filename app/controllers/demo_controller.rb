class DemoController < ApplicationController
  #include ActionView::Helpers::TextHelper

  layout 'public'

  def index
    #render 'hello'  
  end
  def hello
    #@array = [1,2,3,4,5]
  end
  def product
    @id = params[:id].to_i
    @page = params[:page].to_i
  end

  def javascript    
  end
    
  def text_helpers
  end
  def escape_output    
  end
  
  def make_error
    render(:text => "test"
    #render(:text => @something.upcase)
    #render(:text => "1" + 1)
  end


end
