class TagsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = Post.where(tag: params[:id]).all
  end

  def new
    # @currentuser = current_user()
    # puts "current user"
    # puts @current_user.points
  end

  def create
    @tag = Tag.new(name: params[:name], description: params[:description])
    @currentuser = current_user()
    @prevpoint = @currentuser.points.clone
    if @tag.save
      @point_added =  User.update(@current_user.id, :points => @current_user.points + 10)
      if @point_added
        @currentpoint = User.find(@current_user.id).points
        notice = "Thanks for creating tag. Your points successfully added:" + @prevpoint.to_s + "=>" + @currentpoint.to_s
        redirect_to user_path(@current_user.id), notice: notice
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
end
