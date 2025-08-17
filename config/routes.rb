Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  
  post 'auth/login', to: 'auth#login'
  post 'auth/register', to: 'auth#register'
  
  get 'documents/:type', to: 'documents#show'
  post 'documents/:type', to: 'documents#create'
  put 'documents/:id', to: 'documents#update'
  delete 'documents/:id', to: 'documents#destroy'
  
  get 'templates/:type', to: 'templates#show'
  
  get 'organization', to: 'organizations#show'
  post 'organization', to: 'organizations#create'
  put 'organization', to: 'organizations#update'

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get "up" => "rails/health#show", as: :rails_health_check
end
