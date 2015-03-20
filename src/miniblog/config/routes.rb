Rails.application.routes.draw do
  root to: 'users#index'
  # ================    APIs     ================= #
  # ================ User Routes ================= #
  #
  get 'apis/user_logout'
  post 'apis/create_user' => 'apis#create_user'
  post 'apis/user_login'
  get 'apis/search_user_by_name/:keyword(/:limit/:offset)' => 'apis#search_user_by_name'
  get 'apis/user_info/:user_id' => 'apis#user_info'
  get 'apis/get_list_user(/:limit/:offset)' => 'apis#get_list_user'
  put 'apis/:user_id/change_password' => 'apis#change_password', via:[:put,:patch]
  put 'apis/:user_id/update_user_info' => 'apis#update_user_info'
  # ================ User Routes ================= #
  post 'apis/create_post'
  delete 'apis/delete_post/:post_id' => 'apis#delete_post'
  get 'apis/get_list_post(/:limit/:offset)' => 'apis#get_list_post'
  get 'apis/get_a_post/:post_id' => 'apis#get_a_post'
  get 'apis/get_all_post_for_user/:user_id(/:limit/:offset)' => 'apis#get_all_post_for_user'
  match 'apis/:post_id/update_post' => 'apis#update_post', via:[:put,:patch]
  match 'apis/:post_id/active_post' => 'apis#active_post', via:[:put,:patch]
  # ================ User Routes ================= #
  post 'apis/create_comment/' => 'apis#create_comment'
  match 'apis/:comment_id/update_comment' => 'apis#update_comment', via:[:put,:patch]
  delete 'apis/:comment_id/delete_comment' => 'apis#delete_comment'
  get 'apis/get_all_comment_for_a_post/:post_id(/:limit/:offset)' => 'apis#get_all_comment_for_a_post'
  get 'apis/get_all_comment_for_user/:user_id(/:limit/:offset)' => 'apis#get_all_comment_for_user'
  # ================  Resource   ================= #
  # # User controller
  # get 'users/login'
  # get 'users/change_pass'
  # get 'users/search_user'
  # get 'users/update'
  # get 'users/change_permission'
  # # Post
  resources :posts
  # get 'posts/new'
  # get 'posts/update'
  # delete 'posts/:id/delete' => 'posts#delete'
  # get 'posts/get_list'
  # get 'posts/post_of_user'
  # get 'posts/show'
  # get 'posts/active_post'

end
