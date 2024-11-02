Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :establishments, only: [:show, :edit, :update, :new, :create] do
    get 'search', on: :collection
  end
  resources :dishes, only: [:index, :show, :edit, :update, :new, :create] do
    resources :portions, only: [:new, :create, :edit, :update]
    post 'enabled', on: :member
    post 'disabled', on: :member
  end
  resources :drinks, only: [:index, :show, :edit, :update, :new, :create] do
    post 'enabled', on: :member
    post 'disabled', on: :member
  end
  resources :hours_operations, only: [:edit, :update, :new, :create]
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
