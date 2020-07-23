Rails.application.routes.draw do     
      
  get 'show/:id', to: 'public#show'
  
  get 'admin_users/list'   
  post 'admin_users/update'
  post 'admin_users/destroy'
  get 'admin_users/delete'
  resources :admin_users, except: [:show, :update, :destroy]

  get 'access/menu'
  get 'access/index'
  post 'access/attempt_login'
  get 'access/login'
  get 'access/logout'
 
  get 'admin', to: 'access#index'
   
  #match 'admin', :to => 'access#menu'
  #Obsolete

 #sections
  post 'sections/destroy'
  get 'sections/delete'
  get 'sections/list'
  post 'sections/update'

  #pages
  post 'pages/destroy'
  get 'pages/delete'
  get 'pages/list'
  post 'pages/update'
    
  #Subjects
  post 'subjects/destroy'
  get 'subjects/delete'
  get 'subjects/list'
  post 'subjects/update'  

  #resources part
  resources :subjects, :pages, :sections, except: [:update, :destroy]

  get 'demo/make_error'
  get 'demo/escape_output'   
  get 'demo/product'
  get 'demo/text_helpers'
  get 'demo/javascript'
  get 'demo/hello'
  
  #get 'public/index'
  root 'public#index' # this is used to change the default home page of the server 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
