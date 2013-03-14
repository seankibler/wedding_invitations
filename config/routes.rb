FarmlyWed::Application.routes.draw do
  root :to => 'guests#index'
  get 'guests/stats' => 'guests#stats', as: :guest_stats
  resources :guests
  post 'guests/cities' => 'guests#cities'
end
