Xiguashe::Application.routes.draw do

  get "topics/new"
  
  get "reg"  => "users#new",            :as => "reg"

  resources :sessions

  resources :users

  resources :groups do
    resources :topics
  end  

  resources :topics do
    resources :comments
  end

  resources :comments do 
    member do
      get :reply_create
    end
  end
 
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

end
