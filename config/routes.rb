Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :courses, except: [:destroy] do
    resources :weeks, only: [:show, :edit, :update], param: :number do
      member do
        get :journal
      end
    end

    resources :students, only: [:index, :new, :create, :show]
  end

  resource :profile, only: [:show]

  scope :teamwork do
    resources :journals, only: [:index]
  end

  root 'courses#index'
end
