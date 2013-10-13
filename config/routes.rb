Xiguashe::Application.routes.draw do

  get "recommend/topic" => "recommend#topic"

  get "recommend/user" => "recommend#user"

  get "recommend/group" => "recommend#group"

  get 'about' => 'home#about'

  get "reg"  => "users#new",                   :as => "reg"
  get "quit" => "sessions#destroy",            :as => "quit"
  get "login" => "sessions#new",               :as => "login"

  match "/search" => "search#index",           :as => :search


  match "groups/audit/:id/:user_id/:status"  => "groups#audit",           :via => :get
  match "notifications/read/:id/:type"       => "notifications#read",     :via => :get
  match "topics/destroy_product/:product_id" => "topics#destroy_product", :via => :get

  resources :sessions

  resources :products

  resources :feedbacks

  resources :photos

  resources :password_resets

  resources :users do
    member do
      get :groups
      get :following
      get :likes

      get :tags
      
      post :create_tag
    end
    collection do
      get :tag_with
    end  
    resources :notifications
  end

    match "users/:id/destroy_tag/:tag" => "users#destroy_tag" , :via => :delete  

  resources :categories do 
    resources :groups do 
      collection do 
        get :discovery
      end
    end
  end
 

  resources :groups do
    member do
      get :join, :leave, :apply, :applyers
    end
    collection do
        get :members
      end
    resources :topics
  end  

  resources :topics do
    collection do
      get :discovery
    end
    resources :comments
  end

  resources :likes

  resources :comments do 
    member do
      get :reply_create
    end
  end

  match 'users/follow/:followed_id' => 'user_relations#create',:via  => :post
  match 'users/unfollow/:followed_id' => 'user_relations#destroy',:via  => :delete

  namespace :cpanel do 
    
    resources :categories do 
      member do
        get :change_use 
      end
    end

    resources :groups do
      member do
        get :change_status
      end
    end

    resources :topics do 
    end
    
    resources :comments do 
    end
    
    resources :users do
    end
  end
 
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

end
