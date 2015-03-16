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
    if pass.present? && confirm.present? && (pass.eql? confirm)
      render json: User.create_user(user_params)
    else
      render json: result_info(t('error.validation'),user_params,'Confirm password and password not match.')
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21938
  # POST apis/user_login
  def user_login
    if check_login?.nil?
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
    if check_login?.nil?
      clear_session
      render json: result_info(t('error.success_code'),nil,"Account Logout successfully")
    else
      render json: result_info(t('error.token_expired'))
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21945
  # GET apis/user_info/:id
  def user_info
    # Check object nil
    user_info = User.get_user_info(params[:id])
    if user_info.nil?
      render json: result_info(t('error.token_expired'))
    else

      render json: result_info(t('error.get_user_info_failed'),user_info)
    end

  end

  # Task https://my.redmine.jp/mulodo/issues/21943
  # PUT/PATCH apis/:user_id/update_user_info
  def update_user_info
    check_login?
    render json: User.update_user(params[:id],user_params)
  end

  # Task https://my.redmine.jp/mulodo/issues/21947
  # PUT/PATCH apis/:user_id/change_password
  def change_password
    check_login?
    render json: User.change_password(id,user_params)
  end

  # Task https://my.redmine.jp/mulodo/issues/21948
  # GET apis/search_user_by_name/:keyword(/:limit/:offset
  def search_user_by_name
    check_login?
    keyword = params[:keyword]
    limit =  params[:limit]
    offset = params[:offset]
    render json: User.search_user_by_name(keyword,limit, offset)
  end

  # ================    APIs     ================= #
  # ================    Post     ================= #

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

end
