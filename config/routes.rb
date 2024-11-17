Rails.application.routes.draw do
  devise_for :employees, controllers: { registrations: 'employees/registrations' }
  devise_for :users

  root "home#index"

  resources :establishments, only: [:show, :edit, :update, :new, :create] do
    get 'search', on: :collection
  end
  
  concern :routes do
    post 'enabled', on: :member
    post 'disabled', on: :member
    resources :price_histories, only: [:new, :create]
    resources :portions, only: [:new, :create, :edit, :update]
  end
  
  concern :dish_tag do
    resources :dish_tags, only: [:new, :create]
  end
  
  resources :menus, only: [:index, :new, :create, :show] do 
    resources :menu_items, only: [:new, :create] do
      resources :order_items, only: [:new, :create]
    end
  end
  
  resources :dishes, only: [:index, :show, :edit, :update, :new, :create], concerns: [:routes, :dish_tag]
  resources :drinks, only: [:index, :show, :edit, :update, :new, :create], concerns: [:routes]
  resources :hours_operations, only: [:edit, :update, :new, :create]
  resources :orders, only: [:index, :new, :create, :show]
  resources :pre_registrations, only: [:index, :new, :create]
  resources :tags, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      get 'orders/:establishment_code', to: 'orders#index'
      get 'orders/:establishment_code/:order_code', to: 'orders#show'
      patch 'orders/:establishment_code/:order_code', to: 'orders#update'
    end
  end
end
