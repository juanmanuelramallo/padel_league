Rails.application.routes.draw do
  draw :madmin

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  namespace :players do
    resource :session, only: [ :new, :create, :destroy ]
  end

  resources :matches

  root to: "matches#index"
end
