FarmlyWed::Application.routes.draw do
  resources :guests


  root :to => 'guests#index'
end
