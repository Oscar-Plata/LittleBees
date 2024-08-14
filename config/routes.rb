Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "dashboard#index"

  #SESION
  delete '/login', to: "session#logout", as: :logout_session
  post '/login', to: 'session#auth'
  get '/login', to: "session#login", as: :login_session
  get '/register', to: "session#register", as: :register_session
  
  #USUARIO
  delete '/users/:id', to: "users#destroy"
  patch '/users/:id', to: "users#update"
  post '/users', to: "users#create"
  get '/users', to: "users#index", as: :usuarios
  get '/users/new', to: "users#new", as: :new_usuario
  get '/users/:id', to: "users#show", as: :usuario
  get '/users/:id/edit', to: "users#edit", as: :edit_usuario

  #PRODUCTO
  delete '/products/:id', to: 'products#destroy'
  patch '/products/:id', to: "products#update"
  post '/products', to: 'products#create'
  get '/products', to: "products#index", as: :productos
  get '/products/new', to: "products#new", as: :new_producto
  get '/products/:id', to: "products#show", as: :producto
  get '/products/:id/edit',to: "products#edit", as: :edit_producto
  

  #VENTA
  get '/sales', to: "sales#index"
  get '/checkout', to: "sales#create"
  get '/sales/:id', to: "sales#show", as: :sale

  
end
