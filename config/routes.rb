Rails.application.routes.draw do
  resources :seasons, except: [ :show ]

  resources :roles, only: [ :edit, :update, :index, :new, :create ]

  # GET
  get "reports/index"
  get "roles/add_user", to: "roles#add_user"
  get "students/index"
  get "students/my_student_group", to: "students#my_student_group"
  get "advisors/index"
  get "advisors/new", to: "advisors#new"
  get "advisors/detail_group", to: "advisors#detail_group"
  get "advisors/requests"
  get "advisors/edit"
  get "advisors/detail_group", to: "advisors#detail_group", as: "advisors_group_overview"
  get "home/index"
  get "news/index"
  get "news/new", to: "news#new"

  # POST
  post "students/student_requests", to: "students#student_requests"
  post "advisors/create", to: "advisors#create"
  post "advisors/accept_request", to: "advisors#accept_request"
  post "advisors/reject_request", to: "advisors#reject_request"
  post "news/create", to: "news#create"
  post "roles/crcreate_user", to: "roles#create_user"

  # DELETE
  delete "students/:id", to: "students#destroy", as: "delete_student_request"

  # PATCH
  patch "advisors/:id", to: "advisors#update", as: "advisor_update"

  # health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # root
  root to: "home#index"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # ใส่ด้านนอก devise_for
  get "/users/auth/failure", to: "users/omniauth_callbacks#failure"
end
