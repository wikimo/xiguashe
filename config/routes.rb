Xiguashe::Application.routes.draw do


  resources :notifications

  get "topics/new"
  
  get "reg"  => "users#new",                   :as => "reg"
  get "quit" => "sessions#destroy",            :as => "quit"
  get "login" => "sessions#new",               :as => "login"
  match "/search" => "search#index",           :as => :search

  match "groups/audit/:id/:user_id/:status" => "groups#audit", :via => :get

  resources :sessions

  resources :users do
    member do
      get :groups
      get :following
      get :likes
    end  
  end  

  resources :categories do
    resources :groups
  end

  resources :groups do
    member do
      get :join, :leave, :apply, :applyers
    end
    resources :topics
  end  

  resources :topics do
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
    resources :users do
    end
  end
 
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'categories#index'

end
