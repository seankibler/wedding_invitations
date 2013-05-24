FarmlyWed::Application.routes.draw do
  devise_for :users
  devise_for :admins

  # Admin
  namespace :admin do
    root to: 'contacts#index'
    resources :contacts, only: [:index,:show]
    resources :weddings
  end

  resources :weddings

  # Invitations
  get 'invitations/stats' => 'invitations#stats', as: :invitations_stats
  post 'invitations/cities' => 'invitations#cities'
  post 'addresses/lookup' => 'addresses#lookup'
  post 'invitations/search' => 'searches#create', as: :search

  resources :invitations do
    member do
      post :add_guest
    end
  end

  # Public pages
  resources :contacts, only: [:create]
  get 'contact', to: 'contacts#new', as: :contact

  root to: 'pages#index'

  # Nothing below this route
  get ':page' => 'pages#show', as: :page
end
