class Post < ActiveRecord::Base
	validates :body, :title, presence: true
  def self.addnew(title, body)
    post = Post.create(  body: body, title: title)
  end
end
