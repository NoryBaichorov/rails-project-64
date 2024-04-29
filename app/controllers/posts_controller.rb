# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate, only: %i[new create]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])

    @like = @post.likes.find_by(user: current_user)

    @comment = PostComment.new
    @comments = @post.comments.includes(:user).arrange
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:primary] = 'Пост был создан.'
      redirect_to @post
    else
      redirect_back(fallback_location: new_post_path)
      flash[:danger] = @post.errors.full_messages.join(' ')
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end