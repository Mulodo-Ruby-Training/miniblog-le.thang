class PostsController < ApisController
  def index
  end

  def new
  end

  def update
  end

  def delete
    # respond_to do |format|
      # format.html { redirect_to apis_create_post_path }

    render :text => delete_post[:meta]
    # end
  end

  def get_list
  end

  def post_of_user
  end

  def show
  end

  def active_post
  end
end
