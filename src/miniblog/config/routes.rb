Rails.application.routes.draw do
  root to: 'users#index'
  # ================    APIs     ================= #
  # ================ User Routes ================= #
  #
  get 'apis/user_logout'
  post 'apis/create_user' => 'apis#create_user'
  post 'apis/user_login'
  get 'apis/search_user_by_name/:keyword(/:limit/:offset)' => 'apis#search_user_by_name'
  get 'apis/user_info/:id' => 'apis#user_info'
  get 'apis/get_list_user' => 'apis#get_list_user'
  match 'apis/:id/change_password' => 'apis#change_password', via:[:put,:patch]
  match 'apis/:id/update_user_info' => 'apis#update_user_info', via:[:put, :patch]
  # ================ User Routes ================= #
  post 'apis/create_post'
  delete 'apis/delete_post/:id' => 'apis#delete_post'
  get 'apis/get_list_post(/:limit/:offset)' => 'apis#get_list_post'
  get 'apis/get_post_of_user(/:limit/:offset)' => 'apis#get_post_of_user'
  match 'apis/:id/update_post' => 'apis#update_post', via:[:put,:patch]
  match 'apis/:id/active_post' => 'apis#active_post', via:[:put,:patch]

  # ================  Resource   ================= #
  # User controller
  get 'users/login'
  get 'users/change_pass'
  get 'users/search_user'
  get 'users/update'
  get 'users/change_permission'
  # Post
  get 'posts/index'
  get 'posts/new'
  get 'posts/update'
  get 'posts/delete'
  get 'posts/get_list'
  get 'posts/post_of_user'
  get 'posts/show'
  get 'posts/active_post'

end
