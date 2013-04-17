FarmlyWed::Application.routes.draw do
  devise_for :members
  resources :weddings
  get 'invitations/stats' => 'invitations#stats', as: :invitations_stats
  resources :invitations do
    member do
      post :add_guest
    end
  end
  post 'invitations/cities' => 'invitations#cities'
  post 'addresses/lookup' => 'addresses#lookup'
  root :to => 'pages#show', :page => 'index'
  get ':page' => 'pages#show', as: :page
end
