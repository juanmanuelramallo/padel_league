Rails.application.routes.draw do
  draw :madmin

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  namespace :players do
    resource :session, only: [ :new, :create, :destroy ]
    resources :invitees, only: [ :new, :create, :edit, :update, :destroy ]
    resources :friendships
    resources :confirmations, only: [ :show ]
    resource :profile, only: [ :show, :edit, :update ]
  end

  resources :players, only: [] do
    resource :stats, only: [ :show ]

    namespace :stats do
      resource :played_matches, only: [ :show ]
    end
  end

  resources :matches, except: [ :destroy ] do
    resources :match_confirmations, only: [ :create ], path: "confirmations", controller: "matches/confirmations"
  end

  root to: "matches#index"

  mount Blazer::Engine, at: "blazer"
end
