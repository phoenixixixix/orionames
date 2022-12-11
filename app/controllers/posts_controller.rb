class PostsController < ApplicationController
  before_action :set_post, only: %w(show edit update)
  before_action :get_all_tags, except: :show
  def index
    @posts = Post.all
    @posts = @posts.tagged_with(tag_param[:tag]) if tag_param[:tag]

    @posts = @posts.page(params[:page])
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render "edit"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :tag_list, :photo_token)
  end

  def tag_param
    params.permit(:tag)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def get_all_tags
    @all_tags = ActsAsTaggableOn::Tag.all
  end
end