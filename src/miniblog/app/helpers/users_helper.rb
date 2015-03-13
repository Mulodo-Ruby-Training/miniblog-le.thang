module UsersHelper
  def current_user
    unless session[:user_id].blank?
      @current_user = User.find(session[:user_id])
    else
      nil
    end
  end
  # Check user login
  def check_login?
    token = session[:user_id].nil? ? nil : User.get_token(session[:user_id])
    if token && token == session[:token]
      return true
    else
      return false
    end
  end
  # Set permission
  def set_permission
    unless session[:permission].nil?
      case session[:permission]
      when '11111'
        session[:level] = 'admin'
      when '11000'
      when '11100'
      when '11110'
        session[:level] = 'user'
      else
        session[:level] = 'guest'
      end
    end
  end
  # clear session
  def clear_session
    # reset_session
    session[:user_id] = nil
    session[:permission] = nil
    session[:token] = nil
    session[:level] = nil
    @current_user = nil
  end

  def update_and_session_token(user_id)
    token = SecureRandom.urlsafe_base64
    User.where(:id => user_id).update_all(:token => token)
    session[:token] = token
  end

  # def check_token?
  #   session[:token].blank? ? redirect_to root_path : nil
  # end
end