FitbitGoalIncrementer::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:destroy, :show, :update]

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/signout', :to => 'sessions#destroy', :as => :signout

  root to: 'home#index'
end
