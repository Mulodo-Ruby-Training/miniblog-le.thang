class Post < ActiveRecord::Base
  extend ApplicationHelper
  # has_and_belongs_to_many :categories
  has_many :comments, class_name: 'Comment', foreign_key: 'id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  accepts_nested_attributes_for :comments
  attr_accessor :post_id

  validates :title, presence: true, length: {minimum: 10}, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}, uniqueness: true
  validates :content, presence: true, length: {minimum: 20}, uniqueness: true
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
      data = {
          title: post_params[:title],
          description: post_params[:description],
          content: post_params[:content],
          thumbnail: post_params[:thumbnail]
      }
      # For each user only update active your own post
      system_err  = system_err(post_params[:post_id], post_params[:user_id])
      if system_err
        update(post_params[:post_id].to_i, data)
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
  def self.active_post(post_id)
    begin
      # For each user only update active your own post
      system_err  = system_err(post_params[:post_id], post_params[:user_id])
      if system_err
        # post is active or deactive
        current_active = find(post_id).pluck(:status)[0]
        active = current_active == 0 ? 1:0
        where(:status => current_active).update_all(:status => active)
        result_info(I18n.t('error.success_code'),Post.find(post_id), 'Changed active new post successful.')
      else
        system_err
      end
    rescue
      result_info(I18n.t('error.post_active_failed'))
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21957
  # DELETE apis/delete_post
  def self.delete_post(post_params)
    begin
      # For each user only delete your own post
      system_err  = system_err(post_params[:post_id], post_params[:user_id])
      if system_err
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
      elsif user_id != where(id: post_id).pluck(:user_id)[0]
        result_info(I18n.t('error.permission_not_enough'))
      else
        true
      end
    end
end