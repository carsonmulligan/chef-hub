Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :chefs do
    resources :bookings, only: [ :new, :create, :show, :index ]
  end

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
