class Post < ActiveRecord::Base
  def self.addnew(title, body)
    post = Post.new
    post.title = title
    post.body = body
    post.save
  end
end
