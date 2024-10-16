Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :customers, only: [:index] do
    collection do
      get 'missing_email'
      get 'alphabetized'
    end
  end

  # Root route (Update this to match the controller and action you need)
  root "customers#index"

  get 'customers/alphabetized', to: 'customers#alphabetized', as: 'customers_alphabetized'
  get 'customers/missing_email', to: 'customers#missing_email', as: 'customers_missing_email'

  # Add routes for customers
  resources :customers, only: [:index, :show]
end
