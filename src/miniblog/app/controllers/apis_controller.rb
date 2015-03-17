class ApisController < ApplicationController
  # ================    APIs     ================= #
  # ================    User     ================= #
  # https://my.redmine.jp/mulodo/issues/21936
  # POST apis/create_user
  # include ApplicationHelper
  def create_user
    check_login?
    pass = user_params[:password]
    confirm = user_params[:password_confirmation]
    if check_login? && pass.present? && confirm.present? && (pass.eql? confirm)
      render json: User.create_user(user_params)
    else
      render json: result_info(t('error.validation'),user_params,'Confirm password and password not match.')
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21938
  # POST apis/user_login
  def user_login
    if check_login?
      user = User.user_login(user_params)
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
      render text: User.get_user_info(params[:id])
  end

  # GET apis/user_info/:id
  def get_list_user
    render :json => User.get_list_user(params[:limit],params[:offset])
  end

  # Task https://my.redmine.jp/mulodo/issues/21943
  # PUT/PATCH apis/:user_id/update_user_info
  def update_user_info
    if check_login?
      render json: User.update_user(params[:id],user_params)
    else
      render :json => result_info(t('error.not_yet_login'))
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21947
  # PUT/PATCH apis/:user_id/change_password
  def change_password
    if check_login?
      render json: User.change_password(id,user_params)
    else
      render :json => result_info(t('error.not_yet_login'))
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21948
  # GET apis/search_user_by_name/:keyword(/:limit/:offset
  def search_user_by_name
    if check_login?
      keyword = params[:keyword]
      limit =  params[:limit]
      offset = params[:offset]
      render json: User.search_user_by_name(keyword,limit, offset)
    else
      render :json => result_info(t('error.not_yet_login'))
    end
  end

  # ================    APIs     ================= #
  # ================    Post     ================= #

  # Task https://my.redmine.jp/mulodo/issues/21951
  # POST apis/create_post
  def create_post
    if check_login?
      render :json => Post.create_post(session[:user_id],post_params)
    else
      render :json => result_info(t('error.not_yet_login'))
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21955
  # PUT/PATCH apis/update_post
  def update_post
    check_login?
    # render json: Post.update_post(params[:])
  end
  # Task https://my.redmine.jp/mulodo/issues/21957
  # GET apis/delete_post
  def delete_post

  end
  # Task https://my.redmine.jp/mulodo/issues/21953
  # PUT apis/active_post/
  def active_post

  end
  # Task https://my.redmine.jp/mulodo/issues/21960
  # GET apis/search_user_by_name/:keyword(/:limit/:offset
  def get_list_post
    post =  Post.get_list_post(params[:limit],params[:offset])
  end
  # Task https://my.redmine.jp/mulodo/issues/21961
  # GET
  def get_all_post_for_user

  end

  # ================    APIs     ================= #
  # ================   Comment   ================= #

  # Strong params
  private
  def user_params
    params.fetch(:user,{}).permit(
        :password, :password_confirmation, :password_new,
        :username, :first_name, :last_name, :avatar,:address,
        :gender, :permission, :email, :display_name, :birthday,
        :token, :status
    )
  end
  def post_params
    params.fetch(:post,{}).permit(:title, :description, :content,:thumbnail)
  end

end
