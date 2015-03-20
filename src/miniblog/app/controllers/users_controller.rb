class UsersController < ApisController

  def index
  end
  def new
    @user = User.new
  end

  #
  #
  def create
    create_user
    # render :json => @user
  end

  # Model User.logout
  #
  def logout
    clear_session
    render :text => session[:user_id]
  end

  # Model User.login
  #
  # User login
  def login
    user_login
  end
  #
  #
  def change_pass

  end


  def update

  end

  def change_permission
  end

  def search_user
  end

end
