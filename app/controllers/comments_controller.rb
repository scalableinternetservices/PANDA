class CommentsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  #   # GET /comments or /comments.json
  #   skip_before_action :verify_authenticity_token
    def index
      @comments = Comment.all
    end

     # GET /comments/1 or /comments/1.json
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    # puts "alsdjgafldkjhg"
    # puts params
    @comment = @post.comments.create(comment_params)
    if current_user
      @comment.user_id = current_user.id
    else
      @comment.user_id = params[:comment][:user_id]
    end
    # @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post), status: :see_other
  end


  private
  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body,:user_id,:post_id)
  end
end
