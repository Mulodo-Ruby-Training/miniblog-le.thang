class ApisController < ApplicationController
  # ================    APIs     ================= #
  # ================    User     ================= #
  # https://my.redmine.jp/mulodo/issues/21936
  # POST apis/create_user
  def create_user
    pass = user_params[:password]
    confirm = user_params[:password_confirmation]
    if pass.present? && confirm.present? && (pass.eql? confirm)
      render :json => User.create_user(user_params)
    else
      render :json => {meta:{code: ERROR_VALIDATE[0], description:ERROR_VALIDATE[1],
                    messages:user.errors},data:nil}
    end

  end

  # Task https://my.redmine.jp/mulodo/issues/21938
  # POST apis/user_login
  def user_login
    unless check_login?
      user = User.user_login(user_params)
      # store session
      if user[:meta][:code] == 200
        session[:user_id] = user[:data][:id]
        session[:permission] = user[:data][:permission]
        update_and_session_token(user[:data][:id])
      end
      render :json => user
    else
      render :json => {meta:{code: ERROR_ALREADY_LOGGED_IN[0], description:ERROR_ALREADY_LOGGED_IN[1],
                       messages:"Account already exists"},data: nil}
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21940
  # POST apis/user_logout
  def user_logout
    # session.reset
   if check_login?
      clear_session
      render :json => {meta:{code: STATUS_OK, description:"Logout successfully",
                             messages:"Logout successfully"},data: nil}
    else
      render :json => {meta:{code: ERROR_TOKEN_EXPIRED[0], description:ERROR_TOKEN_EXPIRED[1],
                             messages:"Logout Failed"},data: nil}
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21945
  # GET apis/user_info/:id
  def user_info
    # Check object nil
      user_info = User.get_user_info(params[:id])
      if user_info.nil?
          render :json => {meta:{code: ERROR_GET_USER_INFO_FAILED[0], description:ERROR_GET_USER_INFO_FAILED[1],
                                messages: 'Invalid params'},data:nil}
      else
          render :json => {meta:{code: STATUS_OK, description:"Account login successfully",
                             messages:"Successful"},data: user_info}
      end
  end

  # Task https://my.redmine.jp/mulodo/issues/21943
  # PUT/PATCH apis/:user_id/update_user_info
  def update_user_info
    id = params[:id]
    if check_login? && session[:user_id] == id
      render json: User.update_user(id,user_params)
    else
      render :json => {meta:{code: ERROR_LOGIN_FAILED[0], description:ERROR_LOGIN_FAILED[1],
                             messages:"Login failed."},data: user_info}
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21947
  # PUT/PATCH apis/:user_id/change_password
  def change_password
    id = params[:id]
    if check_login? && session[:user_id] == id
      render json: User.change_password(id,user_params)
    else
      render :json => {meta:{code: ERROR_LOGIN_FAILED[0], description:ERROR_LOGIN_FAILED[1],
                             messages:"Login failed."},data: nil}
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21948
  # GET apis/search_user_by_name/:keyword(/:limit/:offset
  def search_user_by_name
    if check_login?
      keyword = params[:keyword]
      limit =  params[:limit]
      offset = params[:offset]
      user = User.search_user_by_name(keyword,limit, offset)
      render :json => user
    else
      render :json => {meta:{code: ERROR_LOGIN_FAILED[0], description:ERROR_LOGIN_FAILED[1],
                             messages:"Login failed."},data: nil}
    end
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
