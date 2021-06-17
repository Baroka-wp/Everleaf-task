Rails.application.routes.draw do
  get 'sessions/new'
	root to: 'tasks#index'
	resources :tasks
	resources :users, only: [:new, :create, :show, :update, :edit]
	resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
