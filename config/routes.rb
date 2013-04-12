FarmlyWed::Application.routes.draw do
  resources :weddings

  devise_for :users

  root :to => 'invitations#index'
  get 'invitations/stats' => 'invitations#stats', as: :invitations_stats
  resources :guests
  resources :invitations
  post 'invitations/cities' => 'invitations#cities'
  post 'addresses/lookup' => 'addresses#lookup'
end
