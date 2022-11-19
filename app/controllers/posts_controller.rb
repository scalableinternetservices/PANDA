class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    puts Post.all
    @posts = Post.all.includes(:user, :tag)
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
    if !current_user
      @post.user_id = post_params[:user_id]
      current_user_post_fetch ||= User.find_by_id(post_params[:user_id]) if post_params[:user_id]
      @prevpoint = current_user_post_fetch.points.clone
      if @post.save
        @point_added = User.update(post_params[:user_id], :points => current_user_post_fetch.points + 20)
        user_instance = User.find(current_user_post_fetch.id)
        if @point_added && user_instance
          @currentpoint = user_instance.points
          notice = "Thanks for make a post. Your points successfully added:" + @prevpoint.to_s + "=>" + @currentpoint.to_s
          redirect_to user_path(post_params[:user_id]), notice: notice
        else
          render :new, status: :unprocessable_entity
        end
      else
        render :new, status: :unprocessable_entity
      end
    else
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
