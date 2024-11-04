Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :establishments, only: [:show, :edit, :update, :new, :create] do
    get 'search', on: :collection
  end

  concern :portionable do
    resources :portions, only: [:new, :create, :edit, :update]
  end

  concern :enabled_disabled do
    post 'enabled', on: :member
    post 'disabled', on: :member
  end

  concern :history do
    resources :price_histories, only: [:new, :create]
  end

  resources :dishes, only: [:index, :show, :edit, :update, :new, :create], concerns: [:portionable, :enabled_disabled, :history]
  resources :drinks, only: [:index, :show, :edit, :update, :new, :create], concerns: [:portionable, :enabled_disabled, :history]
  resources :hours_operations, only: [:edit, :update, :new, :create]
  

  # get "up" => "rails/health#show", as: :rails_health_check

  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
