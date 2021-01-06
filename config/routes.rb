Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'posts#index'
  post '/callback' => 'linebot#callback'
  resources :posts, only: [:index, :new, :create]
end
