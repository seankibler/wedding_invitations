FarmlyWed::Application.routes.draw do
  root :to => 'guests#index'
  resources :guests
  post 'guests/cities' => 'guests#cities'
end
