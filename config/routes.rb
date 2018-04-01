Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'main#index'

  resources :users, only: [:create]
  get '/register', to: 'users#new', as: 'registration'
  get '/login', to: 'sessions#login', as: 'login'

  post '/login/do', to: 'sessions#authenticate'

  get '/logout', to: 'sessions#clear', as: 'logout'

  get '/account', to: 'users#show', as: 'account'
end
