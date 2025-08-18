Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  get "/documents/:type", to: "documents#show"

  get "/templates/:type", to: "templates#show"

  get "/organization/", to: "organization#show"

  post "/documents/:type", to: "documents#create"

  post "/organization/", to: "organization#create"
  
  put "/organization/", to: "organization#update"

  put "/documents/:type", to: "documents#update"

  delete "/organization/", to: "organization#destroy"

  delete "/documents/:type", to: "documents#destroy"

  # Auth
  post "/users", to: "users#create"
  get "/me", to: "users#me"
  post "/auth/login", to: "auth#login"

  # errors
  match "*path", to: "application#handle_routing_error", via: :all
end
