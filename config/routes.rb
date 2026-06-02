Rails.application.routes.draw do


  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end

  resources :products do
    get "who_bought", on: :member
  end

  resources :users do
    member do
      get :require_password
      post :check_password
    end
  end

  resources :users
  resources :pay_types


  get "admin" => "admin#index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :support_requests, only: %i[ index update]


  # config/routes.rb
  scope "(:locale)" do
    resources :orders
    resources :line_items
    resources :carts
    root "store#index", as: "store_index", via: :all
  end


end
