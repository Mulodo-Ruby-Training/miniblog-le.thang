class Post < ActiveRecord::Base
  extend ApplicationHelper
  # has_and_belongs_to_many :categories
  has_many :comments, class_name: 'Comment', foreign_key: 'id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  accepts_nested_attributes_for :comments
  attr_accessor :post_id

  validates :title, presence: true, length: {minimum: 10}
  validates_uniqueness_of :title , :on => :create
  validates :description, presence: true, length: {minimum: 10}
  validates_uniqueness_of :description , :on => :create
  validates :content, presence: true, length: {minimum: 20}
  validates_uniqueness_of :content , :on => :create
  validates :thumbnail, format: {with: /\A*\.(JPEG|JPG|PNG|GIF|BMP|ICO)\z/i,:message => I18n.t('error.validate_image')}

  # Task https://my.redmine.jp/mulodo/issues/21951
  # POST apis/create_post
  # Create new post
  def self.create_post(post_params)
    begin
      data = {
          title: post_params[:title],
          description: post_params[:description],
          content: post_params[:content],
          thumbnail: post_params[:thumbnail],
          user_id: post_params[:user_id]
      }
      post = Post.new(data)
      post.save!
      result_info(I18n.t('error.success_code'),nil, 'Create new post successful.')
    rescue => e
      result_info(I18n.t('error.post_create_failed'),nil,e.to_s)
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21955
  # PUT/PATCH apis/update_post
  # Update post
  def self.update_post(post_params)
    begin
      # For each user only update active your own post
      system_err  = system_err(post_params[:post_id], post_params[:user_id])
      if system_err == true
        post = find(post_params[:post_id].to_i)
        post.title = post_params[:title]
        post.description = post_params[:description]
        post.content = post_params[:content]
        post.thumbnail = post_params[:thumbnail]
        post.save!
        result_info(I18n.t('error.success_code'),Post.find(post_params[:post_id]).to_json, 'Update new post successful.')
      else
        system_err
      end
    rescue => e
      result_info(I18n.t('error.post_update_failed'),nil,e.to_s)
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21960
  # GET apis/get_list_post(/:limit/:offset)
  def self.get_list_post(limit = 0, offset = 0)
    begin
      list_posts = limit(limit).offset(offset)
      result_info(I18n.t('error.success_code'),list_posts, 'Get list post successful.')
    rescue
      result_info(I18n.t('error.post_get_list_failed'),post_params)
    end
  end

  def self.get_a_post(post_id)
    begin
      post = where(:id => post_id)
      result_info(I18n.t('error.success_code'),post, 'Update new post successful.')
    rescue
      result_info(I18n.t('error.post_get_a_post_failed'),post_params)
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21961
  # GET apis/get_all_post_for_user
  def self.get_all_post_for_user(user_id, limit = 0, offset = 0)
    begin
      post = where(:user_id => user_id).limit(limit).offset(offset)
      result_info(I18n.t('error.success_code'),post.to_a, 'Get all post for user to successful.')
    rescue
      result_info(I18n.t('error.get_all_post_for_user'),post_params)
    end
  end

  # Task https://my.redmine.jp/mulodo/issues/21953
  # PUT/PATCH apis/:post_id/active_post/
  def self.active_post(post_params)
    begin
      # For each user only update active your own post
      system_err  = system_err(post_params[:post_id], post_params[:user_id])
      if system_err == true
        # post is active or deactive
        current_active = find(post_params[:post_id])[:status]
        active = current_active.blank? ? 1:0
        # active = find(post_params[:post_id].to_i)
        where(:id => post_params[:post_id].to_i).update_all(:status => active)
        result_info(I18n.t('error.success_code'),Post.find(post_params[:post_id].to_i), 'Changed active new post successful.')
      else
        system_err
      end
    rescue => e
      result_info(I18n.t('error.post_active_failed'), nil, e.to_s)
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21957
  # DELETE apis/delete_post
  def self.delete_post(post_params)
    begin
      # For each user only delete your own post
      system_err  = system_err(post_params[:post_id], post_params[:user_id])
      if system_err == true
        find(post_params[:post_id]).destroy
        result_info(I18n.t('error.success_code'),nil, 'Deleted post successsful.')
      else
        system_err
      end
    rescue => e
      result_info(I18n.t('error.post_delete_failed'), e.to_s)
    end
  end
  #
  private
    def self.system_err(post_id, user_id)
      # For each user only delete your own post
      if where(id: post_id).blank?
        result_info(I18n.t('error.miss_record_trouble'))
      elsif user_id.to_i != where(id: post_id).pluck(:user_id)[0]
        result_info(I18n.t('error.permission_not_enough'))
      else
        true
      end
    end
end