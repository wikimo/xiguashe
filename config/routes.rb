Xiguashe::Application.routes.draw do

  resources :notifications

  get "topics/new"
  
  get "reg"  => "users#new",                   :as => "reg"
  get "quit" => "sessions#destroy",            :as => "quit"
  get "login" => "sessions#new",               :as => "login"
  match "/search" => "search#index",           :as => :search

  resources :sessions

  resources :users

  resources :groups do
    member do
      get :join, :leave 
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
