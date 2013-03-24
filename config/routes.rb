FarmlyWed::Application.routes.draw do
  devise_for :users

  root :to => 'guests#index'
  get 'guests/stats' => 'guests#stats', as: :guest_stats
  resources :guests
  post 'guests/cities' => 'guests#cities'
  post 'addresses/lookup' => 'addresses#lookup'
end
