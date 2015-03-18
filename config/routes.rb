Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :courses, only: [:index, :show, :new, :create] do
    resources :weeks, only: [:show, :edit, :update], param: :number
  end

  root 'courses#index'
end
