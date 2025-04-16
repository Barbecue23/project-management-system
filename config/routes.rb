Rails.application.routes.draw do
  resources :seasons, except: [ :show ]

  resources :roles, only: [ :edit, :update, :index, :new, :create ]

  resources :users, only: [ :edit, :update ]

  # GET
  get "reports/index"
  get "reports/select_type", to: "reports#select_type"
  get "reports/new", to: "reports#new"
  get "reports/:id/edit", to: "reports#edit", as: "edit_report"
  get "users/add_user", to: "users#add_user"
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
  get "/news/:id", to: "news#show", as: "news_show"
  get "news/:id/edit", to: "news#edit", as: "news_edit"

  # POST
  post "students/student_requests", to: "students#student_requests"
  post "advisors/create", to: "advisors#create"
  post "advisors/accept_request", to: "advisors#accept_request"
  post "advisors/reject_request", to: "advisors#reject_request"
  post "news/create", to: "news#create"
  post "users/create_user", to: "users#create_user"
  post "reports/create", to: "reports#create"

  # DELETE
  delete "students/:id", to: "students#destroy", as: "delete_student_request"
  delete "news/attachments/:id", to: "news#delete_attachment", as: "delete_news_attachment"
  delete "news/:id", to: "news#destroy", as: :delete_news
  delete "reports/:id", to: "reports#destroy", as: :delete_report

  # PATCH
  patch "advisors/:id", to: "advisors#update", as: "advisor_update"
  patch "news/:id", to: "news#update", as: "news_update"
  patch "reports/:id", to: "reports#update", as: "report_update"
  patch "seasons/:id/update_status", to: "seasons#update_status", as: "season_update_status"


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
