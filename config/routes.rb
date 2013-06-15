Xiguashe::Application.routes.draw do

  get "group_users/index"

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
    end  
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

  resources :comments do 
    member do
      get :reply_create
    end
  end

  namespace :cpanel do 
    resources :groups do
      member do
        get :change_status
      end
    end
  end
 
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

end
