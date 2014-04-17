Xiguashe::Application.routes.draw do

  get 'about' => 'home#about'
  get 'contact' => 'home#contact'
  get 'links' => 'home#links'

  get "reg"  => "users#new",                   :as => "reg"
  get "quit" => "sessions#destroy",            :as => "quit"
  get "login" => "sessions#new",               :as => "login"

  match "/search" => "search#index",           :as => :search
  match "/search/users" => "search#users",:as => :search_users
  match "/search/topics" => "search#topics",:as => :search_topics
  match "/search/products" => "search#products", :as => :search_products


  match "notifications/read/:id/:type"       => "notifications#read",     :via => :get
  match "topics/destroy_product/:product_id" => "topics#destroy_product", :via => :get
  match "comments/get_comment_user/:commentable_id/:commentable_type" => "comments#get_comment_user", :via => :get

  resources :sessions

  resources :products do
    collection do
      get :url, :exist
      post :get
    end
    resources :comments
  end

  resources :feedbacks

  resources :photos
  
  resources :activities, only: [:index, :show]

  resources :password_resets

  resources :users do
    resources :notifications
  end

  match "users/:id/destroy_tag/:tag" => "users#destroy_tag" , :via => :delete  

  resources :topics do
    resources :comments
  end

  resources :likes

  resources :comments do 
    member do
      get :reply_create
    end
  end

  namespace :cpanel do 
    
    resources :topics do 
      member do 
        get :change_edit
        post :change_update
      end
    end
    
		resources :products do
      collection do
        get :batch_destroy
      end
    end

    resources :comments do 
    end
    
    resources :users do
    end

    resources :activities do
      member do
        get :status
      end
    end
  end
  
  mount API => '/'

  root :to => 'home#index'

end
