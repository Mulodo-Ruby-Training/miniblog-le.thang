class Post < ActiveRecord::Base
  extend ApplicationHelper
  # has_and_belongs_to_many :categories
  has_many :comments, class_name: 'Comment', foreign_key: 'id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  accepts_nested_attributes_for :comments

  validates_presence_of :title, uniq: false, :message => "asdasd"
  validates_presence_of :description, uniq: false, :message => "asdasd"
  validates_presence_of :content, uniq: false, :message => "asdasd"
  validates :thumbnail, format: {with: /\A*\.(JPEG|JPG|PNG|GIF|BMP|ICO)\z/i,:message => I18n.t('error.validate_image')}

  # Task https://my.redmine.jp/mulodo/issues/21951
  # POST apis/create_post
  # Create new post
  def self.create_post(user_id,post_params)
    begin
      data = {
          title: post_params[:title],
          description: post_params[:description],
          content: post_params[:content],
          thumbnail: post_params[:thumbnail],
          user_id: user_id
      }
      post = new(data)
      post.save!
      result_info(I18n.t('error.success_code'),Post.last.to_json, 'Create new post successful.')
    rescue => e
      if post && post.invalid?
        result_info(I18n.t 'error.validation',post_params, post.errors.to_s)
      else
        result_info(I18n.t('error.post_create_failed'),post_params,e.to_s)
      end
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21955
  # PUT/PATCH apis/update_post
  # Update post
  def self.update_post( post_id, post_params)
    begin
      data = {
          title: post_params[:title],
          description: post_params[:description],
          content: post_params[:content],
          thumbnail: post_params[:thumbnail]
      }
      post = update(post_id, data)
      result_info(I18n.t('error.success_code'),Post.find(post_id).to_json, 'Update new post successful.')
    rescue => e
      result_info(I18n.t('error.post_create_failed'),post_params, e.to_s)
    end
  end
  # Task https://my.redmine.jp/mulodo/issues/21955
  # PUT/PATCH apis/update_post
  # Update post
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

  def self.get_all_post_for_user(user_id, limit = 0, offset = 0)
    begin
      post = where(:user_id => user_id).limit(limit).offset(offset)
      result_info(I18n.t('error.success_code'),post, 'Update new post successful.')
    rescue
      result_info(I18n.t('error.get_all_post_for_user'),post_params)
    end
  end

  def self.active_post(post_id)
    begin
      # post is active or deactive
      current_active = Post.find(post_id)[:status].blank? ?  0:1
      active = current_active.blank? ? 1:0
      where(:status => current_active).update_all(:status => active)
      result_info(I18n.t('error.success_code'),Post.find(post_id), 'Change active new post successful.')
    rescue
      result_info(I18n.t('error.post_active_failed'),post_params)
    end
  end
end
