class User < ActiveRecord::Base
  extend ApplicationHelper
  has_many :posts, class_name: 'Post', foreign_key: 'id'
  has_many :comments, class_name: 'Comment', foreign_key: 'id'

  # has_secure_password

  accepts_nested_attributes_for :comments
  # attr_accessor :password_digest

  # filter_parameter_logging :password, :password_confirmation

  # ========= Validation =========== #
  validates :password, confirmation: true
  validates :email, presence: true, uniqueness: true, length: 8..50, format: { with: /\A[a-z0-9\.]+@([a-z]{1,10}\.){1,2}[a-z]{2,4}\z/,message: "Invalid Email"}
  validates :username, presence: true, uniqueness: true, length: 6..40
  validates :first_name, presence: true, length: 2..50
  validates :last_name, presence: true, length: 2..50
  validates :avatar, format: {with: /\A*\.(JPEG|JPG|PNG|GIF|BMP|ICO)\z/i, message: "Your images incorrect formated, it must be formatted as: jpeg, png, gif, bmp, icon "}
  validates :display_name, uniqueness: true, length: 3..50
  validates :birthday, format: {with: /\A[\d\/-]{10}\z/}
  validates :status, numericality: true, length: {is: 1}, on: :update
  validates :permission, length: {is: 5}, :on => :update
  validates :address, length: 4..50

  # preprocessor
  before_save { email.downcase! }
  before_save :create_token

  search_syntax do
    search_by :text do |scope, phrases|
      columns = [:first_name, :last_name, :username]
      scope.where_like(columns => phrases)
    end
  end

  # Issue https://my.redmine.jp/mulodo/issues/21936
  # Create User Account
  def self.create_user(user_params)
    # Params
    password_salt = BCrypt::Engine.generate_salt
    password = BCrypt::Engine.hash_secret(user_params[:password], password_salt)
    params = {
        password: password,
        password_salt: password_salt,
        username: user_params[:username],
        email: user_params[:email],
        first_name: user_params[:first_name],
        last_name: user_params[:last_name],
        avatar: user_params[:avatar],
        gender: user_params[:gender],
        display_name: user_params[:display_name],
        birthday: user_params[:birthday],
        address: user_params[:address]
    }
    # Save new user
    begin
      user = new(params)
      user.save!
      result_info(I18n.t('error.success_code'),params,"Account is created successfully")
    rescue => e
      if user.invalid?
        result_info(I18n.t('error.validation'),user.errors)
      else
        result_info(I18n.t 'error.create_user',nil)
      end
    end
  end

  # https://my.redmine.jp/mulodo/issues/21938
  # User login
  def self.user_login(user_params)
    # Check object nil
    if user_params[:username].blank? || user_params[:password].blank?
      result_info(I18n.t 'error.username_or_password_failed',nil)
    else
      # Check username & password
      user = authenticate(user_params[:username], user_params[:password])
      if user.blank?
        result_info(I18n.t 'error.login_failed',user_params)
      else
        result_info(I18n.t('error.success_code'),User.select(:token, :id, :permission).find(user.id),"Account login successfully")
      end
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21944
  #
  def self.get_user_info(user_id)
    begin
      select(
          :username, :first_name, :last_name, :display_name, :birthday, :permission,
          :avatar, :gender, :email, :address, :status, :created_at, :updated_at
      ).find(user_id)
    rescue => e
      nil
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21943
  # PUT/PATCH apis/:id/update_user_info
  def self.update_user(user_id,user_params)
    begin
      user = update(user_id,user_params)
      result_info(I18n.t('error.success_code'),user_params,"Update user info successfully")
    rescue => e
      result_info(I18n.t('error.update_user'),nil,"Update user failed:#{e.to_s}")
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21947
  # PUT/PATCH apis/:id/change_password
  def self.change_password(user_id,user_params)
    # compare password
    user = authenticate(User.find(user_id).username, user_params[:password])
    if user
      salt = BCrypt::Engine.generate_salt
      pass = BCrypt::Engine.hash_secret(user_params[:password_new], salt)
      where(:id => user_id).update_all(password: pass, password_salt: salt)
      result_info(I18n.t('error.success_code'),user_params,"Change password successfully.")
    else
      result_info(I18n.t('error.change_password_failed'),user_params)
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21947
  # GET apis/search_user_by_name/:keyword(/:limit/:offset
  def self.search_user_by_name(keyword, limit, offset)
    begin
      users = search(keyword).limit(limit).offset(offset)
      data = []
      for user in users
        temp_data = {id: user.id, username: user.username, first_name: user.first_name,
                     last_name: user.last_name, avatar: user.avatar}
        data << temp_data
      end
      result_info(I18n.t('error.success_code'),data,"search successfully.")
    rescue => e
      result_info(I18n.t('error.search_failed'))
    end
  end

  private
  def create_token
    self.token = SecureRandom.urlsafe_base64 if token.nil?
  end
  # Check login
  # Return: user object or nil
  def self.authenticate(username, password)
    user = where(username: username).first
    # Encrypt password to compare
    if user && user.password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end