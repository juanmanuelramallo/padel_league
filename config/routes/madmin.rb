# Below are the routes for madmin
namespace :madmin do
  resources :match_players
  resources :friendships
  resources :teams
  resources :score_sets
  resources :matches
  resources :locations
  resources :players
  root to: "dashboard#show"
end
