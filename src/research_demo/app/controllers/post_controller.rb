class PostController < ApplicationController
  def index
    @post = Post.all
  end

  def create
    title = params[:title].nil? ? '':params[:tile]
    body =params[:body].nil? ? '':params[:body]
    result = Post.addnew(title, body)
    render :json => result
  end
end
