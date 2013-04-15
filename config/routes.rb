FarmlyWed::Application.routes.draw do
  resources :weddings

  devise_for :users

  root :to => 'pages#show'
  get 'invitations/stats' => 'invitations#stats', as: :invitations_stats
  resources :guests
  resources :invitations do
    member do
      post :add_guest
    end
  end
  post 'invitations/cities' => 'invitations#cities'
  post 'addresses/lookup' => 'addresses#lookup'
  get ':page' => 'pages#show', as: :page
end
