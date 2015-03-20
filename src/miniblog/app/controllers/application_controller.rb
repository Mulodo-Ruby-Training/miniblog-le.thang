class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_permission
  # Check users login
  # Set a filter that is invoked on every request
  before_filter :_set_current_session

  include UsersHelper

  protected
  def _set_current_session
    # Define an accessor. The session is always in the current controller
    # instance in @_request.session. So we need a way to access this in
    # our model
    accessor = instance_variable_get(:@_request)

    # This defines a method session in ActiveRecord::Base. If your model
    # inherits from another Base Class (when using MongoMapper or similar),
    # insert the class here.
    ActiveRecord::Base.send(:define_method, "session", proc {accessor.session})
  end
end
