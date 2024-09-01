# Below are the routes for madmin
namespace :madmin do
  resources :players
  root to: "dashboard#show"
end
