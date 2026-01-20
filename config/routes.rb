Rails.application.routes.draw do
  # Game routes
  get  "/new",   to: "games#new",   as: :new
  post "/score", to: "games#score", as: :score
  get  "/score", to: "games#score"   # allows page refresh safely

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route
  root to: "games#new"
end
