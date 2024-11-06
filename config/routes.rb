Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "menus#index", as: :authenticated_root
  end

  unauthenticated do
    root "home#index", as: :unauthenticated_root
  end

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
    resources :menu_items, only: [:new, :create]
  end

  resources :tags, only: [:new, :create]
  resources :dishes, only: [:index, :show, :edit, :update, :new, :create], concerns: [:routes, :dish_tag]
  resources :drinks, only: [:index, :show, :edit, :update, :new, :create], concerns: [:routes]
  resources :hours_operations, only: [:edit, :update, :new, :create]
end
