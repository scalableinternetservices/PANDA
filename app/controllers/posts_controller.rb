class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    puts Post.all
    @posts = Post.all
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    @prevpoint = current_user.points.clone
    if @post.save
      @point_added = User.update(current_user.id, :points => current_user.points + 20)
      user_instance = User.find(current_user.id)
      if @point_added && user_instance
        @currentpoint = user_instance.points
        notice = "Thanks for make a post. Your points successfully added:" + @prevpoint.to_s + "=>" + @currentpoint.to_s
        redirect_to user_path(current_user.id), notice: notice
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :tag_id, :points2view, :user_id)
    end
end
