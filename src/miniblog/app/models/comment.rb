class Comment < ActiveRecord::Base
  extend ApplicationHelper
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  accepts_nested_attributes_for :post

  validates :content, presence: true, length: {minimum: 15}
  validates_uniqueness_of :content, on: :create

  # https://my.redmine.jp/mulodo/issues/21964
  # Coding/実装 #21964: Add Comment
  def self.create_comment(com_params)
    begin
      data = {
          :content => com_params[:content],
          :user_id => com_params[:user_id],
          :post_id => com_params[:post_id],
          :parent_id => com_params[:parent_id]
      }
      comm = Comment.new(data)
      comm.save!
      result_info(I18n.t('error.success_code'),nil, 'Create new comment successful.')
    rescue => e
      result_info(I18n.t('error.post_create_failed'),nil,e.to_s)
    end
  end

  # https://my.redmine.jp/mulodo/issues/21966
  # Coding/実装 #21966: Edit Comment
  # 20/3/2015
  def self.update_comment(comm_params)
    begin
      err = err_user_and_record(comm_params[:user_id],comm_params[:comment_id])
      if err == true
        comm = find(comm_params[:comment_id].to_i)
        comm.content = comm_params[:content]
        comm.save!
        result_info(I18n.t('error.success_code'),nil, 'Update comment successful.')
      else
        err
      end
    rescue => e
      result_info(I18n.t('error.comm_update_failed'), nil, e.to_s)
    end
  end

  # https://my.redmine.jp/mulodo/issues/21968
  # Coding/実装 #21968: Delete Comment
  def self.delete_comment(comm_params)
    begin
      err = err_user_and_record(comm_params[:user_id],comm_params[:comment_id])
      if err == true
        find(comm_params[:comment_id].to_i).destroy
        result_info(I18n.t('error.success_code'),nil, 'Delete comment successful.')
      else
        err
      end
    rescue => e
      result_info(I18n.t('error.comm_delete_failed'), nil, e.to_s)
    end
  end

  # https://my.redmine.jp/mulodo/issues/21970
  # Coding/実装 #21970: Get All Comments for a Post
  def self.get_all_comment_for_a_post(post_id, limit, offset)
    begin
      comm_list = where(post_id: post_id).limit(limit).offset(offset)
      result_info(I18n.t('error.success_code'),comm_list.to_json,'Get all comment for a post successful.')
    rescue => e
      result_info(I18n.t('error.comm_for_a_post_failed'), nil, e.to_s)
    end
  end

  # https://my.redmine.jp/mulodo/issues/21972
  # Coding/実装 #21972: Get All Comments for User
  def self.get_all_comment_for_user(user_id, limit, offset)
    begin
      comm_list = where(user_id: user_id).limit(limit).offset(offset)
      result_info(I18n.t('error.success_code'),comm_list.to_json,'Get all comment for user successful.')
    rescue => e
      result_info(I18n.t('error.comm_for_user_failed'), nil, e.to_s)
    end
  end

  private
  def self.err_user_and_record(user_id, comment_id)
    if where(id: comment_id).blank?
      result_info(I18n.t('error.miss_record_trouble'))
    elsif user_id.to_i != where(:id => comment_id).pluck(:user_id)[0]
      result_info(I18n.t('error.permission_not_enough') )
    else
      true
    end
  end
end
