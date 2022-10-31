class Api::PostsController < ApplicationController
  before_action :set_book, only: %i[ show update destroy ]
  def index
    @posts = Post.all
    @comments = Comment.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end
end
