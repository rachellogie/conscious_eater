Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  get '/profile', to: 'profiles#show', as: :profile

  resources :restaurants do
    resources :favorite_restaurants, only: [:create, :destroy]
    resources :facts
  end

  get '/surprise/:id', to: 'surprise#show', as: :surprise

end
