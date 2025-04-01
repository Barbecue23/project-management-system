Rails.application.routes.draw do
  resources :seasons, except: [ :show ]

  resources :roles, only: [ :edit, :update, :index, :new, :create ]

  get "reports/index"
  get "students/index"
  get "advisors/index"
  get "advisors/new", to: "advisors#new"  # Route to show the create advisor page
  post "advisors/create", to: "advisors#create"  # Route to handle form submission
  get "advisors/detail_group", to: "advisors#detail_group"  # Route to show the detail advisor group page
  post "advisors/student_requests", to: "advisors#student_requests"  # Route to handle form submission
  get "advisors/requests"
  post "advisors/accept_request", to: "advisors#accept_request"
  post "advisors/reject_request", to: "advisors#reject_request"
  get "advisors/edit"
  get "advisors/detail_group", to: "advisors#detail_group", as: "advisors_group_overview"
  patch "advisors/:id", to: "advisors#update", as: "advisor_update"
  get "home/index"
  get "news/index"
  get "news/new", to: "news#new"  # Route to show the create news page
  post "news/create", to: "news#create"  # Route to handle form submission
  # root "news#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "home#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
end
