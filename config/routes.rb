Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"

  get "sessions/new"

	root "static_pages#home"
	# root "microposts#index"

	get "/signup", to: "users#new"
	get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
	resources :users do
		member do
			get :following, :followers
		end
	end
	resources :account_activations, only: [:edit]
	resources :password_resets, only: [:new, :create, :edit, :update]
	resources :microposts, only: [:create, :destroy, :show, :index] do
		resources :comments
	end
	resources :relationships, only: [:create, :destroy]
end
