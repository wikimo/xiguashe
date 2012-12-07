Xiguashe::Application.routes.draw do

  get "topics/new"

  resources :sessions

  resources :users

  resources :topics

  resources :groups do
    resources :topics
  end  

 
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

end
