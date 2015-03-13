class Post < ActiveRecord::Base
  # has_and_belongs_to_many :categories
  has_many :comments, class_name: 'Comment', foreign_key: 'id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
end
