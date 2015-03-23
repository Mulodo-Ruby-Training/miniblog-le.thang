class ApisController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # ================    APIs     ================= #
  # ================    User     ================= #
  # https://my.redmine.jp/mulodo/issues/21936
  # POST apis/create_user
  # include ApplicationHelper
  def create_user
    pass = user_params[:password]
    confirm = user_params[:password_confirmation]
    if pass.present? && confirm.present? && (pass.eql? confirm)
      render :json => User.create_user(user_params)
    else
      render json: result_info(t('error.validation'),'pass' ,'Confirm password and password not match.')
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21938
  # POST apis/user_login
  def user_login
    unless check_login?
      user = User.user_login(params[:username],params[:password])
      # store session
      if user[:meta][:code] == 200
        session[:user_id] = user[:data][:id]
        session[:permission] = user[:data][:permission]
        update_and_session_token(user[:data][:id])
      end
      render json: user
    else
      render json: result_info(t('error.alredy_logged_in'))
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21940
  # POST apis/user_logout
  def user_logout
    if check_login?
      clear_session
      render json: result_info(t('error.success_code'),nil,"Account Logout successfully")
    else
      render json: result_info(t('error.token_expired'))
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21945
  # GET apis/user_info/:id
  def user_info
    render :json =>  User.get_user_info(params[:user_id])
  end
  # GET apis/user_info/:id
  def get_list_user
    render :json => User.get_list_user(params[:limit],params[:offset])
  end
  # Task https://my.redmine.jp/mulodo/issues/21943
  # PUT/PATCH apis/:user_id/update_user_info
  def update_user_info
    render_need_login(User.update_user(user_params))
  end
  # Task https://my.redmine.jp/mulodo/issues/21947
  # PUT/PATCH apis/:user_id/change_password
  def change_password
    pass = user_params[:password]
    pass_new = user_params[:password_new]
    confirm = user_params[:password_confirmation]
    if pass!=pass_new && pass_new.present? && confirm.present? && (pass_new.eql? confirm)
      render_need_login(User.change_password(params[:user_id],user_params))
    else
      render json: result_info(t('error.validation'),'pass' ,'The new password must different old password or confirm password and password not match.')
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21948
  # GET apis/search_user_by_name/:keyword(/:limit/:offset
  def search_user_by_name
    keyword = params[:keyword]
    limit =  params[:limit]
    offset = params[:offset]
    user = User.search_user_by_name(keyword,limit, offset)
    render_need_login(user)
  end

  # ================    APIs     ================= #
  # ================    Post     ================= #
  # Task https://my.redmine.jp/mulodo/issues/21951
  # POST apis/create_post
  def create_post
    params[:user_id] = session[:user_id] if session[:user_id].present?
    render_need_login(Post.create_post(post_params))
    # render text: Post.create_post(post_params)
  end
  # Task https://my.redmine.jp/mulodo/issues/21955
  # PUT/PATCH apis/update_post
  def update_post
    post_params[:post_id] = params[:post_id] if params[:post_id].present?
    post_params[:user_id] = session[:user_id] if session[:user_id].present?
    # Users can only modifier your own pót
    render_need_login(Post.update_post(post_params))
  end
  # Task https://my.redmine.jp/mulodo/issues/21957
  # DELETE apis/:post_id/delete_post
  def delete_post
    params[:user_id] = session[:user_id] if session[:user_id].present?
    # render_need_login(Post.delete_post(params[:post_id]))
    render_need_login(Post.delete_post(post_params))
  end
  # Task https://my.redmine.jp/mulodo/issues/21953
  # PUT/PATCH apis/:post_id/active_post/
  def active_post
    post_params[:user_id] = session[:user_id] if session[:user_id].present?
    post_params[:post_id] = params[:post_id] if params[:post_id].present?
    render_need_login(Post.active_post(post_params))
  end
  # Task https://my.redmine.jp/mulodo/issues/21960
  # GET apis/get_list_post(/:limit/:offset)
  def get_list_post
    render :json =>  Post.get_list_post(params[:limit],params[:offset])
  end
  # Task https://my.redmine.jp/mulodo/issues/21961
  # GET apis/get_all_post_for_user
  def get_all_post_for_user
    render :json => Post.get_all_post_for_user(params[:user_id], params[:limit],params[:offset])
  end
  #
  # GET apis/get_a_post/:post_id
  def get_a_post
    render :json => Post.get_a_post(params[:post_id])
  end

  # ================    APIs     ================= #
  # ================   Comment   ================= #
  # https://my.redmine.jp/mulodo/issues/21964
  # Coding/実装 #21964: Add Comment
  # POST apis/create_comment
  # 20/3/2015
  # params: :content, :user_id, :post_id, :parent_id, :parent_id
  def create_comment
    com_params[:user_id] = session[:user_id] if session[:user_id].present?
    render_need_login(Comment.create_comment(com_params))
  end
  # https://my.redmine.jp/mulodo/issues/21966
  # Coding/実装 #21966: Edit Comment
  # PUT/PATCH apis/:comment_id/update_comment
  # 20/3/2015
  # Params: comment_id, content, user_id
  def update_comment
    com_params[:comment_id] = params[:comment_id]
    com_params[:user_id] = session[:user_id].blank? ? nil : session[:user_id]
    render_need_login(Comment.update_comment(com_params))
  end
  # https://my.redmine.jp/mulodo/issues/21968
  # Coding/実装 #21968: Delete Comment
  # 20/3/2015
  # Params: comment_id, user_id
  def delete_comment
    com_params[:comment_id] = params[:comment_id]
    com_params[:user_id] = session[:user_id].blank? ? nil : session[:user_id]
    render_need_login(Comment.delete_comment(com_params))
  end
  # https://my.redmine.jp/mulodo/issues/21970
  # Coding/実装 #21970: Get All Comments for a Post
  # 20/3/2015
  # Prams: post_id, limit, offset
  def get_all_comment_for_a_post
    render json: Comment.get_all_comment_for_a_post(params[:post_id],params[:limit], params[:offset])
  end
  # https://my.redmine.jp/mulodo/issues/21972
  # Coding/実装 #21972: Get All Comments for User
  # 20/3/2015
  # Prams: user_id, limit, offset
  def get_all_comment_for_user
    render json: Comment.get_all_comment_for_user(params[:user_id],params[:limit], params[:offset])
  end

  # Strong params
  private
  def user_params
    params.permit(
        :password, :password_confirmation, :password_new,
        :username, :first_name, :last_name, :avatar,:address,
        :gender, :permission, :email, :display_name, :birthday,
        :token, :status, :user_id
    )
  end
  #
  def post_params
    params.permit(:title, :description, :content,:thumbnail, :id, :post_id, :user_id)
  end
  #
  def com_params
    params.permit(:content, :user_id, :post_id,:parent_id, :comment_id)
  end
  #
  def render_need_login(response_data)
    if check_login?
      render :json => response_data
    else
      render :json => result_info(t('error.not_yet_login'))
    end
  end
end
