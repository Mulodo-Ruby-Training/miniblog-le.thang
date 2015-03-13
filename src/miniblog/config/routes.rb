Rails.application.routes.draw do
  root to: 'users#index'
  # ================    APIs     ================= #
  # ================ User Routes ================= #
  #
  get 'apis/user_logout'
  post 'apis/create_user'
  post 'apis/user_login'
  get 'apis/search_user_by_name/:keyword(/:limit/:offset)' => 'apis#search_user_by_name'
  get 'apis/user_info/:id' => 'apis#user_info'
  match 'apis/:id/change_password' => 'apis#change_password', via:[:put,:patch]
  match 'apis/:id/update_user_info' => 'apis#update_user_info', via:[:put, :patch]


  # ================  Resource   ================= #
  # User controller
  get 'users/login'
  get 'users/change_pass'
  get 'users/search_user'
  get 'users/update'
  get 'users/change_permission'
  resources :users, :only => [:create, :new]
end