Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :courses, only: [:index, :show, :new, :create]

  root 'courses#index'
end
