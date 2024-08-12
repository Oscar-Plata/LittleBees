Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "dashboard#index"
  
  #USUARIO
  get '/users', to: "users#index"
  get '/users/:id', to: "users#show", as: :user

  #PRODUCTO
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

  #SESION
  get '/login', to: "session#login"
  get '/register', to: "session#register"
end
