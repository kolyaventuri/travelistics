Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :countries, only: [:show]
  get '/travel/:country_1/:country_2', to: 'countries#render', as: 'countries_render'

  root to: 'main#index'

  resources :users, only: [:create, :update]
  get '/register', to: 'users#new', as: 'registration'
  get '/login', to: 'sessions#login', as: 'login'

  post '/login/do', to: 'sessions#authenticate'

  get '/logout', to: 'sessions#clear', as: 'logout'

  get '/account', to: 'users#show', as: 'account'

  namespace :admin do
    root to: 'admin#index'

    resources :currencies, except: :show
    resources :languages, except: :show

    resources :countries do
      resources :languages, to: "country_languages#", only: [:new, :create, :destroy]
    end
  end
end
